//
//  MenuBreakdown.swift
//  littlelemon
//
//  Created by Tobias Schulz on 13.09.25.
//

import SwiftUI

struct MenuBreakdown: View {
    @EnvironmentObject var viewModel: MenuViewModel
    let menuCategories: [String] = ["Starters", "Mains", "Desserts", "Drinks"]

    var body: some View {
        VStack {
            Spacer()
                .frame(height: 20)
            HStack {
                Spacer()
                    .frame(width: 20)
                Text("ORDER FOR DELIVERY!")
                    .font(.system(size: 20, weight: .bold))
                Spacer()
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Spacer()
                        .frame(width: 20)
                    ForEach(menuCategories, id: \.self) { category in
                        Button(category) {
                            if !(viewModel.selectedCategory == category) {
                                viewModel.selectedCategory = category
                            } else {
                                viewModel.resetFilter()
                            }
                        }
                        .fontWeight(.bold)
                        .foregroundColor(
                            viewModel.selectedCategory == category
                                ? Color(
                                    red: 217 / 255,
                                    green: 217 / 255,
                                    blue: 217 / 255
                                )
                                : Color(
                                    red: 73 / 255,
                                    green: 94 / 255,
                                    blue: 87 / 255
                                )
                        )
                        .padding(8)
                        .background(
                            viewModel.selectedCategory == category
                                ? Color(
                                    red: 73 / 255,
                                    green: 94 / 255,
                                    blue: 87 / 255
                                )
                                : Color(
                                    red: 217 / 255,
                                    green: 217 / 255,
                                    blue: 217 / 255
                                )
                        )
                        .cornerRadius(10)
                        Spacer()
                            .frame(width: 40)
                    }
                }
            }
        }
    }
}

#Preview {
    MenuBreakdown()
}
