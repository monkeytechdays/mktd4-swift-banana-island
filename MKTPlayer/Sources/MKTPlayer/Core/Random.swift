#if os(Linux)
import Glibc

func randomNumber(_ max: Int) -> Int {
    return Int(random() % (max + 1))
}
#else
import Foundation

func randomNumber(_ max: Int) -> Int {
    return Int(arc4random_uniform(UInt32(max)))
}
#endif
