//
//  CheckoutView.swift
//  Stripe Subscription Payment
//
//  Created by Vikas on 25/10/21.
//

import SwiftUI
import Stripe

struct CheckoutView: View {
    
    @State private var viewModel: SubscriptionViewModel = SubscriptionViewModel()
    @State private var paymentMethodParams: STPPaymentMethodParams = STPPaymentMethodParams()
    @State private var cardFormIsComplete: Bool = false
    
    var body: some View {
        
        VStack{
            
            STPCardFormView.Representable(paymentMethodParams: $paymentMethodParams,
                                          isComplete: $cardFormIsComplete)
                .padding()
            
            Spacer()
            
            Button(action: {
                viewModel.tokenization(cardDetail: paymentMethodParams.card)
            }, label: {
                Text("Proceed to payment")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .cornerRadius(10)
            })
            .padding()
            .buttonStyle(.borderedProminent)
            .shadow(color: .themeColor,radius: 2)
            .disabled(!cardFormIsComplete)
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
    }
}
