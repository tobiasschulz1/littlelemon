//
//  MenuViewModel.swift
//  littlelemon
//
//  Created by Tobias Schulz on 15.09.25.
//

import Foundation
import SwiftUI
import Combine

class MenuViewModel: ObservableObject {
    @Published var selectedCategory: String = ""
    
    func resetFilter() {
        selectedCategory = ""
    }
}
