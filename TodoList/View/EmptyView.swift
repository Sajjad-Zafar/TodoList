//
//  SwiftUIView.swift
//  TodoList
//
//  Created by Sajjad Zafar on 16/10/2022.
//

import SwiftUI

struct EmptyView: View {
    
    @State var animate: Bool = false
    let primaryColor = Color("primaryColor")
    let secondaryColor = Color("secondaryColor")
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Image(systemName: "questionmark.folder.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.yellow)
                    .frame(width: 60, height: 60)
                    
                Text("There are no items!")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("Are you a productive person? I think you should click the add button and add a bunch of items to your todo list!")
                    .padding(.bottom, 15)
                NavigationLink(destination: AddView()) {
                    Text("Add something 🥳")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(animate ? primaryColor : secondaryColor)
                        .cornerRadius(12)
                        .padding(.horizontal, animate ? 30 : 50)
                }
                .scaleEffect(animate ? 1.1 : 1.0)
                .offset(y: animate ? -7 : 0)
                .shadow(
                    color: animate ? primaryColor : secondaryColor,
                    radius: animate ? 30: 10,
                    x: 0,
                    y: animate ? 50: 10
                )
            }
            .frame(maxWidth: 400)
            .multilineTextAlignment(.center)
            .padding(40)
        }
        .scrollIndicators(.hidden)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear(perform: addAnimation)
    }
    
    func addAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation.easeInOut(duration: 2.0)
                    .repeatForever()) {
                        animate.toggle()
            }
        }
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            EmptyView()
        }
        .navigationTitle(Text("EmptyView"))
    }
}
