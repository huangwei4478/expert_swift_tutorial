/// Sample code from the book, Expert Swift,
/// published at raywenderlich.com, Copyright (c) 2021 Razeware LLC.
/// See LICENSE for details. Thank you for supporting our work!
/// Visit https://www.raywenderlich.com/books/expert-swift

import XCTest
import Combine
@testable import Networker

class ArticlesViewModelTests: XCTestCase {
  // swiftlint:disable:next implicitly_unwrapped_optional
  var viewModel: ArticlesViewModel!
  var cancellables: Set<AnyCancellable> = []

  override func setUpWithError() throws {
    try super.setUpWithError()
  }

  func testArticlesAreFetchedCorrectly() {
  }
}
