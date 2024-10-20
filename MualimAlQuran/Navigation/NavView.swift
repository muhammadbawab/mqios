import SwiftUI

enum Tab: String, CaseIterable {
    case home, account, share, more
    
    var text: String {
        switch self {
        case .home:
            "Home"
        case .account:
            "Account"
        case .share:
            "Share"
        case .more:
            "More"
        }
    }
}

struct NavView: View {
    
    @EnvironmentObject var mvm: MainViewModel
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            HStack {
                
                ForEach(Tab.allCases, id: \.self) { tab in
                    
                    Spacer()
                    
                    Button {
                        
                        mvm.selectedTab = tab
                        
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        
                        if (mvm.selectedTab == Tab.home) {
                            
                            if (mvm.viewLevel == "home") {
                                
                                mvm.homeScroll = 0
                            }
                            
                            if (mvm.backLevels.contains(mvm.viewLevel)) {
                                
                                mvm.back = true
                            }
                        }
                        
                        if (mvm.selectedTab == Tab.account) {
                            
                            if (mvm.viewLevel == "account") {
                                
                                mvm.accountScroll = 0
                            }
                            
                            if (mvm.accountBackLevels.contains(mvm.viewLevel)) {
                                
                                mvm.accountBack = true
                            }
                        }
                        
                        if (mvm.selectedTab == Tab.more) {
                            
                            if (mvm.viewLevel == "menu") {
                                
                                mvm.menuScroll = 0
                            }
                            
                            if (mvm.menuBackLevels.contains(mvm.viewLevel)) {
                                
                                mvm.back = true
                            }
                        }
                        
                    } label: {
                        
                        VStack(spacing: 0) {
                            
                            if (tab == Tab.home) {
                                
                                if (mvm.backLevels.contains(mvm.viewLevel)) {
                                    VStack(spacing: 0) {
                                        Image("back").resizable().aspectRatio(contentMode: .fit)
                                    }
                                    .frame(width: 40)
                                }
                                else {
                                    VStack(spacing: 0) {
                                        Image("home").resizable().aspectRatio(contentMode: .fit)
                                    }
                                    .frame(width: 20)
                                }
                            }
                            else if (tab == Tab.account) {
                                
                                if (mvm.accountBackLevels.contains(mvm.viewLevel)) {
                                    VStack(spacing: 0) {
                                        Image("back").resizable().aspectRatio(contentMode: .fit)
                                    }
                                    .frame(width: 40)
                                }
                                else {
                                    VStack(spacing: 0) {
                                        Image("account").resizable().aspectRatio(contentMode: .fit)
                                    }
                                    .frame(width: 22)
                                }
                            }
                            else if (tab == Tab.share) {
                                
                                VStack(spacing: 0) {
                                    Image("share").resizable().aspectRatio(contentMode: .fit)
                                }
                                .frame(width: 20)
                            }
                            else if (tab == Tab.more) {
                                
                                if (mvm.menuBackLevels.contains(mvm.viewLevel)) {
                                    VStack(spacing: 0) {
                                        Image("back").resizable().aspectRatio(contentMode: .fit)
                                    }
                                    .frame(width: 40)
                                }
                                else {
                                    VStack(spacing: 0) {
                                        Image("menu").resizable().aspectRatio(contentMode: .fit)
                                    }
                                    .frame(width: 20)
                                }
                            }
                        }
                        .frame(width: 50, height: 50)
                        
                    }
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .foregroundStyle(mvm.selectedTab == tab ? colorResource.primary_500 : .secondary)
                    
                    Spacer()
                }
            }
            .frame(height: 50)
        }
    }
}

