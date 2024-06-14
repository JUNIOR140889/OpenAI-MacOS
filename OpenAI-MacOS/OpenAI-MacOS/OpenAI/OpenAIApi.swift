//
//  OpenAIApi.swift
//  OpenAI-MacOS
//
//  Created by Junior Sancho on 6/4/24.
//

import Foundation
import OpenAI

let openAI = OpenAI(apiToken: "");

let jsonExample = "{\"sourceLanguage\":\"en\",\"strings\":{\"Date\":{\"localizations\":{\"es\":{\"stringUnit\":{\"state\":\"translated\",\"value\":\"Fecha\"}}}},\"Email\":{\"localizations\":{\"es\":{\"stringUnit\":{\"state\":\"translated\",\"value\":\"Correo\"}}}},\"Memory\":{\"localizations\":{\"es\":{\"stringUnit\":{\"state\":\"translated\",\"value\":\"Memoria\"}}}},\"Ending\":{\"localizations\":{\"es\":{\"stringUnit\":{\"state\":\"translated\",\"value\":\"Final\"}}}},\"version\":\"1.0\"}}"

enum Languages:Hashable {
    case english, spanish;
    
    var language: String {
        switch self {
        case .english: return "english";
        case .spanish: return "spanish";
        }
    }
}

func translate() async throws -> String {
    // var prompt = "Give me the translations of this expresions in " + language.language + "separated by a comma: ";
    // for word in words {
        // prompt += word + " - "
    // }
    let prompt2 = "Hello there"
    let query = CompletionsQuery(model: .gpt3_5Turbo, prompt: prompt2, temperature: 0, maxTokens: 100, topP: 1, frequencyPenalty: 0, presencePenalty: 0, stop: ["\\n"])
    let result = try await openAI.completions(query: query);
    
    return result.choices[0].text;
}
