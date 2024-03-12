//
//  HomeScreen.swift
//  Yappetizer
//
//  Created by Harish Garg on 04/02/24.
//

import SwiftUI

struct HomeScreen: View {
    
    @Binding var showMenu: Bool
    @State private var searchText: String = ""
    @State private var presented = false
    @State var showFab = true
    @State var scrollOffset: CGFloat = 0.00
    @State var badgeCount: Int = 5

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
        NavigationStack {
            ScrollView {
                
                // 4. Populate into grid
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(Array(cards.enumerated()), id: \.offset) { section, element in
                        ProductView(imageDetail: sampleProduct, productName: element, badgeCount: <#Binding<Int>#>)
                            .frame(height: height)
                    }
                }
                .padding()
                .searchable(text: $searchText)
                .onSubmit(of: .search) {
                    searchProducts(for: searchText)
                }
                .background(GeometryReader {
                    return Color.clear.preference(key: ViewOffsetKey.self, value: -$0.frame(in: .named("scroll")).origin.y)
                })
                .onPreferenceChange(ViewOffsetKey.self) { offset in
                    withAnimation {
                        if offset > 50 {
                            showFab = offset < scrollOffset
                        } else  {
                            showFab = true
                        }
                    }
                    scrollOffset = offset
                }
            }
            .padding(10)
            .coordinateSpace(name: "scroll")
            .overlay(
                showFab ? createFab(): nil,
                alignment: Alignment.bottomTrailing
            )
            .navigationTitle("Yappetizer")
            .navigationBarItems(trailing: trailingBarItems)
            .navigationBarItems(leading: leadingBarItems)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .tint(.themeColor)
    }
    
    func searchProducts(for searchText: String) {
        if !searchText.isEmpty {
            //            viewModel.searchImages(searchString: searchText, page: 1)
        }else{
            //            viewModel.records.removeAll()
        }
    }
    
    fileprivate func createFab() -> some View {
        return Button(action: {
            self.presented = true
        }, label: {
            Image(systemName: "slider.horizontal.2.square")
                .font(.title)
                .foregroundColor(.white)
                .frame(width: 35, height: 35, alignment: .center)
        })
        .sheet(isPresented: $presented) {
            FilterView(showScreen: .constant(false), filterModel: FilterViewModel(), selectedText: $searchText)
        }
        .padding(10)
        .background(Color.themeColor)
        .cornerRadius(15)
        .padding(15)
        .shadow(radius: 3,
                x: 3,
                y: 3)
        .transition(.scale)
    }
    
    var trailingBarItems: some View {
        NavigationLink(destination:
            CartView(showMenu: .constant(false))
        )
        {
            Image(systemName: "cart")
                .font(.system(size: 20))
        }
        .overlay(Badge(count: badgeCount))
    }
    
    var leadingBarItems: some View {
        Button(action: {
            withAnimation {
                showMenu.toggle()
            }
        }) {
            Image(systemName: "list.bullet")
                .font(.system(size: 20))
        }
        .padding(5)
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

#Preview {
    HomeScreen(showMenu: .constant(true))
}
