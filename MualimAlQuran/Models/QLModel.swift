import Foundation

class QLModel: ObservableObject, Identifiable, Decodable {
    
    var id: Int = 0
    var Intro: String = ""
    var IntroText: String = ""
    var Vocabularies: String = ""
    var VocabulariesText: String = ""
    var Examples: String = ""
    var ExamplesText: String = ""

    var `Type`: String = ""
    var headerID: Int = 0
    var headerTitleIndex: Int = 1
    var sectionID: Int = 0
    var sectionIndex: Int = 0
    var lastWord: Bool = false

    var EmptyHeader: Bool = false
    var StartOver: Bool = false
    var StartOverTitle: String = ""

    var WordIndex: Int = 0
    var Word1: String = ""
    var Word2Index: Int = 0
    var Word2: String = ""
    var Word3Index: Int = 0
    var Word3: String = ""
    var Word4Index: Int = 0
    var Word4: String = ""
    var Word5Index: Int = 0
    var Word5: String = ""
    var Word6Index: Int = 0
    var Word6: String = ""
    var Meaning: String = ""
    var Meaning2Index: Int = 0
    var Meaning2: String = ""
    
    init(sectionID: Int) {
        self.sectionID = sectionID        
    }
    
    init(id: Int, Intro: String, IntroText: String, Type: String) {
        self.id = id
        self.Intro = Intro
        self.IntroText = IntroText
        self.Type = Type
    }
    
    init(id: Int, Intro: String, IntroText: String, Vocabularies: String, VocabulariesText: String, Examples: String, ExamplesText:String, Type: String) {
        self.id = id
        self.Intro = Intro
        self.IntroText = IntroText
        self.Vocabularies = Vocabularies
        self.VocabulariesText = VocabulariesText
        self.Examples = Examples
        self.ExamplesText = ExamplesText
        self.Type = Type
    }
    
    init(id: Int, headerID: Int, headerTitleIndex: Int, IntroText: String, Type: String, EmptyHeader: Bool, StartOver: Bool, StartOverTitle: String) {
        self.id = id
        self.headerID = headerID
        self.headerTitleIndex = headerTitleIndex
        self.IntroText = IntroText
        self.Type = Type
        self.EmptyHeader = EmptyHeader
        self.StartOver = StartOver
        self.StartOverTitle = StartOverTitle
    }
    
    init(id: Int, headerID: Int, IntroText: String, Type: String, EmptyHeader: Bool, sectionIndex: Int) {
        self.id = id
        self.headerID = headerID
        self.IntroText = IntroText
        self.Type = Type
        self.EmptyHeader = EmptyHeader
        self.sectionIndex = sectionIndex
    }
    
    init(id: Int, headerID: Int, sectionID: Int, Type: String, EmptyHeader: Bool, sectionIndex: Int) {
        self.id = id
        self.headerID = headerID
        self.sectionID = sectionID
        self.Type = Type
        self.EmptyHeader = EmptyHeader
        self.sectionIndex = sectionIndex
    }
    
    init(id: Int, headerID: Int, sectionID: Int, IntroText: String, Type: String, lastWord: Bool, WordIndex: Int, Word2: String, Meaning: String, Meaning2: String, EmptyHeader: Bool, sectionIndex: Int) {
        self.id = id
        self.headerID = headerID
        self.sectionID = sectionID
        self.IntroText = IntroText
        self.Type = Type
        self.lastWord = lastWord
        self.WordIndex = WordIndex
        self.Word2 = Word2
        self.Meaning = Meaning
        self.Meaning2 = Meaning2
        self.EmptyHeader = EmptyHeader
        self.sectionIndex = sectionIndex
    }
    
    init(id: Int, headerID: Int, sectionID: Int, Type: String, lastWord: Bool, /*WordIndex: Int,*/ Word1: String, Word2: String, Word3: String, Word4: String, Word5: String, Word6: String, EmptyHeader: Bool, sectionIndex: Int) {
        self.id = id
        self.headerID = headerID
        self.sectionID = sectionID
        self.Type = Type
        self.lastWord = lastWord
        //self.WordIndex = WordIndex
        self.Word1 = Word1
        self.Word2 = Word2
        self.Word3 = Word3
        self.Word4 = Word4
        self.Word5 = Word5
        self.Word6 = Word6
        self.EmptyHeader = EmptyHeader
        self.sectionIndex = sectionIndex
    }
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case id = "id"
        case Intro = "Intro"
        case IntroText = "IntroText"
        case Vocabularies = "Vocabularies"
        case VocabulariesText = "VocabulariesText"
        case Examples = "Examples"
        case ExamplesText = "ExamplesText"      
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        Intro = try values.decodeIfPresent(String.self, forKey: .Intro) ?? ""
        IntroText = try values.decodeIfPresent(String.self, forKey: .IntroText) ?? ""
        Vocabularies = try values.decodeIfPresent(String.self, forKey: .Vocabularies) ?? ""
        VocabulariesText = try values.decodeIfPresent(String.self, forKey: .VocabulariesText) ?? ""
        Examples = try values.decodeIfPresent(String.self, forKey: .Examples) ?? ""
        ExamplesText = try values.decodeIfPresent(String.self, forKey: .ExamplesText) ?? ""
    }
}
