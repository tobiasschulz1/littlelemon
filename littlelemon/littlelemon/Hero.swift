//
//  Hero.swift
//  littlelemon
//
//  Created by Tobias Schulz on 13.09.25.
//

import SwiftUI

struct Hero: View {
    @Binding var searchText: String
    var body: some View {
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
                    Spacer()
                    HStack {
                        Spacer()
                        TextField("Search menu", text: $searchText)
                            .padding(.leading)
                            .frame(width: 300, height: 40)
                            .background(
                                Color(
                                    red: 217 / 255,
                                    green: 217 / 255,
                                    blue: 217 / 255
                                )
                            )
                            .cornerRadius(20)
                        Spacer()
                    }
                }
            }
            .padding(10)
            .background(
                Color(red: 73 / 255, green: 94 / 255, blue: 87 / 255)
            )
        }
    }
}

#Preview {
    Hero(searchText: .constant(""))
}
