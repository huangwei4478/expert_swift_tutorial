/// Sample code from the book, Expert Swift,
/// published at raywenderlich.com, Copyright (c) 2021 Razeware LLC.
/// See LICENSE for details. Thank you for supporting our work!
/// Visit https://www.raywenderlich.com/books/expert-swift

import Foundation
import UIKit

struct ImageRequest: Request {
	typealias Output = UIImage
	
	enum Error: Swift.Error {
		case invalidData
	}
	
  let url: URL
  var method: HTTPMethod { .get }
	
	func decode(_ data: Data) throws -> UIImage {
		guard let image = UIImage(data: data) else {
			throw Error.invalidData
		}
		return image
	}
	
	
}
