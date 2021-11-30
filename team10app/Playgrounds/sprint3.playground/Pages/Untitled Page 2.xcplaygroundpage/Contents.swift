//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

var hasher = Hasher()
hasher.combine("pword")
let passwordHash = hasher.finalize()
print(passwordHash)

//: [Next](@next)
