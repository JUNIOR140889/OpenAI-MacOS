//
//  FileReader.swift
//  OpenAI-MacOS
//
//  Created by Junior Sancho on 6/12/24.
//

import Cocoa
import SwiftUI

func readJson(_ filename: Binding<String>) -> [String: Any]? {
    let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = false
        panel.allowedContentTypes = [.text, .archive, .json]
    if panel.runModal() == .OK {
        filename.wrappedValue = panel.url?.lastPathComponent ?? "<none>"
        do {
            let data = try Data(contentsOf: panel.url!)
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print("Error reading file: \(error.localizedDescription)")
        }
    }
    return nil
}

func saveJsonWithPanel(dictionary: [String: Any]) {
    let savePanel = NSSavePanel()
    savePanel.title = "Save JSON File"
    savePanel.allowedContentTypes = [.json]
    savePanel.nameFieldStringValue = "modified.json"
    
    savePanel.begin { (result) in
        if result == .OK, let url = savePanel.url {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
                try jsonData.write(to: url)
                print("Modified JSON saved to \(url.path)")
            } catch {
                print("Error saving JSON: \(error)")
            }
        }
    }
}
