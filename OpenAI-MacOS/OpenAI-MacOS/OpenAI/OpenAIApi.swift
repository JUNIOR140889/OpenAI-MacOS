//
//  OpenAIApi.swift
//  OpenAI-MacOS
//
//  Created by Junior Sancho on 6/4/24.
//

import Foundation
import OpenAI

let openAI = OpenAI(apiToken: "");

enum Languages:Hashable {
    case english, spanish;
    
    var language: String {
        switch self {
        case .english: return "english";
        case .spanish: return "spanish";
        }
    }
}

func translate(text:String, language: Languages) async throws -> String {
    let prompt = "Translate the following English text to " + language.language + ": " + text;
    let query = CompletionsQuery(model: .gpt3_5Turbo, prompt: prompt, temperature: 0, maxTokens: 100, topP: 1, frequencyPenalty: 0, presencePenalty: 0, stop: ["\\n"])
    let result = try await openAI.completions(query: query);
    return result.choices[0].text;
}
