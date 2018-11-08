import Foundation
import APIKit

struct GetPostsRequest: Request {
    typealias Response = [PostEntity]

    var baseURL = URL(string: "https://qiita.com/api/v2")!
    var method: HTTPMethod = .get
    var path: String = "/items"

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> [PostEntity] {
        guard let postsDictionary = object as? [[String: AnyObject]],
            let postsJSON = try? JSONSerialization.data(withJSONObject: postsDictionary)
        else {
            throw ResponseError.unexpectedObject(object)
        }
        return try JSONDecoder().decode(Response.self, from: postsJSON)
    }
}
