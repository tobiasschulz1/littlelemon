//
//  Menu.swift
//  littlelemon
//
//  Created by Tobias Schulz on 12.09.25.
//

import CoreData
import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var searchText: String = ""
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [
            NSSortDescriptor(
                key: "title",
                ascending: true,
                selector: #selector(NSString.localizedStandardCompare)
            )
        ]
    }
    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            return NSPredicate(value: true)
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
    var body: some View {
        //        ScrollView(.vertical){
        VStack {
            Header()
            Hero(searchText: $searchText)
            MenuBreakdown()

            FetchedObjects(
                predicate: buildPredicate(),
                sortDescriptors: buildSortDescriptors()
            ) {
                (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        VStack(spacing: 2) {
                            HStack {
                                Text(dish.title!)
                                    //                                .foregroundColor(Color(red: <#T##Double#>, green: <#T##Double#>, blue: <#T##Double#>))
                                    .font(.system(size: 20, weight: .bold))
                                Spacer()
                            }
                            HStack {
                                VStack {
                                    HStack{
                                        Text(dish.itemDescription!)
                                        Spacer()
                                    }
                                    .padding(.bottom, 5)
                                    HStack{
                                        Text("$\(dish.price!)")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundColor(Color(red: 73 / 255, green: 94 / 255, blue: 87 / 255))
                                        Spacer()
                                    }
                                }
                                //                                Text("\(dish.title!) costs \(dish.price!).")
                                Spacer()
                                Rectangle()
                                    .aspectRatio(1, contentMode: .fit)
                                    .frame(maxWidth: 100, maxHeight: 100)
                                    .overlay(
                                        AsyncImage(
                                            url: URL(string: dish.image!)
                                        ) {
                                            image in
                                            image.image?
                                                .resizable()
                                                .scaledToFill()
                                            //                                    .frame(maxWidth: 100, maxHeight: 100)
                                            //                                    .clipped()
                                            //                                    .aspectRatio(1, contentMode: .fit)
                                        }
                                    )
                                    .clipShape(Rectangle())
                            }
                        }

                    }
                }
                .listStyle(.plain)
            }
        }

        .onAppear {
            getMenuData()
        }

        //        }
    }

    func getMenuData() {
        PersistenceController.shared.clear()
        let url: URL = URL(
            string:
                "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        )!
        let urlRequest: URLRequest = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: urlRequest) {
            data,
            response,
            error in
            if let error = error {
                print("Request failed with error: \(error)")
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                print("HTTP Status: \(httpResponse.statusCode)")
            }
            if let data = data {
                Task { @MainActor in
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase

                    do {
                        let response = try decoder.decode(
                            MenuList.self,
                            from: data
                        )
                        let menuData = response.menu
                        for menuItem in menuData {
                            let dish = Dish(context: viewContext)
                            dish.title = menuItem.title
                            dish.price = menuItem.price
                            dish.image = menuItem.image
                            dish.itemDescription = menuItem.itemDescription
                            dish.category = menuItem.category
                        }
                        do {
                            try viewContext.save()
                        } catch {
                            print("Failed to save context: \(error)")
                        }
                    } catch {
                        print("Failed to decode JSON: \(error)")
                    }
                }
            } else {
                print("No data received")
            }
        }

        task.resume()
    }
}

#Preview {
    Menu()
}
