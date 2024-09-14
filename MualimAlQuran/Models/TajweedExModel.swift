import Foundation

class TajweedExModel: ObservableObject, Identifiable, Decodable {
    
    var id: Int = 0
    var Value: String = ""
    var `Type`: String = ""
    var Audio1: String = ""
    var Audio2: String = ""
    var Verse: String = ""
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id = "id"
        case Value = "Value"
        case `Type` = "Type"
        case Audio1 = "Audio1"
        case Audio2 = "Audio2"
        case Verse = "Verse"        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        Value = try values.decodeIfPresent(String.self, forKey: .Value) ?? ""
        `Type` = try values.decodeIfPresent(String.self, forKey: .Type) ?? ""
        Audio1 = try values.decodeIfPresent(String.self, forKey: .Audio1) ?? ""
        Audio2 = try values.decodeIfPresent(String.self, forKey: .Audio2) ?? ""
        Verse = try values.decodeIfPresent(String.self, forKey: .Verse) ?? ""
    }
}
