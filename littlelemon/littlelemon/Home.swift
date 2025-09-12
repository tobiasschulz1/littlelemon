//
//  Home.swift
//  littlelemon
//
//  Created by Tobias Schulz on 12.09.25.
//

import SwiftUI

struct Home: View {
    var body: some View {
        TabView {
            Menu()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            UserProfile()
                .tabItem {
                    Label("Profile", systemImage: "square.and.pencil")
                }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    Home()
}
