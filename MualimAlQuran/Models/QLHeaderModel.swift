import Foundation

class QLHeaderModel: ObservableObject, Identifiable, Decodable {
    
    var id: Int = 0
    var QLID: Int = 0
    var StartOver: Bool = false
    var IntroText: String = ""
    var Title: String = ""
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id = "id"
        case QLID = "QLID"
        case StartOver = "StartOver"
        case IntroText = "IntroText"
        case Title = "Title"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        QLID = try values.decodeIfPresent(Int.self, forKey: .QLID) ?? 0
        StartOver = try Bool(values.decodeIfPresent(String.self, forKey: .StartOver)?.description.lowercased() ?? "false") ?? false
        IntroText = try values.decodeIfPresent(String.self, forKey: .IntroText) ?? ""
        Title = try values.decodeIfPresent(String.self, forKey: .Title) ?? ""
    }
}
