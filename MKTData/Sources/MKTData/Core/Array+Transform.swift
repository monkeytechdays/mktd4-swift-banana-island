/**
 * MKTD#4
 */

public extension Array {

    func transform<Result>(_ f:(Element)-> Result?) -> [Result]? {
        let values = self.map(f).filter{$0 != nil}.map{ $0! }

        if values.count < self.count {
            return nil
        }

        return values
    }

}
