import Foundation
import APIKit

struct GetPostsRequest: Request {
    typealias Response = [PostEntity]

    let baseURL = URL(string: "https://qiita.com/api/v2")!
    let method: HTTPMethod = .get
    let path: String = "/items"
    var page: Int = 1
    let perPage: Int = 20
    var parameters: Any? {
        return ["page": page, "per_page": perPage]
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> [PostEntity] {
        guard let postsDictionary = object as? [[String: AnyObject]],
            let postsJSON = try? JSONSerialization.data(withJSONObject: postsDictionary)
        else {
            throw ResponseError.unexpectedObject(object)
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(Response.self, from: postsJSON)
    }
}
