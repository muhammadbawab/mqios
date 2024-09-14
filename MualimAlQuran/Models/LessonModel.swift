import Foundation

class LessonModel: ObservableObject, Identifiable, Decodable {
        
    var headerID: String = ""
    var headerTitle: String = ""
    var headerLessonTitle: String = ""
    var headerSummary: String = ""
    var headerProgress: Bool = true
    var id: Int = 0
    var Title: String = ""
    var Summary: String = ""
    var Letter: String = ""
    var LetterFragments: Bool = false
    var LetterFragment1: String = ""
    var LetterFragment2: String = ""
    var LetterFragment3: String = ""
    var Sound: String = ""
    var Trans: String = ""
    var _Top: String = ""
    var _TopFr1: String = ""
    var _TopFr2: String = ""
    var _TopFr3: String = ""
    var _liclass: String = ""
    var _class: String = ""
    var TransH1: String = ""
    var TransH2: String = ""
    var TransH3: String = ""
    var TransT1: String = ""
    var TransT2: String = ""
    var TransT3: String = ""
    var Arti: String = ""
    
    var section = false
    var sectionID = ""
    var active: Bool = false
    var activeInstructions: Bool = false
    var separator: Bool = false
    var separatorCol: Bool = false
    var letterPosition: Int = 0
    var audioLesson: String = ""
    var audioFile: Int = 0
    var vowel1: Bool = false
    var vowel1Left: Int = 0
    var vowel1Top: Int = 0
    var vowel2: Bool = false
    var vowel2Left: Int = 0
    var vowel2Top: Int = 0
    var vowel3: Bool = false
    var vowel3Left: Int = 0
    var vowel3Top: Int = 0
    var vowel4: Bool = false
    var vowel4Left: Int = 0
    var vowel4Top: Int = 0
    var vowel5: Bool = false
    var vowel5Left: Int = 0
    var vowel5Top: Int = 0
    var section2: Bool = false
    var title1: String = ""
    
    init() {
        
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case Letter = "Letter"
        case Sound = "Sound"
        case Trans = "Trans"
        case _Top = "_Top"
        case _liclass = "_liclass"
        case _class = "_class"
        case TransH1 = "TransH1"
        case TransH2 = "TransH2"
        case TransH3 = "TransH3"
        case TransT1 = "TransT1"
        case TransT2 = "TransT2"
        case TransT3 = "TransT3"
        case Arti = "Arti"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        Letter = try values.decodeIfPresent(String.self, forKey: .Letter) ?? ""
        Sound = try values.decodeIfPresent(String.self, forKey: .Sound) ?? ""
        Trans = try values.decodeIfPresent(String.self, forKey: .Trans) ?? ""
        _Top = try values.decodeIfPresent(String.self, forKey: ._Top) ?? ""
        _liclass = try values.decodeIfPresent(String.self, forKey: ._liclass) ?? ""
        _class = try values.decodeIfPresent(String.self, forKey: ._class) ?? ""
        TransH1 = try values.decodeIfPresent(String.self, forKey: .TransH1) ?? ""
        TransH2 = try values.decodeIfPresent(String.self, forKey: .TransH2) ?? ""
        TransH3 = try values.decodeIfPresent(String.self, forKey: .TransH3) ?? ""
        TransT1 = try values.decodeIfPresent(String.self, forKey: .TransT1) ?? ""
        TransT2 = try values.decodeIfPresent(String.self, forKey: .TransT2) ?? ""
        TransT3 = try values.decodeIfPresent(String.self, forKey: .TransT3) ?? ""
        Arti = try values.decodeIfPresent(String.self, forKey: .Arti) ?? ""
    }
    
    func copy(with zone: NSZone? = nil) -> LessonModel {
        
        let copy = LessonModel()
        
        copy.headerID           = self.headerID
        copy.headerTitle        = self.headerTitle
        copy.headerLessonTitle  = self.headerLessonTitle
        copy.headerSummary      = self.headerSummary
        copy.headerProgress     = self.headerProgress
        copy.id                 = self.id
        copy.Title              = self.Title
        copy.Summary            = self.Summary
        copy.Letter             = self.Letter
        copy.LetterFragments    = self.LetterFragments
        copy.LetterFragment1    = self.LetterFragment1
        copy.LetterFragment2    = self.LetterFragment2
        copy.LetterFragment3    = self.LetterFragment3
        copy.Sound              = self.Sound
        copy.Trans              = self.Trans
        copy._Top               = self._Top
        copy._TopFr1            = self._TopFr1
        copy._TopFr2            = self._TopFr2
        copy._TopFr3            = self._TopFr3
        copy._liclass           = self._liclass
        copy._class             = self._class
        copy.TransH1            = self.TransH1
        copy.TransH2            = self.TransH2
        copy.TransH3            = self.TransH3
        copy.TransT1            = self.TransT1
        copy.TransT2            = self.TransT2
        copy.TransT3            = self.TransT3
        copy.Arti               = self.Arti
        
        copy.section            = self.section
        copy.sectionID          = self.sectionID
        copy.active             = self.active
        copy.activeInstructions = self.activeInstructions
        copy.separator          = self.separator
        copy.separatorCol       = self.separatorCol
        copy.letterPosition     = self.letterPosition
        copy.audioLesson        = self.audioLesson
        copy.audioFile          = self.audioFile
        copy.vowel1             = self.vowel1
        copy.vowel1Left        = self.vowel1Left
        copy.vowel1Top       = self.vowel1Top
        copy.vowel2             = self.vowel2
        copy.vowel2Left        = self.vowel2Left
        copy.vowel2Top       = self.vowel2Top
        copy.vowel3             = self.vowel3
        copy.vowel3Left        = self.vowel3Left
        copy.vowel3Top       = self.vowel3Top
        copy.vowel4             = self.vowel4
        copy.vowel4Left        = self.vowel4Left
        copy.vowel4Top       = self.vowel4Top
        copy.vowel5             = self.vowel5
        copy.vowel5Left        = self.vowel5Left
        copy.vowel5Top       = self.vowel5Top
        copy.section2           = self.section2
        copy.title1             = self.title1
        
        return copy
    }
}
