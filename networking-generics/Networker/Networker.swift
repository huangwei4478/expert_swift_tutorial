/// Sample code from the book, Expert Swift,
/// published at raywenderlich.com, Copyright (c) 2021 Razeware LLC.
/// See LICENSE for details. Thank you for supporting our work!
/// Visit https://www.raywenderlich.com/books/expert-swift

import Foundation
import Combine
import UIKit

protocol NetworkingDelegate: AnyObject {
  func headers(for networking: Networking) -> [String: String]

  func networking(
    _ networking: Networking,
    transformPublisher: AnyPublisher<Data, URLError>
  ) -> AnyPublisher<Data, URLError>
}

extension NetworkingDelegate {
  func headers(for networking: Networking) -> [String: String] {
    [:]
  }

  func networking(
    _ networking: Networking,
    transformPublisher publisher: AnyPublisher<Data, URLError>
  ) -> AnyPublisher<Data, URLError> {
    publisher
  }
}

protocol Networking {
  var delegate: NetworkingDelegate? { get set }
	func fetch<R: Request>(_ request: R) -> AnyPublisher<R.Output, Error>
	func fetch<T: Decodable>(url: URL) -> AnyPublisher<T, Error>
}

class Networker: Networking {
  weak var delegate: NetworkingDelegate?
	
	private let imageCache = RequestCache<UIImage>()

	func fetch<R: Request>(_ request: R) -> AnyPublisher<R.Output, Error> {
    var urlRequest = URLRequest(url: request.url)
    urlRequest.httpMethod = request.method.rawValue
    urlRequest.allHTTPHeaderFields = delegate?.headers(for: self)

		var publisher = URLSession.shared
      .dataTaskPublisher(for: urlRequest)
      .compactMap { $0.data }
      .eraseToAnyPublisher()

		if let delegate = delegate {
			publisher = delegate.networking(self, transformPublisher: publisher)
		}
		
		return publisher.tryMap(request.decode).eraseToAnyPublisher()
  }
	
	func fetch<T>(url: URL) -> AnyPublisher<T, Error> where T : Decodable {
		URLSession.shared.dataTaskPublisher(for: url)
			.map({ $0.data })
			.decode(type: T.self, decoder: JSONDecoder())
			.eraseToAnyPublisher()
	}
	
	
}
