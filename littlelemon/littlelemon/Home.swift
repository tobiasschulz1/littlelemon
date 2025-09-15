//
//  Home.swift
//  littlelemon
//
//  Created by Tobias Schulz on 12.09.25.
//

import SwiftUI
import CoreData

struct Home: View {
    @StateObject var viewModel = MenuViewModel()
    let persistenceController = PersistenceController.shared
    var body: some View {
        TabView {
            Menu(viewModel: viewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(viewModel)
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

