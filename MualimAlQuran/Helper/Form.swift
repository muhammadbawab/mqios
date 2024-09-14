import SwiftUI

enum Fields: Hashable {
    case name,email,password,feedback
}

struct TextBox: View {
    
    @EnvironmentObject var mvm: MainViewModel
    
    @State var type: Fields
    @State var label: String
    @Binding var value: String
    @Binding var valid: Bool
    @Binding var errorMessage: String
    @State var isPassword: Bool = false
    @State var isMulti: Bool = false
    @Binding var enabled: Bool
    var keyboardFocused: FocusState<Fields?>.Binding
    
    @State var passwordVisible = false
    
    var body: some View {
        
        HStack(spacing: 0) {
            
            if (isPassword && !passwordVisible) {
                SecureField(label, text: $value)
                    .placeholder(when: value.isEmpty) {
                        Text(label).foregroundStyle(colorResource.grey)
                    }
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                    .focused(keyboardFocused, equals: type)
                    .submitLabel(.done)
            }
            else if (isMulti) {
                TextEditor(text: $value)
                    .placeholder(when: value.isEmpty) {
                        Text(label).foregroundStyle(colorResource.grey)
                    }
                    .autocapitalization(.none)
                    .focused(keyboardFocused, equals: type)
                    .submitLabel(.done)
                    .frame(minHeight: 100)
            }
            else {
                TextField(label, text: $value)
                    .placeholder(when: value.isEmpty) {
                        Text(label).foregroundStyle(colorResource.grey)
                    }
                    .autocapitalization(.none)
                    .focused(keyboardFocused, equals: type)
                    .keyboardType((label == mvm.home.Email) ? .emailAddress : .default)
                    .submitLabel(.done)
            }
            
            if (!valid) {
                Image(systemName: "exclamationmark.circle.fill").foregroundStyle(.red)
            }
            else {
                
                if (isPassword) {
                    
                    if (passwordVisible) {
                        Button(action: { passwordVisible = false }) {
                            Image(systemName: "eye.fill").foregroundStyle(colorResource.grey)
                        }
                    }
                    else {
                        Button(action: { passwordVisible = true }) {
                            Image(systemName: "eye.slash.fill").foregroundStyle(colorResource.grey)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(15)
        .background(colorResource.white)
        .clipShape(RoundedRectangle(cornerRadius: 4))
        .overlay() {
            RoundedRectangle(cornerRadius: 4).stroke(colorResource.lightButton, lineWidth: 1)
        }
        .foregroundColor(colorResource.lightButtonText)        
        .onChange(of: value) { it in
                        
            valid = validateField(button: false, current: valid, type: type, value: it, errorMessage: &errorMessage)
        }
        
        if (!valid) {
            Text(errorMessage)
                .foregroundStyle(colorResource.danger)
                .font(.system(size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(4)
        }

        Spacer().frame(height: 20)
    }
}

func validateField(button: Bool, current: Bool, type: Fields, value: String, errorMessage: inout String) -> Bool {
    
    var valid = current
    
    if (type == Fields.email) {
            
        if (button) {
            valid = (value.trim() != "")
            valid = (value.trim() != "") && isEmail(email: value.trim())
            if (value.trim() == "") {
                errorMessage = "Please enter your email address"
            }
            else if (!isEmail(email: value)) {
                errorMessage = "Invalid email address"
            }
        }
        else {
            
            if (value.trim() != "" && isEmail(email: value)) {
                valid = true
            }
        }
    }
    else {
        
        if (button) {            
            valid = (value.trim() != "")
        }
        else {
            
            if (value.trim() != "") {
                valid = true
            }
        }
    }
    
    return valid
}

func isEmail(email: String) -> Bool  {
    
    let range = NSRange(location: 0, length: email.utf16.count)
    let regex = try! NSRegularExpression(pattern: "[a-zA-Z0-9._-]+@[a-z]+\\.+[a-z]+")
    return regex.firstMatch(in: email, options: [], range: range) != nil
}

func setUser(item: UserResponse) {

    UserDefaults.standard.set(item.data![0].id, forKey: "UserID")
    UserDefaults.standard.set(item.data![0].Name, forKey: "UserName")
    UserDefaults.standard.set(item.data![0].Email, forKey: "UserEmail")
}

func getUser(type: String) -> String {

    let value = if (UserDefaults.standard.string(forKey: "User\(type)") != nil) {
        UserDefaults.standard.string(forKey: "User\(type)")
    }
    else {
        ""
    }

    return value!
}

func removeUser() {

    UserDefaults.standard.removeObject(forKey: "UserID")
    UserDefaults.standard.removeObject(forKey: "UserName")
    UserDefaults.standard.removeObject(forKey: "UserEmail")
    UserDefaults.standard.removeObject(forKey: "MemorizingProgress")    
}

func pushBookmark(surah: String, ayah: String) async {

    if (getUser(type: "ID") != "") {

        _ = await Apis().bookmark(id: getUser(type: "ID"), surah: surah, ayah: ayah)
    }
}

func syncBookmark(vm: RecitationViewModel) async {

    if (getUser(type: "ID") != "") {

        let model = await Apis().syncBookmark(id: getUser(type: "ID"), surah: getBookmark(key: "Surah"), ayah: getBookmark(key: "Ayah"), date: getBookmark(key: "Date"))
        
        if (model != nil) {

            if (model!.code == 200) {

                if (model!.data != nil) {

                    let user = model!.data![0]

                    setBookmark(id: user.BookmarkID!, surah: user.BookmarkSurah!, surahName: user.BookmarkSurahName!, ayah: user.BookmarkAyah!)
                    vm.bookmarked = user.BookmarkID!
                }
            }
        }
    }
}

func pushMemorizing(type: String, item: Memorizing) async {

    if (getUser(type: "ID") != "") {

        let data = try! JSONEncoder().encode(item)
        let json = String(data: data, encoding: String.Encoding.utf8)
        _ = await Apis().memorizing(id: getUser(type: "ID"), type: type, item: json!)
    }
}

func syncMemorizing(vmAccount: AccountViewModel?, mvm: MainViewModel) async {

    if (getUser(type: "ID") != "") {
        
        let model = await Apis().syncMemorizing(id: getUser(type: "ID"))
        
        if (model != nil) {
            
            if (model!.code == 200) {
                
                let user = model!.data![0]
                
                if (user.Memorizing != "") {
                    
                    UserDefaults.standard.removeObject(forKey: "MemorizingProgress")
                                  
                    let onlineData = try! JSONDecoder().decode([Memorizing].self, from: user.Memorizing.data(using: .utf8)!)
                    
                    onlineData.forEach { it in
                        
                        setMemorizing(userID: getUser(type: "ID"), 
                                      surah: it.Surah,
                                      surahName: it.SurahName,
                                      ayah: it.Ayah,
                                      verses: it.Verses,
                                      repetitions: it.Repetitions,
                                      _from: it._From,
                                      push: false,
                                      date: it.NewDate)
                    }
                    loadMemorizing(vm: vmAccount!, mvm: mvm)
                    
                    if (!mvm.recitationItems.isEmpty) {
                        mvm.recitationItems.forEach { it in
                            
                            if (isMemorized(userID: getUser(type: "ID"), surah: it.Surah, ayah: it.Ayah)) {
                                it.memorized = true
                            } else {
                                it.memorized = false
                            }
                        }
                    }
                    
                    vmAccount?.sync = false
                }
            }
        }
    }
}


