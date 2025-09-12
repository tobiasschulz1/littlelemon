//
//  Onboarding.swift
//  littlelemon
//
//  Created by Tobias Schulz on 12.09.25.
//

import SwiftUI

let testUserFirstName: String = "John"
let testUserLastName: String = "Doe"
let testUserEmail: String = "john.doe@example.com"
let testUserIsLoggedIn = "testUserIsLoggedIn"

struct Onboarding: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var isLoggedIn = false

    var body: some View {
        NavigationStack {
            VStack {
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("Email", text: $email)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                Button("Register") {
                    if !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty, isValidEmail(email) {
                        UserDefaults.standard.set(
                            testUserFirstName,
                            forKey: "firstName"
                        )
                        UserDefaults.standard.set(
                            testUserLastName,
                            forKey: "lastName"
                        )
                        UserDefaults.standard.set(testUserEmail, forKey: "email")
                        isLoggedIn = true
                        UserDefaults.standard.set(true, forKey: testUserIsLoggedIn)
                    }
                }
            }
            .navigationDestination(isPresented: $isLoggedIn) {
                Home()
            }
            .onAppear(){
                if UserDefaults.standard.bool(forKey: testUserIsLoggedIn){
                    isLoggedIn = true
                }
            }
        }
    }
}

func isValidEmail(_ email: String) -> Bool {
    let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
}

#Preview {
    Onboarding()
}
