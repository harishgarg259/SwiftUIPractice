//
//  DetailView.swift
//  SwiftUIPractice
//
//  Created by Harish Garg on 22/01/24.
//

import SwiftUI

struct CartView: View {
    
    @Binding var showMenu: Bool

    var body: some View {
        VStack {
            Text("This is cart view")
        }
        .navigationTitle("Cart")
    }
}

struct SearchImageContent_Previews: PreviewProvider {
    static var previews: some View {
        CartView(showMenu: .constant(true))
    }
}
