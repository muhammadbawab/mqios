import Foundation

class RecitationModel: ObservableObject, Identifiable, Decodable, Equatable {
    
    var headerID: String = ""
    var headerTitle: String = ""
    var headerSubTitle: String = ""
    var headerSummary: String = ""
    var headerProgress = true
    var Words: [WordsModel] = []
    var id: Int = 0
    var StageID: String = ""
    var Surah: String = ""
    var SurahNameTr: String = ""
    var SurahName: String = ""
    var SurahNameAr: String = ""
    var Ayah: String = ""
    var Page: String = ""
    var Juzu: String = ""
    var Verse: String = ""
    var VerseColor: String = ""
    var Transliteration: String = ""
    var TransliterationColor: String = ""
    var Verse_: String = ""
    var isSurahName = false
    var isPage = false
    var active = false
    var basmalah = false
    var downloaded = false
    var memorized = false
    var memorizingCounter: Int = 0
    var memorizingStartOverCounter: Int = 0
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id = "id"
        case Surah = "Surah"
        case SurahNameTr = "SurahNameTr"
        case SurahName = "SurahName"
        case SurahNameAr = "SurahNameAr"
        case Ayah = "Ayah"
        case Page = "Page"
        case Juzu = "Juzu"
        case Verse = "Verse"
        case VerseColor = "VerseColor"
        case Transliteration = "Transliteration"
        case TransliterationColor = "TransliterationColor"
        case Verse_ = "Verse_"
        case Words = "Words"
    }
    
    init() {
        
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        Surah = try values.decodeIfPresent(Int.self, forKey: .Surah)?.description ?? ""
        SurahNameTr = try values.decodeIfPresent(String.self, forKey: .SurahNameTr) ?? ""
        SurahName = try values.decodeIfPresent(String.self, forKey: .SurahName) ?? ""
        SurahNameAr = try values.decodeIfPresent(String.self, forKey: .SurahNameAr) ?? ""
        Ayah = try values.decodeIfPresent(Int.self, forKey: .Ayah)?.description ?? ""
        Page = try values.decodeIfPresent(Int.self, forKey: .Page)?.description ?? ""
        Juzu = try values.decodeIfPresent(Int.self, forKey: .Juzu)?.description ?? ""
        Verse = try values.decodeIfPresent(String.self, forKey: .Verse) ?? ""
        VerseColor = try values.decodeIfPresent(String.self, forKey: .VerseColor) ?? ""
        Transliteration = try values.decodeIfPresent(String.self, forKey: .Transliteration) ?? ""
        TransliterationColor = try values.decodeIfPresent(String.self, forKey: .TransliterationColor) ?? ""
        Verse_ = try values.decodeIfPresent(String.self, forKey: .Verse_) ?? ""
        Words = try values.decodeIfPresent([WordsModel].self, forKey: .Words) ?? []
    }
    
    func copy(with zone: NSZone? = nil) -> RecitationModel {
        
        let copy = RecitationModel()
        
        copy.headerID           = self.headerID
        copy.headerTitle        = self.headerTitle
        copy.headerSubTitle     = self.headerSubTitle
        copy.headerSummary      = self.headerSummary
        copy.headerProgress     = self.headerProgress
        copy.Words              = self.Words
        copy.id                 = self.id
        copy.StageID            = self.StageID
        copy.Surah              = self.Surah
        copy.SurahNameTr        = self.SurahNameTr
        copy.SurahName          = self.SurahName
        copy.SurahNameAr        = self.SurahNameAr
        copy.Ayah               = self.Ayah
        copy.Page               = self.Page
        copy.Juzu               = self.Juzu
        copy.Verse              = self.Verse
        copy.VerseColor         = self.VerseColor
        copy.Transliteration    = self.Transliteration
        copy.TransliterationColor = self.TransliterationColor
        copy.Verse_             = self.Verse_
        copy.isSurahName        = self.isSurahName
        copy.isPage             = self.isPage
        copy.active             = self.active
        copy.basmalah           = self.basmalah
        copy.downloaded         = self.downloaded
        copy.memorized          = self.memorized
        copy.memorizingCounter  = self.memorizingCounter
        copy.memorizingStartOverCounter = self.memorizingStartOverCounter
        
        return copy
    }
    
    static func == (m1: RecitationModel, m2: RecitationModel) -> Bool {
        return m1.id == m2.id
    }
}

class WordsModel: ObservableObject, Identifiable, Decodable, Hashable, Equatable {
    var Verse: String = ""
    var Transliteration: String = ""
    var Word: String = ""
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(Word)
    }
    
    static func == (lhs: WordsModel, rhs: WordsModel) -> Bool {
        lhs.Verse == rhs.Verse && lhs.Transliteration == rhs.Transliteration && lhs.Word == rhs.Word
    }
}

class Memorizing: ObservableObject, Identifiable, Codable {
    var UserID: String = ""
    var Surah: String = ""
    var Ayah: String = ""
    var Verses: String = ""
    var Repetitions: String = ""
    var _From: String = ""
    var Date: String = ""
    var NewDate: String = ""
    var SurahName: String = ""
    var isTab = false
    var TabIndex: String = "1"
    var TabVisible = true
    var FromAyah: String = ""
    var ToAyah: String = ""
    
    init() {
        
    }
    
    init(Surah: String, SurahName: String, isTab: Bool, TabIndex: String, TabVisible: Bool) {
        self.Surah = Surah
        self.SurahName = SurahName
        self.isTab = isTab
        self.TabIndex = TabIndex
        self.TabVisible = TabVisible
    }
    
    init(Surah: String, SurahName: String, Ayah: String, FromAyah: String, ToAyah: String, TabIndex: String = "", TabVisible: Bool = false) {
        self.Surah = Surah
        self.SurahName = SurahName
        self.Ayah = Ayah
        self.FromAyah = FromAyah
        self.ToAyah = ToAyah
        self.TabIndex = TabIndex
        self.TabVisible = TabVisible
    }
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case UserID = "UserID"
        case Surah = "Surah"
        case SurahName = "SurahName"
        case Ayah = "Ayah"
        case Verses = "Verses"
        case Repetitions = "Repetitions"
        case _From = "_From"
        case Date = "Date"
        case NewDate = "NewDate"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        UserID = try values.decodeIfPresent(String.self, forKey: .UserID) ?? ""
        Surah = try values.decodeIfPresent(String.self, forKey: .Surah) ?? ""
        SurahName = try values.decodeIfPresent(String.self, forKey: .SurahName) ?? ""
        Ayah = try values.decodeIfPresent(String.self, forKey: .Ayah) ?? ""
        Verses = try values.decodeIfPresent(String.self, forKey: .Verses) ?? ""
        Repetitions = try values.decodeIfPresent(String.self, forKey: .Repetitions) ?? ""
        _From = try values.decodeIfPresent(String.self, forKey: ._From) ?? ""
        Date = try values.decodeIfPresent(String.self, forKey: .Date) ?? ""
        NewDate = try values.decodeIfPresent(String.self, forKey: .NewDate) ?? ""
    }
}
