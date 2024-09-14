import SwiftUI

struct StageView: View {
    
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
                        
                        Text(mvm.listSelected.Title.replacingOccurrences(of: "<span>", with: "").replacingOccurrences(of: "</span>", with: ""))
                            .font(.custom("opensans", size: 22))
                            .bold()
                            .lineSpacing(8)
                            .multilineTextAlignment(.center)
                            .padding(.top, 10)
                            .padding(.bottom, 5)
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                        
                        Text(mvm.listSelected.Summary.replacingOccurrences(of: "<span>", with: "").replacingOccurrences(of: "</span>", with: ""))
                            .font(.custom("opensans", size: 20))
                            .foregroundColor(colorResource.maroon)
                            .lineSpacing(6)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 15)
                            .padding(.leading, 15)
                            .padding(.trailing, 15)
                        
                        if (mvm.stageLessons.isEmpty) {
                            
                            if (mvm.loading) {
                                ProgressView()
                            }
                            else {
                                ProgressView().task {
                                    mvm.loadStageLessons(item: mvm.listSelected)
                                    layoutPadding = mainLayoutPadding(items: mvm.stageLessons)
                                    itemSpacing = listItemSpacing(items: mvm.stageLessons)
                                }
                            }
                        }
                        else {
                            
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: mainListAdaptive()), spacing: itemSpacing, alignment: .leading)], spacing: 0) {
                                                                                                
                                if (!mvm.stageLessons[0].isTab) {
                                    
                                    ForEach($mvm.stageLessons) { item in
                                        
                                        if (item.id == 51) {
                                            
                                            NavigationLink(destination: StageView1(stage: item)) {
                                                
                                                ListItem(item: item)
                                            }
                                            .simultaneousGesture(TapGesture().onEnded({
                                                
                                                mvm.listType = "stage1"
                                                mvm.listSelected1 = item.wrappedValue
                                                mvm.stageTab = ListModel(isTab: true, TabIndex: "101")
                                            }))
                                        }
                                        else {
                                            
                                            if (item.StageID.wrappedValue == 1) {

                                                NavigationLink(destination: LessonView(lesson: item)) {
                                                    
                                                    ListItem(item: item)
                                                }
                                                .simultaneousGesture(TapGesture().onEnded({
                                                    
                                                    mvm.listType = "lesson"
                                                    mvm.lessonSelected = item.wrappedValue
                                                    mvm.loadLessonItems()
                                                }))

                                            } else if (
                                                (item.StageID.wrappedValue == 2) ||
                                                (item.StageID.wrappedValue == 5) ||
                                                (item.StageID.wrappedValue == 3 && item.Number.wrappedValue == -1) ||
                                                (item.StageID.wrappedValue == 3 && item.Number.wrappedValue == -2)
                                            ) {

                                                NavigationLink(destination: RecitationView()) {
                                                    
                                                    ListItem(item: item)
                                                }
                                                .simultaneousGesture(TapGesture().onEnded({
                                                    
                                                    mvm.recitationInitialLoad = false
                                                    mvm.listType = "recitation"
                                                    mvm.lessonSelected = item.wrappedValue
                                                    mvm.recitationItems = mvm.verse1
                                                }))

                                            } else if (item.StageID.wrappedValue == 4) {

                                                
                                                
                                                //NavigationLink(destination: LessonView(lesson: item, viewLevel: $viewLevel)) {
                                                    
                                                    ListItem(item: item)
                                                //}
                                                //.simultaneousGesture(TapGesture().onEnded({

                                                //    mvm.lessonSelected = item
                                                //    mvm.loadQLItems()
                                                //}))
                                            }
                                            
                                        }
                                    }
                                }
                                else {
                                    
                                    ForEach($mvm.stageLessons.filter { $0.isTab.wrappedValue }) { tabItem in
                                        
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
                                            
                                            ForEach($mvm.stageLessons.filter { !$0.isTab.wrappedValue && $0.TabIndex.wrappedValue == tabItem.TabIndex.wrappedValue }) { item in
                                                
                                                let show = if (mvm.listSelected.id == 1 || mvm.listSelected.id == 4) {
                                                    if (mvm.stageTab.TabIndex != item.TabIndex.wrappedValue) {
                                                        false
                                                    }
                                                    else {
                                                        true
                                                    }
                                                }
                                                else {
                                                    true
                                                }
                                                
                                                if (show) {
                                                
                                                    if (item.StageID.wrappedValue == 1) {

                                                        NavigationLink(destination: LessonView(lesson: item)) {
                                                            
                                                            ListItem(item: item)
                                                        }
                                                        .simultaneousGesture(TapGesture().onEnded({
                                                            
                                                            mvm.listType = "lesson"
                                                            mvm.lessonSelected = item.wrappedValue
                                                            mvm.loadLessonItems()
                                                        }))

                                                    } else if (
                                                        (item.StageID.wrappedValue == 2) ||
                                                        (item.StageID.wrappedValue == 5) ||
                                                        (item.StageID.wrappedValue == 3 && item.Number.wrappedValue == -1) ||
                                                        (item.StageID.wrappedValue == 3 && item.Number.wrappedValue == -2)
                                                    ) {

                                                        //NavigationLink(destination: LessonView(lesson: item, viewLevel: $viewLevel)) {
                                                            
                                                            ListItem(item: item)
        //                                                }
        //                                                .simultaneousGesture(TapGesture().onEnded({
        //
        //                                                    mvm.listType = "recitation"
        //                                                    mvm.lessonSelected = item
        //                                                    mvm.recitationItems = mvm.verse1
        //                                                }))

                                                    } else if (item.StageID.wrappedValue == 4) {

                                                        NavigationLink(destination: QLView()) {
                                                            
                                                            ListItem(item: item)
                                                        }
                                                        .simultaneousGesture(TapGesture().onEnded({

                                                            mvm.lessonSelected = item.wrappedValue
                                                            mvm.loadQLItems(mvm: mvm)
                                                        }))
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
        .ignoresSafeArea()
        .onAppear {
            
            mvm.viewLevel = "stage"
            mvm.back = false
            
            layoutPadding = mainLayoutPadding(items: mvm.stageLessons)
            itemSpacing = listItemSpacing(items: mvm.stageLessons)
        }
        .task(id: mvm.backForce) {
            if (mvm.backForce) { dismiss() }
        }
        .task(id: mvm.back) {
            if (mvm.back) { dismiss(); mvm.back = false }
        }
        .onRotate { newOrientation in
            
            Task {
                
                for _ in 1...5 {
                    
                    try await Task.sleep(nanoseconds: 100_000_000)
                    layoutPadding = mainLayoutPadding(items: mvm.stageLessons)
                    itemSpacing = listItemSpacing(items: mvm.stageLessons)
                    safeArea = UIApplication.shared.firstKeyWindow?.safeAreaInsets
                }
            }
        }
    }
}
