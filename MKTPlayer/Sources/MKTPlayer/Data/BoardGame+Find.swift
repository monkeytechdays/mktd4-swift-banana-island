import MKTData

extension BoardGame {

    func findElements(_ predicate: @escaping (Int) -> Bool ) -> [(v:Int,x:Int,y:Int)] {
        return self.getBoardGame().enumerated().flatMap{ (j,c) in
            c.enumerated().flatMap{ (i,v) in predicate(v) ? [(v,i,j)] : [] }
        }
    }

}
