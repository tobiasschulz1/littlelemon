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
    
    @AppStorage("userFirstName") var userFirstName: String = ""
    @AppStorage("userLastName") var userLastName: String = ""
    @AppStorage("userEmail") var userEmail: String = ""

    var body: some View {
        NavigationStack {
            VStack{
                HStack{
                    Spacer()
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                    Spacer()
                }
                .frame(height: 60)
                .padding(.bottom, 10)
            }
            VStack {
                ZStack {
                    VStack(spacing: 0) {
                        HStack {
                            Text("Little Lemon")
                                .foregroundColor(
                                    Color(
                                        red: 244 / 255,
                                        green: 206 / 255,
                                        blue: 20 / 255
                                    )
                                )
                                .font(.system(size: 48, weight: .bold))
                            Spacer()
                        }
                        HStack {
                            VStack {
                                HStack {
                                    Text("Chicago")
                                        .foregroundColor(.white)
                                        .font(.system(size: 40))
                                    Spacer()
                                }
                                Spacer()
                                    .frame(height: 20)
                                Text(
                                    "We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist."
                                )
                                .foregroundColor(.white)

                            }
                            Image("Hero image")
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(15)
                                .padding(10)
                        }
                    }
                }
                .padding(10)
                .padding(.bottom, 20)
                .background(
                    Color(red: 73 / 255, green: 94 / 255, blue: 87 / 255)
                )
            }
//            .frame(minHeight: 350)
            .padding(.bottom, 30)
            VStack {
                HStack {
                    Text("First name")
                        .padding(.horizontal, 10)
                    Spacer()
                }
                .padding(.bottom, 8)
                TextField("First Name", text: $firstName)
                    .padding(.leading)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .border(
                        Color(
                            red: 217 / 255,
                            green: 217 / 255,
                            blue: 217 / 255
                        )
                    )
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                    .padding(.bottom, 16)
                HStack {
                    Text("Last name")
                        .padding(.horizontal, 10)
                    Spacer()
                }
                .padding(.bottom, 8)
                TextField("Last Name", text: $lastName)
                    .padding(.leading)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .border(
                        Color(
                            red: 217 / 255,
                            green: 217 / 255,
                            blue: 217 / 255
                        )
                    )
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                    .padding(.bottom, 16)
                HStack {
                    Text("Email")
                        .padding(.horizontal, 10)
                    Spacer()
                }
                .padding(.bottom, 8)
                TextField("Email", text: $email)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .padding(.leading)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .border(
                        Color(
                            red: 217 / 255,
                            green: 217 / 255,
                            blue: 217 / 255
                        )
                    )
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                    .padding(.bottom, 16)
                Spacer()
                Button("Register") {
                    if !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty, isValidEmail(email) {
                        UserDefaults.standard.set(
                            firstName,
                            forKey: "firstName"
                        )
                        UserDefaults.standard.set(
                            lastName,
                            forKey: "lastName"
                        )
                        UserDefaults.standard.set(email, forKey: "email")
                        isLoggedIn = true
                        UserDefaults.standard.set(true, forKey: testUserIsLoggedIn)
                    }
                }
                .foregroundColor(.black)
                .font(.system(size: 18, weight: .semibold))
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .background(
                    Color(red: 244 / 255, green: 206 / 255, blue: 20 / 255)
                )
                .border(
                    Color(red: 238 / 255, green: 153 / 255, blue: 114 / 255)
                )
                .cornerRadius(8)
                .padding(.horizontal, 40)
                .padding(.bottom, 16)
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
        .navigationBarBackButtonHidden(true)
    }
}

func isValidEmail(_ email: String) -> Bool {
    let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
}

#Preview {
    Onboarding()
}
