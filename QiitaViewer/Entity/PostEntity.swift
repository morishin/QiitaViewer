import Foundation

struct PostEntity: Codable {
    var id: String
    var title: String
    var likesCount: Int {
        return likes_count
    }
    var user: UserEntity

    private let likes_count: Int
}
