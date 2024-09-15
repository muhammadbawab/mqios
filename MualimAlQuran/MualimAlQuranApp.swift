//
//  MualimAlQuranApp.swift
//  MualimAlQuran
//
//  Created by Muhammad Bawab on 11/08/2022.
//

import SwiftUI
import AppTrackingTransparency
import AdSupport

class GlobalGrid: ObservableObject {
    @Published var columns = [GridItem(.adaptive(minimum: 300))]
}

class vc1: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        let app = UINavigationBarAppearance()
            app.backgroundColor = .white
        self.navigationController?.navigationBar.scrollEdgeAppearance = app
        title = "home"
        
    }
}

class vc2: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        title = "contacts"
    }
}

class vc3: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        title = "Create"
    }
}

class vc4: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        title = "contacts"
    }
}

class vc5: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        title = "contacts"
    }
}

@main
struct MualimAlQuranApp: App {
    
    let mvm = MainViewModel();
    let sheetVM = BottomSheetViewModel();
    let navigationController: UINavigationController = .init()
    
    init() {
        
        mvm.initiate()
    }
    
    var body: some Scene {
        
        WindowGroup {
            
            ZStack {
                
                Navigation()
                    .environmentObject(mvm) 
                    .environmentObject(sheetVM)                    
            }
            /*.onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                    
                })
            }*/
        }
    }
}

extension String {
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
}


