
import UIKit
import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public typealias APICompletion = (_ response: [String: Any]?, _ error: Error?) -> Void
public typealias APIRetryBlock = (_ shouldRetry: Bool, _ delay: Double) -> Void

public protocol APIRetrier {
    func shouldRetry(request: URLRequest, response: URLResponse?, completion: @escaping APIRetryBlock)
}

class API {
    public static let shared: API = API()
    public let session: URLSession
    
    private var acceptableStatusCodes: [Int] = Array(200..<300)
    private let apiCallQueue = DispatchQueue(label: "com.API.apiCallQueue")
    
    
    
    // MARK: - INIT
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 120 // seconds
        self.session = URLSession(configuration: configuration)
    }
    
    // MARK: - Helpers
    func headers() -> [String: String] {
        
        return [
            "Content-Type":"application/json"
        ]
    }
    
   
    
    
    
    @discardableResult
    public func unqualifiedRequest(url: String, method: HTTPMethod, headers: [String: String], body: Data?, completion: @escaping APICompletion) -> URLSessionTask {
        
        let request = self.formattedRequest(url: url, method: method, headers: headers, body: body)
        
        let task = self.session.dataTask(with: request, completionHandler: { (data, response, error) in
            self.debugResponsePrint(url: url, method: method, headers: headers, body: body, response: response, error: error, data: data)
            self.apiCallQueue.async {
                guard let data = data, error == nil else {
                    DispatchQueue.main.async { completion(nil, error) }
                    return
                }
                
                do {
                    let dictionary = try JSONSerialization.jsonObject(with: data)
                    if(dictionary is [[String:Any]]) {
                        let dict = ["data":dictionary]
                        
                        DispatchQueue.main.async { completion(dict, nil) }
                    }else {
                        DispatchQueue.main.async { completion(dictionary as? [String:Any], nil) }
                    }
                    
                }
                catch {
                    DispatchQueue.main.async { completion(nil, error) }
                }
            }
        })
        
        task.resume()
        
        return task
    }
    
    public func cancelAllRequests() {
        session.getAllTasks { (tasks) in
            tasks.forEach({ $0.cancel() })
        }
       
    }
    
    private func formattedRequest(url: String, method: HTTPMethod, headers: [String: String], body: Data?) -> URLRequest {
        guard let url = URL(string: url) else {
            return URLRequest(url: URL(string: "https://www.google.com")!)
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        request.httpBody = body
        return request
    }
    
    
    
    
    
    private func debugResponsePrint(url: String?, method: HTTPMethod, headers: [String:Any], body: Data?,response:URLResponse?,error:Error?,data:Data?) {
        print("\n\n\n\n")
        if let url = url {
            print("URL : ",url)
        }
        print("Http Method : ",method.rawValue)
        print("Headers : ",headers.json)
        if let b = body {
            print("Body : ",b.stringValue)
        }
        if let response = response {
            print("Response : ",response)
        }
        if let error = error {
            print("Error : ",error)
        }
        if let d = data {
            print("Response Data : ",d.stringValue)
        }
        print("\n\n\n\n")
    }
    
}



extension Data {
    var json : [String:Any]  {
        get {
            let dictData = try? JSONSerialization.jsonObject(with: self, options: []) as? [String:Any]
            if let dict = dictData {
                return dict
            }
            return [:]
        }
        
    }
    
    var stringValue : String {
        get {
            
            let jsonString = String(decoding: self, as: UTF8.self)
            return jsonString
            
        }
    }
}

extension Dictionary {
    
    var json : String {
        get {
            let jsonData = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            
            if let jsonData = jsonData {
                let jsonString = String(decoding: jsonData, as: UTF8.self)
                return jsonString
            }
            return ""
        }
    }
}
