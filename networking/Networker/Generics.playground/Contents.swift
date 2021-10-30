import UIKit

func replacingNilValues<T>(from array: [T?], with element: T) -> [T] {
	array.compactMap { $0 == nil ? element : $0 }
}

let numbers = [32, 1, 3, nil, 4, 3]
let filledNumbers = replacingNilValues(from: numbers, with: 0)
print(filledNumbers)

struct Preference<T> {
	let key: String
	var value: T? {
		get {
			UserDefaults.standard.value(forKey: key) as? T
		}
		set {
			UserDefaults.standard.setValue(newValue, forKey: key)
		}
	}
}

extension Preference {
	mutating func save(from untypedValue: Any) {
		if let value = untypedValue as? T {
			self.value = value
		}
	}
}

//extension Preference where T: Decodable {
//	mutating func save(from json: Data) throws {
//		let decoder = JSONDecoder()
//		self.value = try decoder.decode(T.self, from: json)
//	}
//}

// just constrain on a single method

extension Preference {
	mutating func save(from json: Data) throws where T: Decodable {
		let decoder = JSONDecoder()
		self.value = try decoder.decode(T.self, from: json)
	}
}
