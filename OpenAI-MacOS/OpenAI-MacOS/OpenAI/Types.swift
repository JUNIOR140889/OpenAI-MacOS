//
//  Types.swift
//  OpenAI-MacOS
//
//  Created by Junior Sancho on 6/5/24.
//

import Foundation

struct StringUnit: Codable {
    var state: String;
    var value: String;
}

struct Localizations: Codable {
    var localizations: [StringUnit];
}

struct word: Codable {
    
}
