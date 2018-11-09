import APIKit
import Foundation
import Hydra

protocol EnvironmentProvider {
    func apply<Request: APIKit.Request>(request: Request) -> Promise<Request.Response>
}
