import SwiftUI
import GoogleSignIn

class ResponseHandler: ObservableObject {
    @Published var submitText = ""
    @Published var submitLoading = false
    @Published var submitEnabled = true
    @Published var error = false
    @Published var errorMessage = ""
    @Published var success = false
    @Published var successMessage = ""
    
    func preSubmit() {
        self.error = false
        self.errorMessage = ""
        self.success = false
        self.successMessage = ""
        self.submitText = "Please wait"
        self.submitLoading = true
        self.submitEnabled = false
    }
    
    func reset(mvm: MainViewModel) {
        self.error = false
        self.errorMessage = ""
        self.success = false
        self.successMessage = ""
        self.submitText = mvm.home.Login
        self.submitLoading = false
        self.submitEnabled = true
    }
}

struct LoginLayout: View {
        
    var callback : ((UserResponse) -> Void)? = nil
    
    @EnvironmentObject var mvm: MainViewModel
    @StateObject var rh = ResponseHandler()
    
    @State var title = ""
    @State var summary = ""
    
    @State var forgotPassword = false
    @State var createAccount = false
    @State var googleSignin = false
    
    @State var name = ""
    @State var nameValid = true
    @State var nameError = "Please enter your name"
    
    @State var email = ""
    @State var emailValid = true
    @State var emailError = "Please enter your email address"
    
    @State var password = ""
    @State var passwordValid  = true
    @State var passwordError  = "Please enter your password"
    
    @FocusState var keyboardFocused: Fields?
    
    func clearFields() {
        name = ""
        email = ""
        password = ""
    }
    
    var body: some View {
        
        ScrollViewReader { scrollView in
            
            ScrollView {
                
                VStack(spacing: 0) {
                    
                    //region Header
                    Spacer().frame(height: 40)
                    
                    Text(title)
                        .font(.custom("opensans", size: 28))
                        .fontWeight(.medium)
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 5)
                    
                    Text(summary)
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
                    
                    //region Fields
                    if (createAccount) {
                        TextBox(type: Fields.name,
                                label: mvm.home.Name,
                                value: $name,
                                valid: $nameValid,
                                errorMessage: $nameError,
                                isPassword: false,
                                isMulti: false,
                                enabled: $googleSignin,
                                keyboardFocused: $keyboardFocused)
                    }
                    
                    if (!googleSignin) {
                        
                        TextBox(type: Fields.email,
                                label: mvm.home.Email,
                                value: $email,
                                valid: $emailValid,
                                errorMessage: $emailError,
                                isPassword: false,
                                isMulti: false,
                                enabled: $googleSignin,
                                keyboardFocused: $keyboardFocused)
                        
                        if (!forgotPassword) {
                            TextBox(type: Fields.password,
                                    label: mvm.home.Password,
                                    value: $password,
                                    valid: $passwordValid,
                                    errorMessage: $passwordError,
                                    isPassword: true,
                                    isMulti: false,
                                    enabled: $googleSignin,
                                    keyboardFocused: $keyboardFocused)
                        }
                        
                        //endregion
                        
                        HStack(spacing: 0) {
                            
                            //region Submit Button
                            Button(action: {
                                
                                if (rh.submitEnabled) {
                                    
                                    nameValid = validateField(button: true, current: nameValid, type: Fields.name, value: name, errorMessage: &nameError)
                                    emailValid = validateField(button: true, current: emailValid, type: Fields.email, value: email, errorMessage: &emailError)
                                    passwordValid = validateField(button: true, current: passwordValid, type: Fields.password, value: password, errorMessage: &passwordError)
                                    
                                    var valid = true
                                    
                                    if (createAccount) {
                                        if (!nameValid) {
                                            /*if (valid) {
                                             keyboardFocused = Fields.name
                                             }*/
                                            valid = false
                                        }
                                    }
                                    
                                    if (!emailValid) {
                                        /*if (valid) {
                                         keyboardFocused = Fields.email
                                         }*/
                                        valid = false
                                    }
                                    
                                    if (!forgotPassword) {
                                        if (!passwordValid) {
                                            /*if (valid) {
                                             keyboardFocused = Fields.password
                                             }*/
                                            valid = false
                                        }
                                    }
                                    
                                    if (valid) {
                                        
                                        rh.reset(mvm: mvm)
                                        rh.submitEnabled = false
                                        
                                        keyboardFocused = nil
                                        
                                        Task.detached { @MainActor in
                                            
                                            rh.preSubmit()
                                            
                                            //region Forgot Password
                                            if (forgotPassword) {
                                                
                                                let model = await Apis().forgot(email: email)
                                                
                                                Apis.validateResponse(mvm: mvm, type: "forgot", model: model, rh: rh) { _ in
                                                    
                                                    clearFields()
                                                }
                                            }
                                            //endregion
                                            //region Create Account
                                            else if (createAccount) {
                                                
                                                let model = await Apis().create(name: name, email: email, password: password)
                                                
                                                Apis.validateResponse(mvm: mvm, type: "create", model: model, rh: rh) { it in
                                                    
                                                    clearFields()
                                                    mvm.accountBack = true
                                                    
                                                    callback!(it)
                                                }
                                            }
                                            //endregion
                                            //region Login
                                            else {
                                                
                                                let model = await Apis().login(email: email, password: password)
                                                
                                                Apis.validateResponse(mvm: mvm, type: "login", model: model, rh: rh) { it in
                                                    
                                                    clearFields()
                                                    callback!(it)
                                                }
                                            }
                                            //endregion
                                        }
                                    }
                                    
                                }
                            })
                            {
                                HStack {
                                    Text(rh.submitText)
                                    
                                    if (rh.submitLoading) {
                                        
                                        Spacer().frame(width: 10)
                                        
                                        ProgressView().tint(.white)
                                    }
                                }
                                .padding([.top, .bottom], 12)
                                .padding([.leading, .trailing], 30)
                            }
                            .scaleEffect(1)
                            .foregroundColor(.white)
                            .background(colorResource.primary_500)
                            .cornerRadius(10)
                            //endregion
                            
                            //region Forgot Password
                            if (!googleSignin && rh.submitEnabled) {
                                
                                Spacer()
                                
                                if (!createAccount && !forgotPassword) {
                                    
                                    Button(
                                        action: {
                                            
                                            rh.reset(mvm: mvm)
                                            nameValid = true
                                            emailValid = true
                                            passwordValid = true
                                            title = mvm.home.ForgotPassword
                                            summary = mvm.home.ForgotPasswordSummary
                                            
                                            if (forgotPassword) {
                                                forgotPassword = false
                                                rh.submitText = mvm.home.Login
                                            } else {
                                                forgotPassword = true
                                                rh.submitText = mvm.home.Submit
                                                mvm.viewLevel = "forgot"
                                                mvm.accountViewLevel = "forgot"
                                            }
                                        }
                                    )
                                    {
                                        HStack {
                                            Text(mvm.home.ForgotPassword)
                                                .multilineTextAlignment(.center)
                                        }
                                        .padding([.top, .bottom], 12)
                                        .padding([.leading, .trailing], 10)
                                    }
                                    .scaleEffect(1)
                                    .foregroundColor(.gray)
                                    .cornerRadius(10)
                                }
                            }
                            //endregion
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    Spacer().frame(height: 10)
                    
                    if (rh.error) {
                        
                        Text(rh.errorMessage)
                            .foregroundStyle(colorResource.danger)
                            .frame(maxWidth: .infinity)
                            .padding(15)
                            .background(colorResource.dangerBG)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                    
                    if (rh.success) {
                        
                        Text(rh.successMessage)
                            .foregroundStyle(colorResource.success)
                            .frame(maxWidth: .infinity)
                            .padding(15)
                            .background(colorResource.successBG)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                    
                    if (!googleSignin) {
                        Spacer().frame(height: 50)
                    }
                    else {
                        Spacer().frame(height: 20)
                    }
                    
                    //region Login with Google
                    if (!forgotPassword && !createAccount) {
                        
                        Button(
                            action: {
                                
                                if (rh.submitEnabled) {
                                    
                                    rh.reset(mvm: mvm)
                                    rh.submitEnabled = false
                                    
                                    googleSignin = true
                                    summary = "Signing in with Google"
                                    mvm.viewLevel = "google"
                                    mvm.accountViewLevel = "google"
                                    
                                    let vc:UIViewController = (UIApplication.shared.firstKeyWindow?.rootViewController)!
                                    
                                    GIDSignIn.sharedInstance.signIn(withPresenting: vc) { signInResult, error in
                                        
                                        var googleValid = true
                                        var googleMessage = ""
                                        
                                        if (error != nil) {
                                            googleValid = false
                                            googleMessage = error!.localizedDescription
                                        }
                                        
                                        else if (signInResult == nil) {
                                            googleValid = false
                                            googleMessage = "Failed to retrieve signed in results"
                                        }
                                        
                                        else if (signInResult!.user.profile == nil) {
                                            googleValid = false
                                            googleMessage = "Failed to retrieve signed in results"
                                        }
                                        
                                        if (googleValid) {
                                            
                                            Task.detached { @MainActor in
                                                
                                                let model = await Apis().google(name: signInResult!.user.profile!.name, email: signInResult!.user.profile!.email)
                                                
                                                Apis.validateResponse(mvm: mvm, type: "create", model: model, rh: rh) { it in
                                                    
                                                    clearFields()
                                                    mvm.accountBack = true
                                                    
                                                    callback!(it)
                                                }
                                            }
                                        }
                                        else {
                                            
                                            rh.submitEnabled = true
                                            rh.error = true
                                            rh.errorMessage = googleMessage
                                        }
                                    }
                                }
                            }
                        )
                        {
                            HStack {
                                
                                Image("google").resizable().aspectRatio(contentMode: .fit).frame(width:30)
                                
                                Text("Sign in with Google")
                                
                                if (googleSignin && !rh.submitEnabled) {
                                    
                                    Spacer().frame(width: 10)
                                    
                                    ProgressView().tint(.red)
                                }
                            }
                            .padding([.top, .bottom], 6)
                            .padding(.leading, 10)
                            .padding(.trailing, 15)
                        }
                        .scaleEffect(1)
                        .foregroundColor(colorResource.lightButtonText)
                        .background(Color(hex: "F1F1F1"))
                        .cornerRadius(20)
                    }
                    //endregion
                    
                    Spacer().frame(height: 20)
                    
                    if (!forgotPassword && !createAccount && !googleSignin) {

                        Button(
                            action: {
                                
                                rh.reset(mvm: mvm)
                                nameValid = true
                                emailValid = true
                                passwordValid = true
                                title = mvm.home.Registration
                                summary = mvm.home.RegistrationSummary
                                
                                if (createAccount) {
                                    createAccount = false
                                    rh.submitText = mvm.home.Login
                                } else {
                                    createAccount = true
                                    rh.submitText = mvm.home.Submit
                                    mvm.viewLevel = "create"
                                    mvm.accountViewLevel = "create"
                                }
                            }
                        ) {
                            HStack {
                                Text(mvm.home.LoginFooter)
                            }
                            .padding([.top, .bottom], 12)
                            .padding([.leading, .trailing], 30)
                        }
                        .scaleEffect(1)
                        .foregroundColor(colorResource.lightButtonText)
                        .background(colorResource.lightButton)
                        .cornerRadius(10)
                    }
                }
                .frame(maxWidth: 500)
                .padding(.leading, 15)
                .padding(.trailing, 15)
                .onAppear() {
                    
                    if (mvm.accountViewLevel == "account") {
                        title = mvm.home.Login
                        summary = mvm.home.LoginSummary
                        rh.submitText = mvm.home.Login
                    }
                }
                .task(id: mvm.accountBack) {
                    if (mvm.accountBack) {
                        
                        forgotPassword = false
                        createAccount = false
                        googleSignin = false
                        
                        rh.reset(mvm: mvm)
                        
                        nameValid = true
                        emailValid = true
                        passwordValid = true
                        title = mvm.home.Login
                        summary = mvm.home.LoginSummary                        
                        
                        mvm.viewLevel = "account"
                        mvm.accountViewLevel = "account"
                        mvm.accountBack = false
                    }
                }
            }
        }
    }
}