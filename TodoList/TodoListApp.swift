//
//  TodoListApp.swift
//  TodoList
//
//  Created by Sajjad Zafar on 11/10/2022.
//

import SwiftUI

@main
struct TodoListApp: App {
    
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack { // replaces NavigationView
                ListView()
            }
            .environmentObject(listViewModel)
        }
    }
}
