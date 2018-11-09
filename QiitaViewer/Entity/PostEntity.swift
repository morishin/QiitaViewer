import Foundation

struct PostEntity: Codable {
    var id: String
    var title: String
    var likesCount: Int {
        return likes_count
    }

    var user: UserEntity
    var createdDate: Date {
        return created_at
    }

    private let likes_count: Int
    private let created_at: Date
}
