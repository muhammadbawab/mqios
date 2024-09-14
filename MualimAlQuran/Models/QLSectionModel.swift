import Foundation

class QLSectionModel: ObservableObject, Identifiable, Decodable {
    
    var id: Int = 0
    var QLID: Int = 0
    var HeaderID: Int = 0
    var Title: String = ""
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id = "id"
        case QLID = "QLID"
        case HeaderID = "HeaderID"
        case Title = "Title"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        QLID = try values.decodeIfPresent(Int.self, forKey: .QLID) ?? 0
        HeaderID = try values.decodeIfPresent(Int.self, forKey: .HeaderID) ?? 0
        Title = try values.decodeIfPresent(String.self, forKey: .Title) ?? ""
    }
}
