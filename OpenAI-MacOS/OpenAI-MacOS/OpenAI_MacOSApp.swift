//
//  OpenAI_MacOSApp.swift
//  OpenAI-MacOS
//
//  Created by Junior Sancho on 6/4/24.
//

import SwiftUI
import OpenAI

@main
struct OpenAI_MacOSApp: App {
    var body: some Scene {
        WindowGroup {
            FormView()
                .onAppear() {
                    Task {
                        try await translate();
                    }
                }
        }
    }
}
