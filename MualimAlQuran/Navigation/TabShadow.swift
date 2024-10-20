import SwiftUI

struct TabShadow: View {
    
    var body: some View {
        
//        VStack(spacing: 0) {
//            
//            Rectangle()
//                .fill(colorResource.primary_500)
//                .frame(width: 50, height: 3, alignment: .leading)
//                .clipShape(RoundedRectangle(cornerRadius: 25))
//                .padding(.top, 2)
//        }
//        .frame(maxWidth: .infinity, minHeight: 5, alignment: .leading)
//        .background(.white)
//        .shadow(color: Color(hex: "#cccccc"), radius: 10)
        
        Rectangle()
            .fill(Color.white)
            .frame(height: 0)
            .shadow(color: Color(hex: "#cccccc"), radius: 10)            
    }
}
