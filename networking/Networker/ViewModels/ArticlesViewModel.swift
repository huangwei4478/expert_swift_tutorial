/// Sample code from the book, Expert Swift,
/// published at raywenderlich.com, Copyright (c) 2021 Razeware LLC.
/// See LICENSE for details. Thank you for supporting our work!
/// Visit https://www.raywenderlich.com/books/expert-swift

import SwiftUI
import Combine

class ArticlesViewModel: ObservableObject {
	var networker = Networker()
	
  @Published private(set) var articles: [Article] = []

  private var cancellables: Set<AnyCancellable> = []

  func fetchArticles() {
		let request = ArticleRequest()
		let decoder = JSONDecoder()
		networker.fetch(request)
			.decode(type: Articles.self, decoder: decoder)
			.map { $0.data.map { $0.article } }
			.replaceError(with: [])
			.receive(on: DispatchQueue.main, options: nil)
			.assign(to: \.articles, on: self)
			.store(in: &cancellables)
  }

  func fetchImage(for article: Article) {
		guard article.downloadedImage == nil,
					let articleIndex = articles.firstIndex(where: { $0.id == article.id })
		else {
			return
		}
		
		
  }
}
