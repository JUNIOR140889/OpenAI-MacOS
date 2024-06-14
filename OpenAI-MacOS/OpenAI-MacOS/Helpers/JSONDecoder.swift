//
//  JSONDecoder.swift
//  OpenAI-MacOS
//
//  Created by Junior Sancho on 6/12/24.
//

import Foundation

struct Category: Codable {
    let subCategory: [String: String];
}

struct Subcategory: Codable {
    let item: [String: String]
}

func decodeJSONDecoder(jsonString: String) {
    // Convert the JSON string to Data
    if let jsonData = jsonString.data(using: .utf8) {
        do {
            // Decode the JSON data into a dictionary
            let jsonDict = try JSONDecoder().decode([String: Category].self, from: jsonData)
            print("JSON Dictionary: \(jsonDict)")
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
        }
    } else {
        print("Error converting JSON string to Data")
    }
}

func extractAllStrings(from dictionary: [String: Any]) -> [String] {
    var strings: [String] = []
    
    for (_, value) in dictionary {
        if let stringValue = value as? String {
            strings.append(stringValue)
        } else if let nestedDictionary = value as? [String: Any] {
            strings.append(contentsOf: extractAllStrings(from: nestedDictionary))
        } else if let nestedArray = value as? [Any] {
            strings.append(contentsOf: extractAllStrings(from: nestedArray))
        }
    }
    
    return strings
}

func extractAllStrings(from array: [Any]) -> [String] {
    var strings: [String] = []
    
    for value in array {
        if let stringValue = value as? String {
            strings.append(stringValue)
        } else if let nestedDictionary = value as? [String: Any] {
            strings.append(contentsOf: extractAllStrings(from: nestedDictionary))
        } else if let nestedArray = value as? [Any] {
            strings.append(contentsOf: extractAllStrings(from: nestedArray))
        }
    }
    
    return strings
}
