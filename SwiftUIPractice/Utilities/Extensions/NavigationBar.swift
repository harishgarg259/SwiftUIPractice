//
//  NavigationBar.swift
//  SwiftUIPractice
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
            .navigationBarItems(leading: Button(action: {
                backButtonAction()
            }) {
                Image("ic-back") // set backbutton image here
                    .renderingMode(.template)
                    .foregroundColor(.gray)
            })
    }
}
