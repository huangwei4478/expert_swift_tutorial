import UIKit

var int16Value: UInt16 = 0x1112
MemoryLayout.size(ofValue: int16Value)
MemoryLayout.alignment(ofValue: int16Value)
MemoryLayout.stride(ofValue: int16Value)

let int16bytesPointer = UnsafeMutableRawPointer.allocate(byteCount: 2, alignment: 2)

defer {
	int16bytesPointer.deallocate()
}

int16bytesPointer.storeBytes(of: 0x1122, as: UInt16.self)

let firstByte = int16bytesPointer.load(as: UInt8.self)
let offsetPointer = int16bytesPointer + 1

let secondByte = offsetPointer.load(as: UInt8.self)

// UB!
let offsetPointer2 = int16bytesPointer + 2
let thirdByte = offsetPointer2.load(as: UInt8.self)

// Raw buffer pointer
let size = MemoryLayout<UInt>.size
let alignment = MemoryLayout<UInt>.alignment

let bytesPointer = UnsafeMutableRawPointer.allocate(byteCount: size, alignment: alignment)
defer {
	bytesPointer.deallocate()
}

bytesPointer.storeBytes(of: UInt(0x0102030405060708.bigEndian), as: UInt.self)

let bufferPointer = UnsafeRawBufferPointer(start: bytesPointer, count: 8)
for (offset, byte) in bufferPointer.enumerated() {
	print("byte \(offset): \(byte)")
}

// Typed pointer

let count = 4

let pointer = UnsafeMutablePointer<Int>.allocate(capacity: count)
pointer.initialize(repeating: 0, count: count)

defer {
	pointer.deinitialize(count: count)
	pointer.deallocate()
}

// 3
pointer.pointee = 10001
pointer.advanced(by: 1).pointee = 10002
(pointer + 2).pointee = 10003

let typedBufferPointer = UnsafeBufferPointer(start: pointer, count: count)
for (offset, value) in typedBufferPointer.enumerated() {
	print("value \(offset): \(value)")
}

// Memory Binding: Specifying an area in memory as a value of a specific type
// 内存绑定：把一片内存区域指定为某个类型的值(some type)
// P.S. 难道说，Swift 的指针操作其实是比 C/C++ 还要强？

// Punning: a part of memory is bound to a type, then you bind it to a different and unrelated type (UB!)

let rawPointer = UnsafeMutableRawPointer.allocate(byteCount: 2, alignment: 2)

defer {
	rawPointer.deallocate()
}

// 同一片内存的两种不同的视角：2-byte 的 float，或者是 两个 1-byte 的 UInt8
let float16Pointer = rawPointer.bindMemory(to: Float16.self, capacity: 1)
let uint8pointer = rawPointer.bindMemory(to: UInt8.self, capacity: 2)

float16Pointer.pointee = 0xABC0

uint8pointer.pointee
(uint8pointer + 1).pointee
uint8pointer.advanced(by: 1).pointee

