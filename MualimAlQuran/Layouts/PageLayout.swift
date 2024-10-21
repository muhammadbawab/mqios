import SwiftUI
import SwiftSoup

struct PageLayout: View {
    
    @EnvironmentObject var mvm: MainViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State var safeArea = UIApplication.shared.firstKeyWindow?.safeAreaInsets
    
    var body: some View {
        
        ZStack {
            
            AppBG()
            
            ScrollViewReader { scrollView in
                
                ScrollView {
                    
                    VStack(spacing: 0) {
                        
                        //region Header
                        Spacer().frame(height: 40)
                        
                        Text(mvm.pageSelected.Title)
                            .font(.custom("opensans", size: 26))
                            .fontWeight(.medium)
                            .foregroundStyle(.black)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 5)
                        
                        Rectangle()
                            .fill(colorResource.maroon)
                            .frame(height: 1)
                            .padding(.bottom, 5)
                        
                        Spacer().frame(height: 10)
                        //endregion
                                            
                        if (mvm.pageSelected.id == "feedback") {
                            FeedbackLayout()
                                .padding(.leading, 1)
                                .padding(.trailing, 1)
                        } else if (mvm.pageSelected.id == "language") {
                            //LanguageLayout()
                        } else {
                            Text(parseDescription(description: mvm.pageSelected.Description))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                .padding(.top, (safeArea?.top ?? 0) + 1)
                .padding(.leading, safeArea?.left)
                .padding(.trailing, safeArea?.right)
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.leading, 15)
        .padding(.trailing, 15)
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity)
        .clipped()
        .ignoresSafeArea(.all, edges: [.top, .leading, .trailing])
        .onAppear {
            mvm.viewLevel = "page"
            mvm.back = false                        
        }
        .task(id: mvm.back) {
            if (mvm.back) { mvm.back = false; dismiss(); }
        }
        .onRotate { newOrientation in
            
            Task {
                
                for _ in 1...5 {
                    
                    try await Task.sleep(nanoseconds: 100_000_000)
                    safeArea = UIApplication.shared.firstKeyWindow?.safeAreaInsets
                }
            }
        }
    }
}

func parseDescription(description: String) -> AttributedString {

    let data = try! SwiftSoup.parse("<p>\(description)</p>").body()?.getAllElements()

    var newData: AttributedString {

        var str = AttributedString("")
        
        data!.forEach { it in

            let value = (try? it.text()) ?? ""
            
            if (value != "") {
                
                if (it.nodeName() == "h2") {
                    
                    var subStr = AttributedString(value + "\n")
                    
                    if let range = subStr.range(of: value) {
                        subStr[range].font = .system(size: 24)
                        subStr[range].foregroundColor = Color(hex: "b23a00")
                    }
                    
                    str.append(subStr)
                }
                
                if (it.nodeName() == "p") {
                    
                    str.append(AttributedString(value + "\n\n"))
                }
                
                if (it.nodeName() == "li") {
                    
                    str.append(AttributedString("- " + value + "\n"))
                }
            }
        }
        
        return str
    }

    return newData
}
