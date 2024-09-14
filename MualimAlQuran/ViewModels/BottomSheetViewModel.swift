import SwiftUI

class BottomSheetViewModel: ObservableObject
{
    var title = ""
    var summary = ""
    var showVideo = false
    var videoUrl = ""
    var restart = false
    @Published var sheetState = false
}


