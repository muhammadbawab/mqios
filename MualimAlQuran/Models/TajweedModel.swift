import Foundation

class TajweedModel: ObservableObject, Identifiable, Decodable {
    
    var id: Int = 0
    var Intro: String = ""
    var IntroText: String = ""
    var Letters: String = ""
    var LettersText: String = ""
    var _Letters: String = ""
    var _LettersAudio: String = ""
    var Method: String = ""
    var MethodText: String = ""
    var Sign: String = ""
    var SignText: String = ""
    var SignText2: String = ""
    var SignText3: String = ""
    var SignText4: String = ""
    var Examples: String = ""
    var `Type`: String = ""
    
    init() {
        
    }
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id = "id"
        case Intro = "Intro"
        case IntroText = "IntroText"
        case Letters = "Letters"
        case LettersText = "LettersText"
        case _Letters = "_Letters"
        case _LettersAudio = "_LettersAudio"
        case Method = "Method"
        case MethodText = "MethodText"
        case Sign = "Sign"
        case SignText = "SignText"
        case SignText2 = "SignText2"
        case SignText3 = "SignText3"
        case SignText4 = "SignText4"
        case Examples = "Examples"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        Intro = try values.decodeIfPresent(String.self, forKey: .Intro) ?? ""
        IntroText = try values.decodeIfPresent(String.self, forKey: .IntroText) ?? ""
        Letters = try values.decodeIfPresent(String.self, forKey: .Letters) ?? ""
        LettersText = try values.decodeIfPresent(String.self, forKey: .LettersText) ?? ""
        _Letters = try values.decodeIfPresent(String.self, forKey: ._Letters) ?? ""
        _LettersAudio = try values.decodeIfPresent(String.self, forKey: ._LettersAudio) ?? ""
        Method = try values.decodeIfPresent(String.self, forKey: .Method) ?? ""
        MethodText = try values.decodeIfPresent(String.self, forKey: .MethodText) ?? ""
        Sign = try values.decodeIfPresent(String.self, forKey: .Sign) ?? ""
        SignText = try values.decodeIfPresent(String.self, forKey: .SignText) ?? ""
        SignText2 = try values.decodeIfPresent(String.self, forKey: .SignText2) ?? ""
        SignText3 = try values.decodeIfPresent(String.self, forKey: .SignText3) ?? ""
        SignText4 = try values.decodeIfPresent(String.self, forKey: .SignText4) ?? ""
        Examples = try values.decodeIfPresent(String.self, forKey: .Examples) ?? ""
    }
    
    func copy(id: Int, type: String, with zone: NSZone? = nil) -> TajweedModel {
        let copy = TajweedModel()
        copy.id = id
        copy.Intro = self.Intro
        copy.IntroText = self.IntroText
        copy.Letters = self.Letters
        copy.LettersText = self.LettersText
        copy._Letters = self._Letters
        copy._LettersAudio = self._LettersAudio
        copy.Method = self.Method
        copy.MethodText = self.MethodText
        copy.Sign = self.Sign
        copy.SignText = self.SignText
        copy.SignText2 = self.SignText2
        copy.SignText3 = self.SignText3
        copy.SignText4 = self.SignText4
        copy.Examples = self.Examples
        copy.`Type` = type
        
        return copy
    }
}
