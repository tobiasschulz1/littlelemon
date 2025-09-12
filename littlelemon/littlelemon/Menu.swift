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
    var body: some View {
        VStack {
            Text("Little Lemon")
            Text("Chicago")
            Text("This app lets user order their favorite food from a menu")
            FetchedObjects(predicate: NSPredicate(value: true)) {
                (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        HStack {
                            Text("\(dish.title!) costs \(dish.price!).")
                            AsyncImage(url: URL(string: dish.image!)){ image in
                                image.image?.resizable()
//                                image.image?.scaledToFit()
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            getMenuData()
        }
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
