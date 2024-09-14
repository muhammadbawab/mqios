import Foundation

class QLWordModel: ObservableObject, Identifiable, Decodable {
    
    var id: Int = 0
    var SectionID: Int = 0
    var Word: String = ""
    var Word2: String = ""
    var Meaning: String = ""
    var Meaning2: String = ""
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id = "id"
        case SectionID = "SectionID"
        case Word = "Word"
        case Word2 = "Word2"
        case Meaning = "Meaning"
        case Meaning2 = "Meaning2"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        SectionID = try values.decodeIfPresent(Int.self, forKey: .SectionID) ?? 0
        Word = try values.decodeIfPresent(String.self, forKey: .Word) ?? ""
        Word2 = try values.decodeIfPresent(String.self, forKey: .Word2) ?? ""
        Meaning = try values.decodeIfPresent(String.self, forKey: .Meaning) ?? ""
        Meaning2 = try values.decodeIfPresent(String.self, forKey: .Meaning2) ?? ""
    }
}
