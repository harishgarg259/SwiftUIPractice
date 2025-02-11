//
//  CouponView.swift
//  Yappetizer
//
//  Created by Harish Garg on 2024-10-01.
//

import SwiftUI
import ActivityIndicatorView

struct CouponView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel: CouponViewModel = CouponViewModel()
    @Binding var selectedCoupon: CouponItem?
    @State var showLoadingIndicator = false
    let totalPrice: Double?

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 8) {
                List{
                    Section(header: Text("SEARCH COUPONS")) {
                        HStack {
                            TextField("Enter coupon code", text: $viewModel.couponCode)
                                .padding()
                                .textCase(.uppercase)
                                .frame(height: 40)
                                .font(.system(size: 14,weight: .semibold))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                            Spacer()
                            Button(action: {
                                self.showLoadingIndicator = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                    self.selectedCoupon = viewModel.selectedCoupon
                                    self.showLoadingIndicator = false
                                    ToastPresenter().show(toast: "Coupon Applied.")
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                            }) {
                                Text("CHECK")
                                    .font(.system(size: 16,weight: .bold))
                                    .foregroundColor(.theme)
                            }
                        }.frame(height: 40)
                    }
                    
                    Section(header: Text("AVAILABLES COUPONS")) {
                        ForEach(Array(viewModel.couponList.enumerated()), id: \.offset) { index, element in
                            CouponRow(couponDetail: element, totalPrice: self.totalPrice)
                                .onTapGesture {
                                    self.viewModel.selectedCoupon = element
                                    self.viewModel.couponCode = element.code ?? ""
                                    ToastPresenter().show(toast: "Coupon copied.")
                                }.listRowSeparator(.hidden)
                        }
                    }
                }
            }.frame(height: geometry.size.height)
        }
        .overlay(
            ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .default())
                .frame(width: 50.0, height: 50.0)
                .foregroundColor(.themeColor)
        )
        .background(Color(UIColor.systemGray6)) // Light background color for the entire section
        .navigationBarTitle("COUPONS",displayMode: .inline)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

struct CouponRow: View {
    let couponDetail: CouponItem?
    let totalPrice: Double?
    
    var body: some View {
        HStack {
            // Left Side: Coupon Details
            VStack(alignment: .leading, spacing: 8) {
                Text("CODE: \(couponDetail?.code ?? "")")
                    .font(.system(size: 14,weight: .bold))
                    .foregroundColor(.black)
                
                // Discount percentage
                Text("\(couponDetail?.amount ?? "") % off")
                    .font(.system(size: 14,weight: .semibold))
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                // Description
                if ((couponDetail?.minimum_amount?.toDouble() ?? 0.0) > 0.0){
                    Text("on purchase of CAD \(couponDetail?.minimum_amount ?? "") or more")
                        .font(.system(size: 12,weight: .regular))
                        .foregroundColor(.gray)
                }
                
                // Validity date
//                if (couponDetail?.free_shipping ?? false){
//                    HStack{
//                        Image(systemName: "checkmark")
//                            .frame(width: 10,height: 10)
//                            .foregroundStyle(.green)
//                        
//                        Text("Free Shipping")
//                            .font(.footnote)
//                            .foregroundColor(.gray)
//                    }
//                }
            }
            
            Spacer()
            
            Text("Copy")
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(Color.pink.opacity(0.2))
                .cornerRadius(5)
                .foregroundColor(.pink)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

#Preview {
    CouponView(selectedCoupon: .constant(nil), totalPrice: 0.0)
}
