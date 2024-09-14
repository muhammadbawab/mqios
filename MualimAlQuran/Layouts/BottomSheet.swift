import SwiftUI
import AVFoundation
import AVKit

struct BottomSheet: View {
    
    @EnvironmentObject var sheetVM: BottomSheetViewModel
    @State var player: AVPlayer = AVPlayer()
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack(alignment: .top) {
                
                VStack(spacing: 0) {
                    
                    Spacer()
                    
                    Text(sheetVM.title.replacingOccurrences(of: "<span>", with: "\n").replacingOccurrences(of: "</span>", with: ""))
                        .font(.system(size: 22))
                        .foregroundColor(colorResource.maroon)
                        .frame(alignment: .bottom)
                }
                .frame(minHeight: 48)
                .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
                
                if (!sheetVM.restart) {
                    
                    Button(action: { sheetVM.sheetState.toggle() }) {
                        
                        Image(systemName: "multiply")
                            .foregroundColor(colorResource.lightButtonText)
                    }
                    .frame(width: 48, height: 48)
                    .background(colorResource.lightButton)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .frame(maxWidth: .infinity)
            
            Rectangle().frame(height: 1).foregroundColor(colorResource.orange).padding(.top, 2)
            
            if (sheetVM.showVideo) {
                
                VideoPlayer(player: player)
                    .onAppear() {
                        
                        player = AVPlayer(url: Bundle.main.url(forResource: sheetVM.videoUrl, withExtension: "mp4")!)
                        player.play()
                    }
                    .onDisappear() {
                        
                        player.pause()
                        sheetVM.showVideo = false
                    }
            }
            
            Text(instructionsSummary(value: sheetVM.summary))
                .font(.system(size: 16))
                .lineSpacing(8)
                .multilineTextAlignment(.leading)
            
            if (sheetVM.restart) {
                ProgressView().tint(.red).padding(.top, 2)
            }
            
            Spacer()
        }
        .padding(20)
    }
}
