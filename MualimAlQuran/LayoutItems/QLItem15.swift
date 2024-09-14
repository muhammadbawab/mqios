import SwiftUI

struct QLItem15: View {
    
    @EnvironmentObject var mvm: MainViewModel
    @Binding var item: QLModel
    @Binding var activeLetter: Int
    @Binding var player: Player
    
    var body: some View {
        
        HStack(spacing: 0)
        {            
            ForEach(1...((mvm.lessonSelected.Number == 15) ? 6 : 5), id: \.self) { i in
                
                var text: String {
                    
                    if (i == 2) {
                        return item.Word2
                    }
                    else if (i == 3) {
                        return item.Word3
                    }
                    else if (i == 4) {
                        return item.Word4
                    }
                    else if (i == 5) {
                        return item.Word5
                    }
                    else if (i == 6) {
                        return item.Word6
                    }
                    
                    return item.Word1
                }
                
                var wordIndex: Int {
                    
                    if (i == 2) {
                        return item.Word2Index
                    }
                    else if (i == 3) {
                        return item.Word3Index
                    }
                    else if (i == 4) {
                        return item.Word4Index
                    }
                    else if (i == 5) {
                        return item.Word5Index
                    }
                    else if (i == 6) {
                        return item.Word6Index
                    }
                    
                    return item.WordIndex
                }
                
                Button(action: {
                    activeLetter = wordIndex
                    qLPlay(index: wordIndex, mvm: mvm, player: player)
                }) {
                    
                    ZStack {
                        
                        Text(text.trim())
                            .font(.custom("KFGQPCHAFSUthmanicScript-Regula", size: 30))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(12)
                        
                        if ((item.sectionID == 162 || item.sectionID == 372 || item.sectionID == 376 || item.sectionID == 378) && i == 1) {
                            // No Audio
                        }
                        else if (text != "") {
                            QLItemLoader(index: wordIndex, activeLetter: $activeLetter)
                        }
                    }
                    .frame(minWidth: 150, maxWidth: 150, maxHeight: .infinity)
                    .overlay(Divider().frame(maxWidth: 1, maxHeight: .infinity), alignment: .trailing)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .overlay(Divider().frame(maxWidth: .infinity, maxHeight: 1), alignment: .bottom)
        .padding(.leading, 12)
        .padding(.trailing, 12)
    }
}
