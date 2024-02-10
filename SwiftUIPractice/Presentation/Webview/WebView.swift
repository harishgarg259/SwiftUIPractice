//
//  WebView.swift
//  SwiftUIPractice
//
//  Created by Harish Garg on 05/02/24.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    @Binding var isLoading: Bool
    let type: SafariURL?
    
    func makeCoordinator() -> Coordinator {
        isLoading = true
        return Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        guard let myURL = type?.url else {
                return
        }
        webView.navigationDelegate = context.coordinator
        let request = URLRequest(url: URL(string: myURL)!)
        webView.load(request)
    }
}

class Coordinator: NSObject, WKNavigationDelegate {
    var parent: WebView
    init(_ parent: WebView) {
        self.parent = parent
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        parent.isLoading = false
    }
}

#Preview {
    WebView(isLoading: .constant(true), type: .Blog)
}
