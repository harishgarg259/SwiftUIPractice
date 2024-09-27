//
//  ToastView.swift
//  Yappetizer
//
//  Created by Harish Garg on 2024-09-25.
//

import Foundation
import SwiftUI

class ToastPresenter {
    private var toastWindow: UIWindow?
    
    func show(toast: String) {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        toastWindow = UIWindow(windowScene: scene)
        toastWindow?.backgroundColor = .clear
        
        // Start with the window off-screen at the top
        toastWindow?.frame = CGRect(x: 50, y: -100, width: 300, height: 100)
        
        let view = Text(toast)
            .padding()
            .background(Color.black)
            .foregroundColor(Color.white)
            .cornerRadius(10)
        
        toastWindow?.rootViewController = UIHostingController(rootView: view)
        toastWindow?.rootViewController?.view.backgroundColor = .clear
        toastWindow?.makeKeyAndVisible()
        
        // Animate the window sliding down
        UIView.animate(withDuration: 0.5, animations: {
            self.toastWindow?.frame = CGRect(x: 50, y: 50, width: 300, height: 100)
        })
        
        // Hide the toast automatically after 2 seconds with slide up animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.animate(withDuration: 0.5, animations: {
                self.toastWindow?.frame = CGRect(x: 50, y: -100, width: 300, height: 100)
            }) { _ in
                self.toastWindow?.isHidden = true
                self.toastWindow = nil
            }
        }
    }
}
