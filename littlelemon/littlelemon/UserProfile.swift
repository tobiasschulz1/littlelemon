//
//  UserProfile.swift
//  littlelemon
//
//  Created by Tobias Schulz on 12.09.25.
//

import SwiftUI

struct UserProfile: View {
    let firstName: String = UserDefaults.standard.string(forKey: "firstName") ?? ""
    let lastName: String = UserDefaults.standard.string(forKey: "lastName") ?? ""
    let email: String = UserDefaults.standard.string(forKey: "email") ?? ""
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack{
            Text("Personal Information")
            Image("profile-image-placeholder")
            Text(firstName)
            Text(lastName)
            Text(email)
            Button("Logout"){
                UserDefaults.standard.set(false, forKey: "testUserIsLoggedIn")
                self.presentation.wrappedValue.dismiss()
            }
            Spacer()
        }
    }
}

#Preview {
    UserProfile()
}
