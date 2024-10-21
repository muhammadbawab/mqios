import SwiftUI
import AVFoundation


class Player: NSObject, AVAudioPlayerDelegate, ObservableObject {
    
    var player = AVAudioPlayer()
    var type: String = ""
    var vm: RecitationItem?
    
    @Published var playing = false
            
    func play(url: URL) {
        
        player = try! AVAudioPlayer(contentsOf: url)
        player.delegate = self
        
        audioSilent()
        player.play()
        
        DispatchQueue.main.async {
            self.playing = true
        }
    }
    
    func stop() {
        
        player.stop()
        
        DispatchQueue.main.async {
            self.playing = false
        }
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {

        playing = false
        
        if (type == "recitation") {
            
            vm?.playVerseCompleted()            
        }
        else if (type == "translation") {
            
            vm?.playTranslationCompleted()
        }
    }
    
    func pause() {
        
        player.pause()
    }
    
    func play() {
        audioSilent()
        player.play()
    }
}

func audioSilent() {
    
    do {
        try AVAudioSession.sharedInstance().setCategory(.playback)
    }
    catch {
        
    }
}
