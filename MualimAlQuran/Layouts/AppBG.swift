import SwiftUI

struct AppBG: View {
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            Image("bg_custom")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxHeight:425)
            
            Spacer()
        }
        .frame(width: 0)
        .ignoresSafeArea()
    }
}
