//
//  UserProfile.swift
//  littlelemon
//
//  Created by Tobias Schulz on 12.09.25.
//

import SwiftUI

struct UserProfile: View {
    @State var firstName: String =
        UserDefaults.standard.string(forKey: "firstName") ?? "1"
    @State var lastName: String =
        UserDefaults.standard.string(forKey: "lastName") ?? "2"
    @State var email: String = UserDefaults.standard.string(forKey: "email") ?? "3"
    @Environment(\.presentationMode) var presentation

    var tempFirstName: String = ""
    var tempLastName: String = ""
    var tempEmail: String = ""

    @State var showEmailAlert: Bool = false
    @State var showSuccessfulChangeAlert: Bool = false
    @State var showOnboarding: Bool = false

    var body: some View {
        VStack {
            Header()
                .allowsHitTesting(false)
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(
                                Color(
                                    red: 217 / 255,
                                    green: 217 / 255,
                                    blue: 217 / 255
                                ),
                                lineWidth: 1
                            )
                    )
                VStack(spacing: 4) {
                    HStack {
                        Text("Personal information")
                            .font(.system(size: 20, weight: .bold))
                        Spacer()
                    }
                    .padding(.bottom, 16)
                    //                    VStack {
                    //                        HStack {
                    //                            Text("Avatar")
                    //                            Spacer()
                    //                        }
                    //                        HStack {
                    //                            Image("profile-image-placeholder")
                    //                                .resizable()
                    //                                .scaledToFit()
                    //                            Spacer()
                    //                        }
                    //                    }
                    HStack {
                        Text("First name")
                        Spacer()
                    }
                    .padding(.bottom, 8)
                    TextField(firstName, text: $firstName)
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
                        .padding(.bottom, 16)
                    HStack {
                        Text("Last name")
                        Spacer()
                    }
                    .padding(.bottom, 8)

                    TextField(lastName, text: $lastName)
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
                        .padding(.bottom, 16)
                    HStack {
                        Text("Email")
                        Spacer()
                    }
                    .padding(.bottom, 8)

                    TextField(email, text: $email)
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
                    //                        .padding(.bottom, 32)
                    Spacer()
                    NavigationStack{
                        Button("Log out") {
                            UserDefaults.standard.set(
                                false,
                                forKey: "testUserIsLoggedIn"
                            )
                            showOnboarding = true
//                            self.presentation.wrappedValue.dismiss()
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
                        .padding(.horizontal, 16)
                        .padding(.bottom, 24)
                    }
                    .navigationDestination(isPresented: $showOnboarding) {
                        Onboarding()
                    }
                    HStack {
                        Spacer()
                        Button("Discard Changes") {
                            firstName = UserDefaults.standard.string(forKey: "firstName")!
                            lastName = UserDefaults.standard.string(forKey: "lastName")!
                            email = UserDefaults.standard.string(forKey: "email")!
                        }
                        .foregroundColor(Color(
                            red: 175 / 255,
                            green: 175 / 255,
                            blue: 175 / 255
                        ))
                        .font(.system(size: 16, weight: .semibold))
                        .frame(width: 160, height: 40)
                        .border(Color(red: 73 / 255, green: 94 / 255, blue: 87 / 255))
                        .background(Color(.white))
                        .cornerRadius(8)
                        Spacer()
                        Button("Save Changes") {
                            showEmailAlert = false
                            showSuccessfulChangeAlert = false
                            if !isValidEmail(email) {
                                showEmailAlert = true
                            } else if !firstName.isEmpty, !lastName.isEmpty,
                                !email.isEmpty, isValidEmail(email)
                            {
                                UserDefaults.standard.set(
                                    firstName,
                                    forKey: "firstName"
                                )
                                UserDefaults.standard.set(
                                    lastName,
                                    forKey: "lastName"
                                )
                                UserDefaults.standard.set(
                                    email,
                                    forKey: "email"
                                )
                                showSuccessfulChangeAlert = true
//                                self.firstName = firstName
//                                self.lastName = lastName
//                                self.email = email
                            }
                        }
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .semibold))
                        .frame(width: 160, height: 40)
                        .border(Color(red: 73 / 255, green: 94 / 255, blue: 87 / 255))
                        .background(Color(red: 73 / 255, green: 94 / 255, blue: 87 / 255))
                        .cornerRadius(8)
                        Spacer()
                    }
                    .padding(.bottom, 16)
                }
                .padding(10)
            }
            .padding(20)

            Spacer()

        }
        .alert(
            "Invalid Email!",
            isPresented: $showEmailAlert
        ) {
            Button("OK", role: .cancel) {}
        }
        .alert(
            "Changes successfully saved!",
            isPresented: $showSuccessfulChangeAlert
        ) {
            Button("OK", role: .cancel) {}
        }
        .onAppear {
            firstName = UserDefaults.standard.string(forKey: "firstName") ?? ""
            lastName = UserDefaults.standard.string(forKey: "lastName") ?? ""
            email = UserDefaults.standard.string(forKey: "email") ?? ""
        }
    }
}

#Preview {
    UserProfile()
}
