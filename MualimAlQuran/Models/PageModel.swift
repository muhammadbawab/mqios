import Foundation

class PageModel: ObservableObject, Identifiable, Decodable {
    
    var id: String = ""
    var Title: String = ""
    var Description: String = ""
    
    init() {
        
    }
    
    init(id: String, Title: String) {
        self.id = id
        self.Title = Title
    }
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id = "id"
        case Title = "Title"
        case Description = "Description"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)?.description ?? ""
        Title = try values.decodeIfPresent(String.self, forKey: .Title) ?? ""
        Description = try values.decodeIfPresent(String.self, forKey: .Description) ?? ""
    }
}
