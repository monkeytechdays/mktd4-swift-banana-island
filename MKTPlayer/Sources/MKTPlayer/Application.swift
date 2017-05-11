import Kitura

public struct Application {

    private let router: Router

    public init() {
        self.router = Router()
        // router.all(middleware: BodyParser())
    }

    public func start(port:Int = 8080) {
        // Add an HTTP server and connect it to the router
        Kitura.addHTTPServer(onPort: port, with: router)

        // Start the Kitura runloop (this call never returns)
        Kitura.run()
    }

    func addService(_ service: Service) {
        service.addRoutes(router)
    }

    public func stop() {
        Kitura.stop()
    }

}

//
// Operator used for service registration
//

infix operator <|: AdditionPrecedence

@discardableResult
public func <| (_ application: Application, _ service: Service) -> Application {
    application.addService(service)
    return application
}
