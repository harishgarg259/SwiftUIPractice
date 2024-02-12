//
//  NavigationBar.swift
//  Yappetizer
//
//  Created by Harish Garg on 20/01/24.
//

import SwiftUI

extension View {
    /// CommonAppBar
    public func appBar(title: String, backButtonAction: @escaping() -> Void) -> some View {
        
        self
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        backButtonAction()
                    }) {
                        Image(systemName: "list.bullet")
                    }
                }
            }
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
