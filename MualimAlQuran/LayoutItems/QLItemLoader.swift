import SwiftUI

struct QLItemLoader: View {
    
    @EnvironmentObject var mvm: MainViewModel
    @State var index: Int = 0
    @Binding var activeLetter: Int
    
    var body: some View {
        
        HStack(spacing: 0) {
            
            Spacer()
            
            VStack(spacing: 0) {
                
                Spacer()
                
                if (activeLetter == index) {
                    
                    ProgressView().tint(colorResource.maroon)
                        .frame(width: 18, height: 18)
                        .padding(2)
                    
                } else {
                    
                    Image(systemName: "play.circle.fill")
                        .foregroundStyle(colorResource.primary_500)
                        .frame(width: 18, height: 18)
                        .padding(2)
                }
            }
        }                
    }
}
