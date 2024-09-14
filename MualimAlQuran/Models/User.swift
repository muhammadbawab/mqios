import Foundation

class UserModel: Codable {
    var id: String = ""
    var Name: String = ""
    var Email: String = ""
    var Password: String = ""
    var Source: String = ""
    var Keep: String = ""
    var BookmarkID: String? = ""
    var BookmarkSurah: String? = ""
    var BookmarkSurahName: String? = ""
    var BookmarkAyah: String? = ""
    var Memorizing: String = ""
}

struct UserResponse: Codable {
    let code: Int
    let status: String?
    let message: String?
    let data: [UserModel]?
}
