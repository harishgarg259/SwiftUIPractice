//
//  FilterView.swift
//  Yappetizer
//
//  Created by Harish Garg on 04/02/24.
//

import SwiftUI

struct FilterView: View {
    
    @Environment(\.presentationMode) private var presentationMode

    @Binding var showScreen: Bool
    @State private var expanded = true
    @State var selectedText: String = ""
    @StateObject var viewModel: CatagoryViewModel
    var filterCallback: ((String)->Void)?
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(Array(viewModel.menuListArray.enumerated()), id: \.offset) { section, element in
                    DisclosureGroup(element.menuName, isExpanded: $viewModel.menuListArray[section].expandMe) {
                        ForEach(Array(element.subMenus.enumerated()), id: \.offset) { index, subMenu in
                            FilterTableRow(title: subMenu.title ?? "", selectedRow: $selectedText)
                        }.listRowInsets(.init(top: 0, leading: -8, bottom: 0, trailing: 0))
                    }
                }
            }
            .navigationTitle("Select Catogary")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarHidden(false)
            .toolbar {
                Button("Cancel") {
                    selectedText = ""
                    presentationMode.wrappedValue.dismiss()
                }
            }
            
            Button {
                self.filterCallback?(selectedText)
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Filter")
                    .frame(maxWidth: .infinity)
                    .fontWeight(.bold)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .shadow(color: .themeColor,radius: 2)
            .padding()
            .disabled(selectedText.isEmpty)
            .onAppear {
                self.viewModel.catagoryList()
            }
            
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(showScreen: .constant(false), viewModel: CatagoryViewModel())
    }
}
