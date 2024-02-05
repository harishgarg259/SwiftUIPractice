//
//  FilterView.swift
//  SwiftUIPractice
//
//  Created by Harish Garg on 04/02/24.
//

import SwiftUI

class FilterViewModel: ObservableObject {
    
    @Published var animalsGroups = [
        AnimalGroup(groupName: "Shop Dogs", animals: [
            Animal(name: "Dehydrated Dog Treats"),
            Animal(name: "Baked Treats"),
            Animal(name: "Bulk Dog Treats"),
            Animal(name: "Flea & Tick"),
            Animal(name: "Bully Sticks"),
            Animal(name: "Functional Treats"),
            Animal(name: "Chews"),
            Animal(name: "Dog Food"),
            Animal(name: "Food Enhancers"),
            Animal(name: "Freeze Dried Treats"),
            Animal(name: "Grooming & Cleaning"),
            Animal(name: "Health & Wellness"),
            Animal(name: "Waste Management"),
            Animal(name: "Toys and Accessories")
        ], expandMe: true),
        AnimalGroup(groupName: "Shop Cats", animals: [
            Animal(name: "Cat Food"),
            Animal(name: "Dehydrated"),
            Animal(name: "Food Enhancers"),
            Animal(name: "Fleas and Ticks"),
            Animal(name: "Freeze Dried"),
            Animal(name: "Health & Wellness")
        ], expandMe:false),
        AnimalGroup(groupName: "Our Brands", animals: [
            Animal(name: "Beau Canine Essentials"),
            Animal(name: "Chow Time Pet Foods"),
            Animal(name: "Dog Delights"),
            Animal(name: "Earth Rated"),
            Animal(name: "Feelgood Treat"),
            Animal(name: "Healthy Shores"),
            Animal(name: "KaliWags"),
            Animal(name: "Nature’s Gaia"),
            Animal(name: "NutriBites"),
            Animal(name: "Granville Island Treatery"),
            Animal(name: "Great Jack’s"),
            Animal(name: "PawsitivelyCanadian"),
            Animal(name: "Raw Bone Pet Food Co."),
            Animal(name: "Smack"),
            Animal(name: "Sensitiva"),
            Animal(name: "Great Jack’s"),
            Animal(name: "Snack 21"),
            Animal(name: "Toreros"),
            Animal(name: "FoleyBites"),
            Animal(name: "Woof Concept"),
            Animal(name: "Yappetizers")
        ], expandMe: false)
    ]

    init() {
    }
}

struct FilterView: View {
    
    @Environment(\.presentationMode) private var presentationMode

    @Binding var showScreen: Bool
    @Binding var selectedIndex: Int
    @State private var expanded = true
    @ObservedObject var filterModel: FilterViewModel

    var body: some View {
        
        List {
            ForEach(Array(filterModel.animalsGroups.enumerated()), id: \.offset) { section, element in
                DisclosureGroup(element.groupName, isExpanded: $filterModel.animalsGroups[section].expandMe) {
                    ForEach(Array(element.animals.enumerated()), id: \.offset) { index, animal in
                        FilterTableRow(title: animal.name, index: index, markIndex: $selectedIndex)
                    }.listRowInsets(.init(top: 0, leading: -8, bottom: 0, trailing: 0))
                }
            }
        }
//        .listStyle(.automatic)
        .navigationTitle("Filters")
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(showScreen: .constant(false), selectedIndex: .constant(0), filterModel: FilterViewModel())
    }
}
