import Foundation

struct UserEntity: Codable {
    var id: String
    var profileImageURL: URL? {
        return URL(string: profile_image_url)
    }

    private let profile_image_url: String
}
