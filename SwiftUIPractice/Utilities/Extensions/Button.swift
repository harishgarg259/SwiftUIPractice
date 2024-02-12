//
//  Button.swift
//  Yappetizer
//
//  Created by Harish Garg on 08/02/24.
//

import SwiftUI

struct CustomButtonModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.title)
      .foregroundColor(.themeColor)
      .padding()
      .background(Color.clear)
      .clipShape(RoundedRectangle(cornerRadius: 10))
  }
}

extension View {
  func customButton() -> some View {
    modifier(CustomButtonModifier())
  }
}
