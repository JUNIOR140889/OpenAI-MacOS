//
//  FormView.swift
//  OpenAI-MacOS
//
//  Created by Junior Sancho on 6/4/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct FormView: View {
    @State private var email = "";
    @State private var password = "";
    @State private var username = "";
    @State private var fullname = "";
    @State private var date:Date = Date();
    @State private var pickerInput = "Male";
    @State var filename = ""
    
    let pickerOptions = ["Male", "Female", "Other"];
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section(header: Text("Register").font(.headline)) {
                        TextField("Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.vertical);
                        TextField("Username", text: $username)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.vertical);
                        TextField("Fullname", text: $fullname)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.vertical);
                        SecureField("Password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.vertical);
                        DatePicker("Date", selection: $date, displayedComponents: [.date])
                            .padding(.vertical);
                        Picker("Gender", selection: $pickerInput) {
                            ForEach(pickerOptions, id: \.self) { option in
                                Text(option).tag(option);
                            }
                        }
                        .padding(.vertical);
                    }
                }
                .frame(width: 300, height: 400)
                
                Button {
                    if let json = readJson($filename) {
                        let allStrings = extractAllStrings(from: json)
                        print(allStrings)
                        if let replacedJson = replaceStringsInJson(from: json, replacementArray: allStrings) {
                            print(replacedJson)
                            saveJsonWithPanel(dictionary: replacedJson)
                        }
                    }
                } label: {
                    Text("button")
                }
                
                NavigationLink(destination: SomeView()) {
                    Text("Save")
                }
            }
        }
    }
}

#Preview {
    FormView()
}
