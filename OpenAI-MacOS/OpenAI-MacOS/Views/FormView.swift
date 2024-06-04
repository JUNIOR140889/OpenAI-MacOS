//
//  FormView.swift
//  OpenAI-MacOS
//
//  Created by Junior Sancho on 6/4/24.
//

import SwiftUI

struct FormView: View {
    @State private var email = "";
    @State private var password = "";
    @State private var username = "";
    @State private var fullname = "";
    @State private var date:Date = Date();
    @State private var pickerInput = "Option 1";
    
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
                
                NavigationLink(destination: SomeView()) {
                    Button(action: {
                        print(email, username, fullname, password, date, pickerInput)
                    }, label: {
                        Text("Press button")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    })
                }
            }
        }
    }
}

#Preview {
    FormView()
}
