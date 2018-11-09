import APIKit
import Foundation
import Hydra

class Environment: EnvironmentProvider {
    func apply<Request: APIKit.Request>(request: Request) -> Promise<Request.Response> {
        return Promise<Request.Response>(in: .background, { resolve, reject, _ in
            Session.send(request) { result in
                switch result {
                case .success(let posts):
                    resolve(posts)
                case .failure(let error):
                    reject(error)
                }
            }
        })
    }
}
