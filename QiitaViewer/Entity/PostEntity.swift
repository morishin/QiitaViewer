import Foundation

struct PostEntity: Codable {
    var id: String
    var title: String
    var likesCount: Int
    var user: UserEntity
}
