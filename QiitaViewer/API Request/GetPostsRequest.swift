import Foundation
import APIKit

struct GetPostsRequest: Request {
    typealias Response = [PostEntity]

    var baseURL = URL(string: "https://qiita.com/api/v2")!
    var method: HTTPMethod = .get
    var path: String = "/items"

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> [PostEntity] {
        guard let data = object as? Data else {
            throw ResponseError.unexpectedObject(object)
        }
        return try JSONDecoder().decode(Response.self, from: data)
    }
}
