import UIKit

struct CountdownIterator: IteratorProtocol {
	typealias Element = Int
	
	var count: Int
	
	mutating func next() -> Int? {
		guard count >= 0 else {
			return nil
		}
		
		defer { count -= 1 }
		return count
	}
}

struct CountDown: Sequence {
	typealias Iterator = CountdownIterator
	
	let start: Int
	
	func makeIterator() -> CountdownIterator {
		return CountdownIterator(count: start)
	}
}

for i in CountDown(start: 5) {
	print(i)
}
