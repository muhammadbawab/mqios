import Foundation

class QLVocModel: ObservableObject, Identifiable, Decodable {
    
    var id: Int = 0
    var QLID: String = ""
    var Singular: String = ""
    var Plural: String = ""
    var Meaning: String = ""
    var Meaning2: String = ""
    var MeaningSwa: String = ""
    var MeaningFr: String = ""
    var MeaningPt: String = ""
    var MeaningEs: String = ""

    var WordIndex1: Int = 0
    var WordIndex2: Int = 0
    var WordIndex3: Int = 0
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id = "id"
        case QLID = "QLID"
        case Singular = "Singular"
        case Plural = "Plural"
        case Meaning = "Meaning"
        case Meaning2 = "Meaning2"
        case MeaningSwa = "MeaningSwa"
        case MeaningFr = "MeaningFr"
        case MeaningPt = "MeaningPt"
        case MeaningEs = "MeaningEs"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        QLID = try values.decodeIfPresent(String.self, forKey: .QLID) ?? ""
        Singular = try values.decodeIfPresent(String.self, forKey: .Singular) ?? ""
        Plural = try values.decodeIfPresent(String.self, forKey: .Plural) ?? ""
        Meaning = try values.decodeIfPresent(String.self, forKey: .Meaning) ?? ""
        Meaning2 = try values.decodeIfPresent(String.self, forKey: .Meaning2) ?? ""
        MeaningSwa = try values.decodeIfPresent(String.self, forKey: .MeaningSwa) ?? ""
        MeaningFr = try values.decodeIfPresent(String.self, forKey: .MeaningFr) ?? ""
        MeaningPt = try values.decodeIfPresent(String.self, forKey: .MeaningPt) ?? ""
        MeaningEs = try values.decodeIfPresent(String.self, forKey: .MeaningEs) ?? ""        
    }
}
