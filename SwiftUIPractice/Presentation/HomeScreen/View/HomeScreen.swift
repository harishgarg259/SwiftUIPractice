//
//  HomeScreen.swift
//  SwiftUIPractice
//
//  Created by Harish Garg on 04/02/24.
//

import SwiftUI

struct HomeScreen: View {
    
    @Binding var showMenu: Bool
    @State private var searchText: String = ""
    @State private var presented = false
    
    // 1. Number of items will be display in row
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible()),
    ]
    // 2. Fixed height of card
    let height: CGFloat = 200
    // 3. Get mock cards data
    let cards: [String] = ["Kangroo","Venison","Kangroo","Venison","Kangroo","Venison","Kangroo","Venison","Kangroo","Venison"]
    
    
    var body: some View {
        ScrollView {
            
            HStack {
                SearchBar(text: $searchText, onTextChanged: searchImages)
                Button("Filters") {
                    self.presented = true
                }
//                if presented{
//                    FilterView(showScreen: .constant(false), selectedIndex: .constant(0), filterModel: FilterViewModel())
//                        .padding(.top,100)
//                        .transaction { transaction in
//                            transaction
//                                .move(edge: .bottom)
//                        }
//                        .animation(.spring())
//                }
                .sheet(isPresented: $presented) {
                    FilterView(showScreen: .constant(false), selectedIndex: .constant(0), filterModel: FilterViewModel())
                }
                .frame(width: 80, height: 30)
                .padding(5)
                .font(.headline)
                .background(Color.white)
                .cornerRadius(4)
                .shadow(radius: 2)
            }
            
            // 4. Populate into grid
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(Array(cards.enumerated()), id: \.offset) { section, element in
                    ProductView(productName: element)
                        .frame(height: height)
                }
            }
            .padding()
        }
        .padding(10)
        .appBar(title: "Yappatizers") {
            withAnimation {
                showMenu.toggle()
            }
        }
    }
    
    func searchImages(for searchText: String) {
        if !searchText.isEmpty {
//            viewModel.searchImages(searchString: searchText, page: 1)
        }else{
//            viewModel.records.removeAll()
        }
    }
}

#Preview {
    HomeScreen(showMenu: .constant(false))
}
