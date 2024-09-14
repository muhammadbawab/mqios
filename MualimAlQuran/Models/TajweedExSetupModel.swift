import Foundation

class TajweedExSetupModel: ObservableObject, Identifiable, Decodable {
    
    var id: Int = 0
    var ColumnCount: Int = 0
    var Col1: String = ""
    var Col2: String = ""
    var Col3: String = ""
    var Col4: String = ""
    
    init() {
        
    }
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id = "id"
        case ColumnCount = "ColumnCount"
        case Col1 = "Col1"
        case Col2 = "Col2"
        case Col3 = "Col3"
        case Col4 = "Col4"        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        ColumnCount = try values.decodeIfPresent(Int.self, forKey: .ColumnCount) ?? 0
        Col1 = try values.decodeIfPresent(String.self, forKey: .Col1) ?? ""
        Col2 = try values.decodeIfPresent(String.self, forKey: .Col2) ?? ""
        Col3 = try values.decodeIfPresent(String.self, forKey: .Col3) ?? ""
        Col4 = try values.decodeIfPresent(String.self, forKey: .Col4) ?? ""
    }
}
