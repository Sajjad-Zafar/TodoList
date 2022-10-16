//
//  ListView.swift
//  TodoList
//
//  Created by Sajjad Zafar on 11/10/2022.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewmodel: ListViewModel
    
    var body: some View {
        ZStack {
            if listViewmodel.items.isEmpty {
                EmptyView()
                    .transition(
                        AnyTransition.opacity
                            .animation(.easeIn)
                            
                    )
            } else {
                List {
                    ForEach(listViewmodel.items) { item in
                        ListRowView(item: item)
                            .onTapGesture {
                                withAnimation(.linear) {
                                    listViewmodel.updateItem(item: item)
                                }
                            }
                    }
                    .onDelete(perform: listViewmodel.deleteItem)
                    .onMove(perform: listViewmodel.moveItem)
                }
                .toolbar { // replaces navigation bar items
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            AddView()
                        } label: {
                            Text("Add")
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                }
            }
        }
        .navigationTitle("Todo List 📝")
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack { // replaces NavigationView
            ListView()
        }
        .environmentObject(ListViewModel())
    }
}


