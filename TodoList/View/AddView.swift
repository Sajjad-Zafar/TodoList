//
//  AddView.swift
//  TodoList
//
//  Created by Sajjad Zafar on 12/10/2022.
//

import SwiftUI

struct AddView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    @State var textFieldText: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    @State var showAlert: Bool = false
    @State var alertTitle: String = ""
    @State var alertMessage: String = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                TextField("Add text here...", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 45)
                    .background(Color("textFieldBackground"))
                    .cornerRadius(12)
                
                Button(action: saveItem, label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .frame(height: 45)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(12)
                })
            }
            .padding(14)
        }
        .navigationTitle("Add an Item ✏️")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    func saveItem() {
        guard textIsAppropriate() else {
            alertTitle = "Error"
            alertMessage = "Item name should be atleast 3 characters long 🫥"
            showAlert.toggle()
            return
        }
        listViewModel.appendItem(title: textFieldText)
        presentationMode.wrappedValue.dismiss()
    }
    
    func textIsAppropriate() -> Bool {
        if textFieldText.count > 3 {
            return true
        }
        return false
    }
    
    func getAlert() -> Alert {
        return Alert(
            title: Text(alertTitle),
            message: Text(alertMessage),
            dismissButton: .default(Text("Ok"))
        )
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack { // replaces NavigationView
            AddView()
        }
    }
}
