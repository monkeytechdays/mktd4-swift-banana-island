import SwiftyJSON

extension Move {

    convenience init?(json: JSON) {
        guard let id = json["id"].number,
            let direction = json["move"].string.flatMap({ v in Direction(rawValue:v as String) })
         else {
            return nil
        }

        self.init(id:Int(id), direction:direction)
    }

}
