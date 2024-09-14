import SwiftUI

struct Navigation: View {
    
    @EnvironmentObject var mvm: MainViewModel
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var sheetVM: BottomSheetViewModel
    
    var handler: Binding<Int> { Binding(
        get: {
            mvm.selectedTab
        },
        set: {
                        
            mvm.selectedTab = $0
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            
            if (mvm.selectedTab == 0) {
                
                if (mvm.viewLevel == "home") {
                    
                    mvm.homeScroll = 0                                        
                }
                
                if (mvm.backLevels.contains(mvm.viewLevel)) {
                    
                    mvm.back = true
                }
            }
            
            if (mvm.selectedTab == 1) {
                
                if (mvm.viewLevel == "account") {
                    
                    mvm.accountScroll = 0
                }
                
                if (mvm.accountBackLevels.contains(mvm.viewLevel)) {
                    
                    mvm.accountBack = true
                }
            }
            
            if (mvm.selectedTab == 3) {
                
                if (mvm.viewLevel == "menu") {
                    
                    mvm.menuScroll = 0
                }
                
                if (mvm.menuBackLevels.contains(mvm.viewLevel)) {
                    
                    mvm.back = true
                }
            }
        }
    )}
    
    var body: some View {
        
        TabView(selection: handler) {
            
            VStack(spacing: 0) {
                
                NavigationView {
                    
                    ZStack {
                        
                        AppBG()
                        
                        HomeView()
                    }
                }
                .navigationBarHidden(true)
                .navigationViewStyle(.stack)
                
                TabShadow()
            }
            .tabItem {
                
                if (mvm.backLevels.contains(mvm.viewLevel)) {
                    Image("back").resizable()
                }
                else {
                    Image("home")
                }
            }
            .tag(0)
            
            VStack(spacing: 0) {
                
                NavigationView {
                    
                    ZStack {
                        
                        AppBG()
                        
                        AccountView()
                    }
                    .ignoresSafeArea(.keyboard)
                }
                .navigationBarHidden(true)
                .navigationViewStyle(.stack)
                
                TabShadow()
            }
            .tabItem {
                if (mvm.accountBackLevels.contains(mvm.viewLevel)) {
                    Image("back").resizable()
                }
                else {
                    Image("account")
                }
            }
            .tag(1)
            .ignoresSafeArea(.keyboard)
            
            VStack(spacing: 0) {
                
                NavigationView {
                    
                    ZStack {
                        
                        AppBG()
                        
                        ShareView()
                    }
                    .ignoresSafeArea(.keyboard)
                }
                .navigationBarHidden(true)
                .navigationViewStyle(.stack)
                
                TabShadow()
            }
            .tabItem {
                Image("share")
            }
            .tag(2)            
            .ignoresSafeArea(.keyboard)
            
            VStack(spacing: 0) {
                
                NavigationView {
                    
                    ZStack {
                        
                        AppBG()
                        
                        MoreView()
                    }
                    .ignoresSafeArea(.keyboard)
                }
                .navigationBarHidden(true)
                .navigationViewStyle(.stack)
                
                TabShadow()
            }
            .tabItem {
                
                if (mvm.menuBackLevels.contains(mvm.viewLevel)) {
                    Image("back").resizable()
                }
                else {
                    Image("menu")
                }
            }
            .tag(3)            
            .ignoresSafeArea(.keyboard)
        }
        .accentColor(Color(hex: "#a8b44c"))
        .onAppear {
            // correct the transparency bug for Tab bars
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundColor = UIColor.white
            tabBarAppearance.shadowImage = nil
            tabBarAppearance.shadowColor = UIColor.clear
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            UITabBar.appearance().standardAppearance = tabBarAppearance
            // correct the transparency bug for Navigation bars
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        }
        .sheet(isPresented: $sheetVM.sheetState) {
            
            if #available(iOS 16.0, *) {
                BottomSheet().presentationDetents([.medium, .large])
            } else {
                BottomSheet()
            }
        }
    }
}

struct NavigationUtil {
    
    static func popToRootView(animated: Bool = false) {
        findNavigationController(viewController: UIApplication.shared.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first { $0.isKeyWindow }?.rootViewController)?.popToRootViewController(animated: animated)
    }
    
    static func findNavigationController(viewController: UIViewController?) -> UINavigationController? {
        guard let viewController = viewController else {
            return nil
        }
        
        if let navigationController = viewController as? UITabBarController {
            return findNavigationController(viewController: navigationController.selectedViewController)
        }
        
        if let navigationController = viewController as? UINavigationController {
            return navigationController
        }
        
        for childViewController in viewController.children {
            return findNavigationController(viewController: childViewController)
        }
        
        return nil
    }
}

