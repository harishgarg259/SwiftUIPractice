//
//  AlertView.swift
//  Yappetizer
//
//  Created by Harish Garg on 19/02/24.
//

import SwiftUI


public class AlertContext: PresentationContext<Alert> {
    
    public override func content() -> Alert {
        contentView ?? Alert(title: Text(""))
    }
    
    public func present(_ provider: AlertProvider) {
        contentView = provider.alert
    }
}

public class PresentationContext<Content>: ObservableObject {
    
    public init() {}
    
    @Published public var isActive = false
    
    public var isActiveBinding: Binding<Bool> {
        .init(get: { self.isActive },
              set: { self.isActive = $0 }
        )
    }
    
    open func content() -> Content { contentView! }
    
    public internal(set) var contentView: Content? {
        didSet { isActive = contentView != nil }
    }
    
    public func dismiss() {
        isActive = false
    }
    
    public func present(_ content: Content) {
        contentView = content
    }
}

public protocol AlertProvider {
    
    var alert: Alert { get }
}

enum AppAlert: AlertProvider {
    
    case test
    case warning(message: String)
    
    var alert: Alert {
        Alert(title: Text(message))
    }
}

private extension AppAlert {

    var message: String {
        switch self {
        case .test: return "This is a test alert"
        case .warning(let message): return message
        }
    }
}

public extension View {
    
    func alert(_ context: AlertContext) -> some View {
        alert(isPresented: context.isActiveBinding, content: context.content)
    }
}
