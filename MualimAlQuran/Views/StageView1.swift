import SwiftUI

struct StageView1: View {
    
    @EnvironmentObject var mvm: MainViewModel
    @Binding var stage: ListModel    
    @State var layoutPadding = 0.0
    @State var itemSpacing = 0.0
    @Environment(\.dismiss) private var dismiss
    
    @State var safeArea = UIApplication.shared.firstKeyWindow?.safeAreaInsets
    
    var body: some View {
        
        ZStack {
            
            AppBG()
            
            ScrollViewReader { scrollView in
                
                ScrollView {
                    
                    VStack(spacing: 0) {
                        
                        Spacer().frame(height: 10)
                        
                        Text(mvm.listSelected1.Title.replacingOccurrences(of: "<span>", with: "").replacingOccurrences(of: "</span>", with: ""))
                            .font(.custom("opensans", size: 22))
                            .bold()
                            .lineSpacing(8)
                            .multilineTextAlignment(.center)
                            .padding(.top, 10)
                            .padding(.bottom, 5)
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                        
                        Text(mvm.listSelected1.Summary.replacingOccurrences(of: "<span>", with: "").replacingOccurrences(of: "</span>", with: ""))
                            .font(.custom("opensans", size: 20))
                            .foregroundColor(colorResource.maroon)
                            .lineSpacing(6)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 15)
                            .padding(.leading, 15)
                            .padding(.trailing, 15)
                        
                        if (mvm.stageLessonsTajweed.isEmpty) {
                            
                            if (mvm.loading) {
                                ProgressView()
                            }
                        }
                        else {
                            
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: mainListAdaptive()), spacing: itemSpacing, alignment: .leading)], spacing: 0) {
                                                                                                
                                if (!mvm.stageLessonsTajweed[0].isTab) {
                                    
                                    
                                }
                                else {                                    
                                    
                                    ForEach($mvm.stageLessonsTajweed.filter { $0.isTab.wrappedValue }) { tabItem in
                                        
                                        Section(header: ListTabItem(item: tabItem, account: .constant(false), callBack: {
                                            
                                            Task {
                                                
                                                if (tabItem.TabIndex.wrappedValue == mvm.stageTab.TabIndex) {
                                                    mvm.stageTab = ListModel(isTab: true, TabIndex: "0")
                                                } else {
                                                    mvm.stageTab = ListModel(isTab: tabItem.isTab.wrappedValue, TabIndex: tabItem.TabIndex.wrappedValue)
                                                }
                                                
                                                try? await Task.sleep(nanoseconds: 300_000_000)
                                                
                                                withAnimation {
                                                    scrollView.scrollTo(tabItem.id, anchor: .top)
                                                }
                                            }
                                            
                                        })) {
                                            
                                            ForEach($mvm.stageLessonsTajweed.filter { !$0.isTab.wrappedValue && $0.TabIndex.wrappedValue == tabItem.TabIndex.wrappedValue }) { item in
                                                
                                                let show = if (mvm.stageTab.TabIndex != item.TabIndex.wrappedValue) {
                                                    false
                                                }
                                                else {
                                                    true
                                                }
                                                
                                                if (show) {
                                                         
                                                    
                                                    
                                                    if (item.wrappedValue.Number == 25) {
                                                        
                                                        Button (action: {
                                                            
                                                            mvm.lessonSelected = item.wrappedValue
                                                            mvm.tajweedSelectedSetup = mvm.tajweedSetup.first { $0.id == mvm.lessonSelected.Number }!
                                                            mvm.loadTajweedExItems()
                                                            mvm.stage1NavSelection = item.id
                                                            
                                                        }) {
                                                            NavigationLink(destination: TajweedExView(), tag: item.id, selection: $mvm.stage1NavSelection) { }
                                                            ListItem(item: item)
                                                        }
                                                        
                                                    }
                                                    else {
                                                        
                                                        Button (action: {
                                                            
                                                            mvm.lessonSelected = item.wrappedValue
                                                            mvm.tajweedSelectedSetup = mvm.tajweedSetup.first { $0.id == mvm.lessonSelected.Number }!
                                                            mvm.loadTajweedItems()
                                                            mvm.stage1NavSelection = item.id
                                                            
                                                        }) {
                                                            NavigationLink(destination: TajweedView(), tag: item.id, selection: $mvm.stage1NavSelection) { }
                                                            ListItem(item: item)
                                                        }
                                                        
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(.leading, layoutPadding)
                            .padding(.trailing, layoutPadding)
                        }
                    }
                    
                }
                .padding(.top, (safeArea?.top ?? 0) + 1)
                .padding(.leading, safeArea?.left)
                .padding(.trailing, safeArea?.right)
                .frame(maxWidth: .infinity)
            }                        
        }
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity)
        .clipped()
        .ignoresSafeArea(.all, edges: .top)
        .onAppear {

            mvm.viewLevel = "stage1"
            mvm.back = false
            
            layoutPadding = mainLayoutPadding(items: mvm.stageLessonsTajweed)
            itemSpacing = listItemSpacing(items: mvm.stageLessonsTajweed)
        }
        .task(id: mvm.backForce) {
            if (mvm.backForce) { dismiss() }
        }
        .task(id: mvm.back) {
            if (mvm.back) { mvm.back = false; dismiss(); }
        }
        .onRotate { newOrientation in
            
            Task {
                
                for _ in 1...5 {
                    
                    try await Task.sleep(nanoseconds: 100_000_000)
                    layoutPadding = mainLayoutPadding(items: mvm.stageLessonsTajweed)
                    itemSpacing = listItemSpacing(items: mvm.stageLessonsTajweed)
                    safeArea = UIApplication.shared.firstKeyWindow?.safeAreaInsets
                }
            }
        }
    }
}
