//
//  Header.swift
//  littlelemon
//
//  Created by Tobias Schulz on 13.09.25.
//

import SwiftUI

struct Header: View {
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                NavigationLink(destination: UserProfile()) {
                    Image("Profile")
                        .resizable()
                        .scaledToFit()
                        .padding(.trailing, 20)
                }
            }
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 50)
        }
        .frame(height: 60)
        .padding(.bottom, 10)
    }
}

#Preview {
    Header()
}
