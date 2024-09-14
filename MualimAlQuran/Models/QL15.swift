import Foundation

class QL15: ObservableObject, Identifiable, Decodable {
    
    var id: Int = 0
    var Word1: String = ""
    var Word2: String = ""
    var Word3: String = ""
    var Word4: String = ""
    var Word5: String = ""
    var Word6: String = ""
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id = "id"
        case Word1 = "Word1"
        case Word2 = "Word2"
        case Word3 = "Word3"
        case Word4 = "Word4"
        case Word5 = "Word5"
        case Word6 = "Word6"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        Word1 = try values.decodeIfPresent(String.self, forKey: .Word1) ?? ""
        Word2 = try values.decodeIfPresent(String.self, forKey: .Word2) ?? ""
        Word3 = try values.decodeIfPresent(String.self, forKey: .Word3) ?? ""
        Word4 = try values.decodeIfPresent(String.self, forKey: .Word4) ?? ""
        Word5 = try values.decodeIfPresent(String.self, forKey: .Word5) ?? ""
        Word6 = try values.decodeIfPresent(String.self, forKey: .Word6) ?? ""
    }
}
