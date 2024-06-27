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
        
        VStack(spacing: 20) {
            Text("Get in Touch")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("If you have any inquiries get in touch with us. We’ll be happy to help you.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            VStack(spacing: 20) {
                Button(action: {
                    if MFMailComposeViewController.canSendMail() {
                        self.isShowingMailView.toggle()
                    }
                }) {
                    HStack {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.gray)
                        Text("admin@pawsitivelycanadian.ca")
                            .foregroundColor(.gray)
                    }
                }
                .sheet(isPresented: $isShowingMailView) {
                    MailComposeViewController(toRecipients: ["admin@pawsitivelycanadian.ca"], mailBody: "Here is mail body") {
                        // Did finish action
                    }
                }
                .alert(isPresented: $showMailErrorAlert) {
                    Alert(title: Text("Error"), message: Text("Could not open the email composer."), dismissButton: .default(Text("OK")))
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                
                Button(action: {
                    if let phoneURL = URL(string: "tel://6047100522"), UIApplication.shared.canOpenURL(phoneURL) {
                        UIApplication.shared.open(phoneURL)
                    }
                }) {
                    HStack {
                        Image(systemName: "phone.fill")
                            .foregroundColor(.gray)
                        Text("Call Us: 604.710.0522")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
            }
            .padding(.horizontal, 40)
            
            Spacer()
                .frame(height: 20)
        }
        .padding(.top, 30)
        
        VStack(alignment: .center,spacing: 10){
            Text("Follow us:")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            HStack(alignment: .center) {
                Button(action: {
                    if let phoneURL = URL(string: "https://www.facebook.com/p/PawsitivelyCanadian-100063621121484/"), UIApplication.shared.canOpenURL(phoneURL) {
                        UIApplication.shared.open(phoneURL)
                    }
                }) {
                    Image("facebook")
                }
                Spacer()
                    .frame(width: 15)
                Button(action: {
                    if let phoneURL = URL(string: "https://www.instagram.com/pawsitivelycanadian/"), UIApplication.shared.canOpenURL(phoneURL) {
                        UIApplication.shared.open(phoneURL)
                    }
                }) {
                    Image("instagram")
                }
            }
        }
        .padding(.horizontal, 20)
        
        Spacer()
        HStack(spacing: 20) {
            VStack(alignment: .leading) {
                Text("Address:")
                    .font(.headline)
                Text("#101 11568 Eburne Way")
                Text("Richmond, BC, Canada")
                Text("V6A 0A7")
            }
            
            VStack(alignment: .leading) {
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
