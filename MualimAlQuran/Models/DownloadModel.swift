import Foundation

class DownloadModel: ObservableObject, Identifiable {
    
    var id: String = ""
    var Name: String = ""
    
    init(id: String, Name: String) {
        self.id = id
        self.Name = Name        
    }
}
