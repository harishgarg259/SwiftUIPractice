//
//  ContentView.swift
//  SwiftUIPractice
//
//  Created by Harish Garg on 11/01/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Text("SwiftUI")
                .navigationTitle("Welcome")
                .toolbar {
                    ToolbarItemGroup(placement: .primaryAction) {
                        Button("About") {
                            print("About tapped!")
                        }

                        Button("Help") {
                            print("Help tapped!")
                        }
                    }

                    ToolbarItemGroup(placement: .secondaryAction) {
                        Button("Settings") {
                            print("Credits tapped")
                        }

                        Button("Email Me") {
                            print("Email tapped")
                        }
                    }
                }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
