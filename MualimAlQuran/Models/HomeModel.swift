import Foundation

class HomeModel: ObservableObject, Identifiable, Decodable {
    
    var Title: String = ""
    var Summary: String = ""
    var Link1: String = ""
    var Link2: String = ""
    var LoginSummary: String = ""
    var Email: String = ""
    var Password: String = ""
    var Login: String = ""
    var Registration: String = ""
    var RegistrationSummary: String = ""
    var Name: String = ""
    var Submit: String = ""
    var LoginFooter: String = ""
    var RegisterFooter: String = ""
    var Feedback: String = ""
    var AboutUs: String = ""
    var Lesson: String = ""
    var ForgotPassword: String = ""
    var ForgotPasswordSummary: String = ""
    var ResetPassword: String = ""
    var ResetPasswordSummary: String = ""
    var NewPassword: String = ""
    var ConfirmPassword: String = ""
    var Share: String = ""
    var Instructions: String = ""
    var Page: String = ""
    var OneWord: String = ""
    var TwoWords: String = ""
    var _3Times: String = ""
    var _5Times: String = ""
    var _7Times: String = ""
    var Completed: String = ""
    var Incomplete: String = ""
    var Progress: String = ""
    var Bookmark: String = ""
    var ShareSummary: String = ""
    var InfoSettings: String = ""
    var Downloads: String = ""
    var Language: String = ""
    var RestartApp: String = ""
    var RestartAppSummary: String = ""
    
    init() {
        
    }
    
    enum CodingKeys: String, CodingKey {
        case Title = "Title"
        case Summary = "Summary"
        case Link1 = "Link1"
        case Link2 = "Link2"
        case LoginSummary = "LoginSummary"
        case Email = "Email"
        case Password = "Password"
        case Login = "Login"
        case Registration = "Registration"
        case RegistrationSummary = "RegistrationSummary"
        case Name = "Name"
        case Submit = "Submit"
        case LoginFooter = "LoginFooter"
        case RegisterFooter = "RegisterFooter"
        case Feedback = "Feedback"
        case AboutUs = "AboutUs"
        case Lesson = "Lesson"
        case ForgotPassword = "ForgotPassword"
        case ForgotPasswordSummary = "ForgotPasswordSummary"
        case ResetPassword = "ResetPassword"
        case ResetPasswordSummary = "ResetPasswordSummary"
        case NewPassword = "NewPassword"
        case ConfirmPassword = "ConfirmPassword"
        case Share = "Share"
        case Instructions = "Instructions"
        case Page = "Page"
        case OneWord = "OneWord"
        case TwoWords = "TwoWords"
        case _3Times = "_3Times"
        case _5Times = "_5Times"
        case _7Times = "_7Times"
        case Completed = "Completed"
        case Incomplete = "Incomplete"
        case Progress = "Progress"
        case Bookmark = "Bookmark"
        case ShareSummary = "ShareSummary"
        case InfoSettings = "InfoSettings"
        case Downloads = "Downloads"
        case Language = "Language"
        case RestartApp = "RestartApp"
        case RestartAppSummary = "RestartAppSummary"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        Title = try values.decodeIfPresent(String.self, forKey: .Title) ?? ""
        Summary = try values.decodeIfPresent(String.self, forKey: .Summary) ?? ""
        Link1 = try values.decodeIfPresent(String.self, forKey: .Link1) ?? ""
        Link2 = try values.decodeIfPresent(String.self, forKey: .Link2) ?? ""
        LoginSummary = try values.decodeIfPresent(String.self, forKey: .LoginSummary) ?? ""
        Email = try values.decodeIfPresent(String.self, forKey: .Email) ?? ""
        Password = try values.decodeIfPresent(String.self, forKey: .Password) ?? ""
        Login = try values.decodeIfPresent(String.self, forKey: .Login) ?? ""
        Registration = try values.decodeIfPresent(String.self, forKey: .Registration) ?? ""
        RegistrationSummary = try values.decodeIfPresent(String.self, forKey: .RegistrationSummary) ?? ""
        Name = try values.decodeIfPresent(String.self, forKey: .Name) ?? ""
        Submit = try values.decodeIfPresent(String.self, forKey: .Submit) ?? ""
        LoginFooter = try values.decodeIfPresent(String.self, forKey: .LoginFooter) ?? ""
        RegisterFooter = try values.decodeIfPresent(String.self, forKey: .RegisterFooter) ?? ""
        Feedback = try values.decodeIfPresent(String.self, forKey: .Feedback) ?? ""
        AboutUs = try values.decodeIfPresent(String.self, forKey: .AboutUs) ?? ""
        Lesson = try values.decodeIfPresent(String.self, forKey: .Lesson) ?? ""
        ForgotPassword = try values.decodeIfPresent(String.self, forKey: .ForgotPassword) ?? ""
        ForgotPasswordSummary = try values.decodeIfPresent(String.self, forKey: .ForgotPasswordSummary) ?? ""
        ResetPassword = try values.decodeIfPresent(String.self, forKey: .ResetPassword) ?? ""
        ResetPasswordSummary = try values.decodeIfPresent(String.self, forKey: .ResetPasswordSummary) ?? ""
        NewPassword = try values.decodeIfPresent(String.self, forKey: .NewPassword) ?? ""
        ConfirmPassword = try values.decodeIfPresent(String.self, forKey: .ConfirmPassword) ?? ""
        Share = try values.decodeIfPresent(String.self, forKey: .Share) ?? ""
        Instructions = try values.decodeIfPresent(String.self, forKey: .Instructions) ?? ""
        Page = try values.decodeIfPresent(String.self, forKey: .Page) ?? ""
        OneWord = try values.decodeIfPresent(String.self, forKey: .OneWord) ?? ""
        TwoWords = try values.decodeIfPresent(String.self, forKey: .TwoWords) ?? ""
        _3Times = try values.decodeIfPresent(String.self, forKey: ._3Times) ?? ""
        _5Times = try values.decodeIfPresent(String.self, forKey: ._5Times) ?? ""
        _7Times = try values.decodeIfPresent(String.self, forKey: ._7Times) ?? ""
        Completed = try values.decodeIfPresent(String.self, forKey: .Completed) ?? ""
        Incomplete = try values.decodeIfPresent(String.self, forKey: .Incomplete) ?? ""
        Progress = try values.decodeIfPresent(String.self, forKey: .Progress) ?? ""
        Bookmark = try values.decodeIfPresent(String.self, forKey: .Bookmark) ?? ""
        ShareSummary = try values.decodeIfPresent(String.self, forKey: .ShareSummary) ?? ""
        InfoSettings = try values.decodeIfPresent(String.self, forKey: .InfoSettings) ?? ""
        Downloads = try values.decodeIfPresent(String.self, forKey: .Downloads) ?? ""
        Language = try values.decodeIfPresent(String.self, forKey: .Language) ?? ""
        RestartApp = try values.decodeIfPresent(String.self, forKey: .RestartApp) ?? ""
        RestartAppSummary = try values.decodeIfPresent(String.self, forKey: .RestartAppSummary) ?? ""
    }
}
