//
//  CatalogGenerator.swift
//  OpenAI-MacOS
//
//  Created by Junior Sancho on 6/5/24.
//

import Foundation

func generateXcstringsFile(from json: [String: Any], outputPath: String) {
    guard let strings = json["strings"] as? [String: Any] else {
        print("Error: 'strings' key not found in JSON.")
        return
    }

    var content = ""

    for (key, value) in strings {
        if let localizations = value as? [String: Any],
           let esLocalization = localizations["es"] as? [String: Any],
           let stringUnit = esLocalization["stringUnit"] as? [String: Any],
           let translatedValue = stringUnit["value"] as? String {
            // Escape special characters in the translated value
            let escapedValue = translatedValue
                .replacingOccurrences(of: "\\", with: "\\\\")
                .replacingOccurrences(of: "\"", with: "\\\"")
                .replacingOccurrences(of: "\n", with: "\\n")

            // Add the key-value pair to the content
            content += "\"\(key)\" = \"\(escapedValue)\";\n"
        }
    }

    // Write the content to the output file
    do {
        try content.write(toFile: outputPath, atomically: true, encoding: .utf8)
        print("Xcstrings file generated successfully at \(outputPath)")
    } catch {
        print("Error writing xcstrings file: \(error)")
    }
}
