import UIKit

protocol StringConverter {
	associatedtype FromType
	
	func convert(value: FromType) -> String
}

struct SimpleStringConverter: StringConverter {
	typealias FromType = URL
	
	func convert(value: URL) -> String {
		return value.absoluteString
	}
}

struct TypeErasedStringConverter {
	let closure: (Any) -> String
	
	func convert(value: Any) -> String {
		return closure(value)
	}
}

var converters = [TypeErasedStringConverter]()

func registerConverter<C: StringConverter>(_ converter: C) {
	converters.append(.init(closure: { input in
		converter.convert(value: input as! C.FromType)
	}))
}


// 这里注册的 FromType 是一个 URL
registerConverter(SimpleStringConverter())

print(converters)

// 使用的时候，只能通过代码业务逻辑来保证类型安全
// 不是 URL 的话就要 crash 了
// converters[0].convert(value: 123) 		// crashed！
converters[0].convert(value: URL(string: "https://www.baidu.com")!)

protocol Request {
	associatedtype Response
	associatedtype Error: Swift.Error
	
	typealias Handler = (Result<Response, Error>) -> Void
	
	func perform(then handler: @escaping Handler)
}

// Type Erasure with Closure
class RequestQueue {
	private var queue = [() -> Void]()
	private var isPerformingRequest = false
	
	func add<R: Request>(_ request: R, handler: @escaping R.Handler) {
		
		// This closure will capture both the request and its handler, without exposing any of that type information outside of it, providing full type erasure
		
		// "(Result<Response, Error>) -> Void" erasued into
		// "() -> Void"
		let typeErased = {
			request.perform { [weak self] result in
				handler(result)
				self?.isPerformingRequest = false
				self?.performNextIfNeeded()
			}
		}
		
		queue.append(typeErased)
		performNextIfNeeded()
		
	}
	
	private func performNextIfNeeded() {
		guard !isPerformingRequest && !queue.isEmpty else {
			return
		}

		isPerformingRequest = true
		let closure = queue.removeFirst()
		closure()
	}
}
