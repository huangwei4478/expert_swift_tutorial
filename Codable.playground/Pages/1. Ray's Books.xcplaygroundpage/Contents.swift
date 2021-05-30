//: [Previous](@previous)

import UIKit
import PlaygroundSupport

//: [Next](@next)

/// Sample code from the book, Expert Swift,
/// published at raywenderlich.com, Copyright (c) 2021 Razeware LLC.
/// See LICENSE for details. Thank you for supporting our work!
/// Visit https://www.raywenderlich.com/books/expert-swift

struct Book: Decodable {
    let id: String
    let name: String
    let authors: [String]
    let storeLink: URL
    let imageBlob: Data
    var image: UIImage? { UIImage(data: imageBlob) }
}

let data = API.getData(for: .rwBooks)
let decoder = JSONDecoder()
//decoder.keyDecodingStrategy = .convertFromSnakeCase
decoder.dataDecodingStrategy = .base64

enum CodingKeys: String, CodingKey {
    case id, name, authors
    case storeLink = "store_link"
    case imageBlob = "image_blob"
}

do {
    let books = try decoder.decode([Book].self, from: data)
    print("--- Example of: Books ---")
    for book in books {
        print("\(book.name) \(book.id) by \(book.authors.joined(separator: ", ")). Get it at: \(book.storeLink)")
        _ = book.image
    }
} catch {
    print("something went wrong: \(error)")
}
