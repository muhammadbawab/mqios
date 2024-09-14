import SwiftUI

struct ShareView: View {
    
    @EnvironmentObject var mvm: MainViewModel
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            ScrollViewReader { scrollView in
                
                ScrollView {
                    
                    VStack(spacing: 0) {
                        
                        //region Header
                        Spacer().frame(height: 40)
                        
                        Text(mvm.home.Share)
                            .font(.custom("opensans", size: 28))
                            .fontWeight(.medium)
                            .foregroundStyle(.black)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.bottom, 5)
                        
                        Text(mvm.home.ShareSummary)
                            .font(.custom("opensans", size: 18))
                            .fontWeight(.medium)
                            .foregroundStyle(colorResource.maroon)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.bottom, 15)
                            .padding(.leading, 15)
                            .padding(.trailing, 15)
                        
                        Spacer().frame(height: 20)
                        //endregion                                                    
                        
                        Button(action: {
                            
                            let vc:UIViewController = (UIApplication.shared.firstKeyWindow?.rootViewController)!
                            
                            let AV = UIActivityViewController(activityItems: ["Mu'alim al-Qur'an - https://mualim-alquran.com"], applicationActivities: nil)
                            
                            vc.present(AV, animated: true)
                            
                        }) {
                            
                            HStack {
                                Text(mvm.home.Share)
                            }
                            .padding([.top, .bottom], 12)
                            .padding([.leading, .trailing], 30)
                        }
                        .foregroundColor(.white)
                        .background(colorResource.primary_500)
                        .cornerRadius(10)
                    }
                }
            }
        }
        .onAppear() {
            mvm.viewLevel = "share"
        }
    }
}
