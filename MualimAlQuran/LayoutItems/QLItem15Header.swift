import SwiftUI

struct QLItem15Header: View {
    
    @EnvironmentObject var mvm: MainViewModel
    @Binding var item: QLModel    
    
    var body: some View {
        
        if (item.sectionID == 162 || item.sectionID == 358 || item.sectionID == 372 || item.sectionID == 376 || item.sectionID == 378) {
            
            VStack(spacing: 0)
            {
                HStack(spacing: 0)
                {
                    ForEach(1...((mvm.lessonSelected.Number == 15) ? 6 : 5), id: \.self) { i in
                        
                        var text: String {
                            
                            if (item.sectionID == 358 || item.sectionID == 372 || item.sectionID == 376 || item.sectionID == 378) {
                                
                                if (i == 4) { return "Subjunctive" }
                                if (i == 5) { return "Jussive" }
                                if (i == 6) { return "" }
                            }
                            
                            if (i == 2) {
                                return "Perfect"
                            }
                            else if (i == 3) {
                                return "Imperfect"
                            }
                            else if (i == 4) {
                                return "Verbal\nNoun"
                            }
                            else if (i == 5) {
                                return "Active\nparticiple"
                            }
                            else if (i == 6) {
                                return "Passive\nparticiple"
                            }
                            
                            return "Form"
                        }
                                                
                        ZStack {
                            
                            Text(text.trim())
                                .font(.system(size: 20))
                                .foregroundColor(colorResource.primary_500)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(12)
                        }
                        .frame(minWidth: 150, maxWidth: 150, maxHeight: .infinity)
                        .overlay(Divider().frame(maxWidth: 1, maxHeight: .infinity), alignment: .trailing)
                    }
                }
                .frame(maxWidth: .infinity)
                .background(.white)
                .overlay(Divider().frame(maxWidth: .infinity, maxHeight: 1), alignment: .bottom)
                .padding(.leading, 12)
                .padding(.trailing, 12)
            }
            .frame(maxWidth: .infinity)
            .padding(.leading, 12)
            .padding(.trailing, 12)
            .background(Color(hex: "F3F3F3"))
        }
    }
}
