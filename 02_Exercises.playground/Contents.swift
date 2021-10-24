/// Sample code from the book, Expert Swift,
/// published at raywenderlich.com, Copyright (c) 2021 Razeware LLC.
/// See LICENSE for details. Thank you for supporting our work!
/// Visit https://www.raywenderlich.com/books/expert-swift

import Foundation
import Darwin

// 1. Generate 100 random points in the unit circle.
// How many are found in the second quadrant?
// Demonstrate the solution with code.
// Use `PermutedCongruential` with the seed 4321
// to make your answer repeatable.

var total = 0
var pcg = PermutedCongruential.init(seed: 4321)
for _ in 1 ... 100 {
    if Quadrant.init(Point.random(inRadius: 1.0, using: &pcg)) == .ii {
        total += 1
    }
}

print(total)

// 2. How many cups in 1.5 liters? Use
// Foundation’s `Measurement` types to figure it out.
let liters = Measurement.init(value: 1.5, unit: UnitVolume.liters)
let cups = liters.converted(to: .cups)
print(cups)


// 3. Create an initializer for `Quadrant` that takes
// a polar coordinate.
extension Quadrant {
    init?(_ polar: Polar) {
        self.init(Point(polar))
    }
}
