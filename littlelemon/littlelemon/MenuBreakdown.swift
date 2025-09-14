//
//  MenuBreakdown.swift
//  littlelemon
//
//  Created by Tobias Schulz on 13.09.25.
//

import SwiftUI

struct MenuBreakdown: View {
    var menuCategories: [String] = ["Starters", "Mains", "Desserts", "Drinks"]
    var body: some View {
        VStack{
            HStack{
                Spacer()
                    .frame(width: 20)
                Text("ORDER FOR DELIVERY")
                Spacer()
            }
            
            ScrollView(.horizontal){
                HStack{
                    Spacer()
                        .frame(width: 20)
                    ForEach(menuCategories, id: \.self) { category in
                        Button(category){
                            
                        }
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 73/255, green: 94/255, blue: 87/255))
                            .padding(8)
                            .background(Color(red: 217/255, green: 217/255, blue: 217/255))
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
