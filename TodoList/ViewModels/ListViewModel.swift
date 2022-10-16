//
//  ListViewModel.swift
//  TodoList
//
//  Created by Sajjad Zafar on 12/10/2022.
//

import Foundation

final class ListViewModel: ObservableObject {
    
    enum UserDefaultKeys: String {
        case items = "items_list"
    }
    
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItems()
        }
    }
    
    init() {
        getItems()
    }
    
    func getItems() {
        guard
            let decodedData = UserDefaults.standard.data(forKey: UserDefaultKeys.items.rawValue),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: decodedData)
        else { return }
        self.items = savedItems
    }
    
    func appendItem(title: String) {
        items.append(ItemModel(title: title, isCompleted: false))
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func updateItem(item: ItemModel) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.updateCompletion()
        }
    }
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.setValue(encodedData, forKey: UserDefaultKeys.items.rawValue)
        }
    }
}
