import Foundation

class QLExModel: ObservableObject, Identifiable, Decodable {
    
    var id: Int = 0
    var QLID: String = ""
    var Value: String = ""
    var Verse: String = ""

    var VerseText: String = ""
    var VerseTranslation: String = ""
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id = "id"
        case QLID = "QLID"
        case Value = "Value"
        case Verse = "Verse"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        QLID = try values.decodeIfPresent(String.self, forKey: .QLID) ?? ""
        Value = try values.decodeIfPresent(String.self, forKey: .Value) ?? ""
        Verse = try values.decodeIfPresent(String.self, forKey: .Verse) ?? ""
    }
}
