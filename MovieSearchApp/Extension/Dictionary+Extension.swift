//
//  Dictionary+Extension.swift
//  MovieSearchApp
//
//  Created by Mitul Patel on 15/07/24.
//

import Foundation


extension Dictionary {
    func urlEncodedString() -> String {
        var components: [String] = []
        
        func encode(_ key: String, _ value: Any) {
            if let dict = value as? [String: Any] {
                for (nestedKey, nestedValue) in dict {
                    encode("\(key)[\(nestedKey)]", nestedValue)
                }
            } else if let array = value as? [Any] {
                for (index, item) in array.enumerated() {
                    encode("\(key)[\(index)]", item)
                }
            } else {
                let encodedKey = urlEncode(key)
                let encodedValue = urlEncode("\(value)")
                let component = "\(encodedKey)=\(encodedValue)"
                components.append(component)
            }
        }

        for (key, value) in self {
            encode("\(key)", value)
        }

        return components.joined(separator: "&")
    }

    private func urlEncode(_ value: String) -> String {
        return value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? value
    }
}
