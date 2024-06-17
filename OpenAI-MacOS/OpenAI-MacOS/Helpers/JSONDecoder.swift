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

func decodeJSON(jsonString: String) {
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
            strings.append(stringValue + "--")
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
            strings.append(stringValue + "--")
        } else if let nestedDictionary = value as? [String: Any] {
            strings.append(contentsOf: extractAllStrings(from: nestedDictionary))
        } else if let nestedArray = value as? [Any] {
            strings.append(contentsOf: extractAllStrings(from: nestedArray))
        }
    }
    
    return strings
}

// To replace Strings in Json

// Recursive function to replace strings in a dictionary
func replaceStrings(in dictionary: [String: Any], using replacementArray: inout [String], index: inout Int) -> [String: Any] {
    var newDictionary = dictionary
    
    for (key, value) in dictionary {
        if value is String {
            newDictionary[key] = replacementArray[index % replacementArray.count]
            index += 1
        } else if let nestedDictionary = value as? [String: Any] {
            newDictionary[key] = replaceStrings(in: nestedDictionary, using: &replacementArray, index: &index)
        } else if let nestedArray = value as? [Any] {
            newDictionary[key] = replaceStrings(in: nestedArray, using: &replacementArray, index: &index)
        }
    }
    
    return newDictionary
}

// Recursive function to replace strings in an array
func replaceStrings(in array: [Any], using replacementArray: inout [String], index: inout Int) -> [Any] {
    var newArray = array
    
    for (idx, value) in array.enumerated() {
        if value is String {
            newArray[idx] = replacementArray[index % replacementArray.count]
            index += 1
        } else if let nestedDictionary = value as? [String: Any] {
            newArray[idx] = replaceStrings(in: nestedDictionary, using: &replacementArray, index: &index)
        } else if let nestedArray = value as? [Any] {
            newArray[idx] = replaceStrings(in: nestedArray, using: &replacementArray, index: &index)
        }
    }
    
    return newArray
}

// Function to replace strings in a JSON file with strings from an array and save the new JSON, returning the filename
func replaceStringsInJson(from json: [String:Any], replacementArray: [String]) -> [String:Any]? {
    var dictionary = json;
    var translations = replacementArray;
    // Replace strings using the replacement array
    var index = 0
    dictionary = replaceStrings(in: json, using: &translations, index: &index)
    
    return dictionary
}

func saveJson(dictionary: [String: Any], to filename: String) {
    let jsonFilePath = FileManager.default.temporaryDirectory.appendingPathComponent(filename + ".json")
    
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        try jsonData.write(to: jsonFilePath)
        print("Modified JSON saved to \(jsonFilePath)")
    } catch {
        print("Error saving JSON: \(error)")
    }
}
