//
//  ContactUS.swift
//  Yappetizer
//
//  Created by Harish Garg on 25/06/24.
//

import SwiftUI
import MessageUI

struct ContactUsView: View {
    @State private var isShowingMailView = false
    @State private var showMailErrorAlert = false
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 20) {
            
            Button(action: {
                if MFMailComposeViewController.canSendMail() {
                    self.isShowingMailView.toggle()
                }
            }) {
                HStack {
                    Image(systemName: "envelope.fill")
                    Text("Email Us")
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .sheet(isPresented: $isShowingMailView) {
                MailComposeViewController(toRecipients: ["admin@pawsitivelycanadian.ca"], mailBody: "Here is mail body") {
                    // Did finish action
                }
            }
            .alert(isPresented: $showMailErrorAlert) {
                Alert(title: Text("Error"), message: Text("Could not open the email composer."), dismissButton: .default(Text("OK")))
            }
            
            Button(action: {
                if let phoneURL = URL(string: "tel://6047100522"), UIApplication.shared.canOpenURL(phoneURL) {
                    UIApplication.shared.open(phoneURL)
                }
            }) {
                HStack {
                    Image(systemName: "phone.fill")
                    Text("Call Us: 604.710.0522")
                }
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)
            
        }
        
        Spacer()
        
        HStack(spacing: 20) {
            VStack {
                Text("Address:")
                    .font(.headline)
                Text("#101 11568 Eburne Way")
                Text("Richmond, BC, Canada")
                Text("V6A 0A7")
            }
            
            VStack {
                Text("Business Hours:")
                    .font(.headline)
                Text("24/7 7 days a week")
            }
        }
        
        .navigationBarTitle("Contact US",displayMode: .inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .tint(.themeColor)
    }
}

struct MailComposeViewController: UIViewControllerRepresentable {
    
    var toRecipients: [String]
    var mailBody: String
    
    var didFinish: ()->()
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MailComposeViewController>) -> MFMailComposeViewController {
        
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = context.coordinator
        mail.setToRecipients(self.toRecipients)
        mail.setMessageBody(self.mailBody, isHTML: true)
        
        return mail
    }
    
    final class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        
        var parent: MailComposeViewController
        
        init(_ mailController: MailComposeViewController) {
            self.parent = mailController
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            parent.didFinish()
            controller.dismiss(animated: true)
        }
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<MailComposeViewController>) {
        
    }
}

struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsView()
    }
}
