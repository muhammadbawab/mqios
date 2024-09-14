import Foundation

enum NetworkError: Error {
    case badUrl
    case invalidRequest
    case badResponse
    case badStatus
    case failedToDecodeResponse
}

extension Dictionary {
    func percentEncoded() -> Data? {
        map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed: CharacterSet = .urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}

class WebService {
    
    func downloadData<T: Codable>(fromURL: String, params: [String: Any]) async -> T? {
                
        var request = URLRequest(url: URL(string: fromURL)!)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        request.httpBody = params.percentEncoded()
                
        var (data, response) = try! await URLSession.shared.data(for: request)
        response = (response as? HTTPURLResponse)!
        let decodedResponse = try! JSONDecoder().decode(T.self, from: data)
        
        return decodedResponse
    }
}

@MainActor class Apis: ObservableObject {
    
    func login(email: String, password: String) async -> UserResponse? {
        
        let params: [String: Any] = [
            "key": "396143f45a51d4157777290a5cfc4c8c",
            "email": email,
            "password": password
        ]
        
        return await WebService().downloadData(fromURL: "https://mualim-alquran.com/apis/login", params: params)        
    }
    
    func create(name: String, email: String, password: String) async -> UserResponse? {
        
        let params: [String: Any] = [
            "key": "396143f45a51d4157777290a5cfc4c8c",
            "name": name,
            "email": email,
            "password": password
        ]
        
        return await WebService().downloadData(fromURL: "https://mualim-alquran.com/apis/create", params: params)
    }
    
    func google(name: String, email: String) async -> UserResponse? {
        
        let params: [String: Any] = [
            "key": "396143f45a51d4157777290a5cfc4c8c",
            "name": name,
            "email": email
        ]
        
        return await WebService().downloadData(fromURL: "https://mualim-alquran.com/apis/google", params: params)
    }
    
    func forgot(email: String) async -> UserResponse? {
        
        let params: [String: Any] = [
            "key": "396143f45a51d4157777290a5cfc4c8c",
            "email": email
        ]
        
        return await WebService().downloadData(fromURL: "https://mualim-alquran.com/apis/forgot", params: params)
    }
    
    func bookmark(id: String, surah: String, ayah: String) async -> UserResponse? {
        
        let params: [String: Any] = [
            "key": "396143f45a51d4157777290a5cfc4c8c",
            "id": id,
            "surah": surah,
            "ayah": ayah
        ]
        
        return await WebService().downloadData(fromURL: "https://mualim-alquran.com/apis/bookmark", params: params)
    }
    
    func syncBookmark(id: String, surah: String, ayah: String, date: String) async -> UserResponse? {
        
        let params: [String: Any] = [
            "key": "396143f45a51d4157777290a5cfc4c8c",
            "id": id,
            "surah": surah,
            "ayah": ayah,
            "date": date
        ]
        
        return await WebService().downloadData(fromURL: "https://mualim-alquran.com/apis/syncBookmark", params: params)
    }
    
    func memorizing(id: String, type: String, item: String) async -> UserResponse? {
        
        let params: [String: Any] = [
            "key": "396143f45a51d4157777290a5cfc4c8c",
            "id": id,
            "type": type,
            "item": item
        ]            
        
        return await WebService().downloadData(fromURL: "https://mualim-alquran.com/apis/memorizing", params: params)
    }
    
    func syncMemorizing(id: String) async -> UserResponse? {
        
        let params: [String: Any] = [
            "key": "396143f45a51d4157777290a5cfc4c8c",
            "id": id
        ]
        
        return await WebService().downloadData(fromURL: "https://mualim-alquran.com/apis/syncMemorizing", params: params)
    }
    
    func feedback(name: String, email: String, feedback: String) async -> UserResponse? {
        
        let params: [String: Any] = [
            "key": "396143f45a51d4157777290a5cfc4c8c",
            "name": name,
            "email": email,
            "feedback": feedback
        ]
        
        return await WebService().downloadData(fromURL: "https://mualim-alquran.com/apis/feedback", params: params)
    }
    
    static func validateResponse(mvm: MainViewModel, type: String, model: UserResponse?, rh: ResponseHandler, callback: ((UserResponse) -> ())? = nil) {
        
        var successMessage = ""
        var errorMessage = "Failed to retrieve user information, please try again"
        var submitText = mvm.home.Login
        
        if (type == "forgot") {
            successMessage = "You will receive an email with instructions on resetting your password"
            errorMessage = ""
            submitText = mvm.home.Submit
        }
        
        if (type == "create") {
            submitText = mvm.home.Submit
        }
        
        if (type == "feedback") {
            successMessage = "Your feedback is submitted successfully"
            errorMessage = ""
            submitText = mvm.home.Submit
        }
        
        if (model != nil) {
            
            if (model!.code == 200) {
                
                if (type == "forgot" || type == "feedback") {
                
                    rh.success = true
                    rh.successMessage = successMessage
                    rh.submitText = submitText
                    rh.submitLoading = false
                    rh.submitEnabled = true
                    
                    if (callback != nil) {
                        callback!(model!)
                    }
                }
                else {
                    
                    let data = model!.data ?? []
                    
                    if (!data.isEmpty) {
                        
                        if (callback != nil) {
                            callback!(model!)
                        }
                        
                    } else {
                        rh.error = true
                        rh.errorMessage = errorMessage
                        rh.submitText = submitText
                        rh.submitLoading = false
                        rh.submitEnabled = true
                    }
                }
                
            } else {
                rh.error = true
                rh.errorMessage = model!.message ?? ""
                rh.submitText = submitText
                rh.submitLoading = false
                rh.submitEnabled = true
            }
        }
        else {
            rh.error = true
            rh.errorMessage = "Error occurred, please try again"
            rh.submitText = submitText
            rh.submitLoading = false
            rh.submitEnabled = true
        }
    }
}
