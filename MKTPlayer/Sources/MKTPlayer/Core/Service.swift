import Kitura

public protocol Service {
    func addRoutes(_ router: Router)
}
