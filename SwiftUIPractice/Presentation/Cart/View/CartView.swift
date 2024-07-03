//
//  CartItem.swift
//  Yappetizer
//
//  Created by Harish Garg on 22/01/24.
//

import SwiftUI

struct CartView: View {
    
    @ObservedObject var cartProducts: CartViewModel
    
    init(cartProducts: CartViewModel){
        self.cartProducts = cartProducts
    }
    
    var body: some View {
        ScrollView{
            VStack {
                if cartProducts.cartProduct.isEmpty {
                    CartLoadingView()
                } else {
                    HeaderView()
                    ForEach(Array(cartProducts.cartProduct.enumerated()), id: \.offset) { section, element in
                        CartItemView(item: element)
                            .environmentObject(cartProducts)
                    }
                    TotalPriceView(total: 1073)
                        .padding(.bottom, 10)
                }
            }
        }
        .onAppear(perform: {
        })
        .navigationBarTitle("Cart",displayMode: .inline)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

struct HeaderView: View {
    
    @EnvironmentObject var userState: UserStateViewModel
    @State var headingText: String = ""
    @State var subHeadingText: String = ""
    @State var presented: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Deliver to:")
                Text(headingText)
                    .fontWeight(.bold)
                Spacer()
                Button {
                    self.presented = true
                } label: {
                    Text("Change")
                        .frame(maxWidth: 60)
                        .fontWeight(.regular)
                }
                .foregroundColor(.gray)
                .buttonStyle(.borderedProminent)
                .tint(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .navigationDestination(isPresented: $presented, destination:{
                    AddressDetailView(headerTitle: "Shipping Address", addressDetail: shippingAddressArray())
                })
            }
            Text(subHeadingText)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        Divider()
            .onAppear(perform: {
                let customerProfile = userState.customerProfile()
                self.loadAddressDetails(address: customerProfile?.shipping)
            })
    }
    
    func loadAddressDetails(address: AddressDetail?){
        
        headingText.removeAll()
        subHeadingText.removeAll()
        
        if let first_name = address?.first_name, first_name.count > 0
        {
            headingText.append(first_name.capitalized)
        }
        if let last_name = address?.last_name, last_name.count > 0
        {
            headingText.append(" \(last_name.capitalized)")
        }
        if let postcode = address?.postcode, postcode.count > 0
        {
            headingText.append(", \(postcode)")
        }
        if let address_1 = address?.address_1, address_1.count > 0
        {
            subHeadingText.append(address_1)
        }
        if let address_2 = address?.address_2, address_2.count > 0
        {
            subHeadingText.append(", \(address_2)")
        }
        if let city = address?.city, city.count > 0
        {
            subHeadingText.append(", \(city)")
        }
        if let state = address?.state, state.count > 0
        {
            subHeadingText.append(", \(state)")
        }
        if let postcode = address?.postcode, postcode.count > 0
        {
            subHeadingText.append(" (\(postcode))")
        }
        if let country = address?.country, country.count > 0
        {
            subHeadingText.append(", \(country)")
        }
    }
    
    func shippingAddressArray() -> AddressGroup? {
        
        let customerProfile = userState.customerProfile()
        if let shippingAddress = customerProfile?.shipping {
            return AddressGroup(addressType: "Shipping Address", address: [
                CustomerAddresses(addressDetail: shippingAddress)
            ], expandMe: true)
        }else{
            return AddressGroup(addressType: "Shipping Address", address: [
                CustomerAddresses(addressDetail: nil)
            ], expandMe: true)
        }
    }
}

struct CartItemView: View {
    let item: ProductListModel
    @State private var quantity = 1
    @EnvironmentObject var viewModel: CartViewModel
    @State var showAlert: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                
                VStack(alignment: .center){
                    // Product image (assuming you have the image in your assets)
                    if let imageURL = item.images?[0].src {
                        ImageView(url: imageURL)
                            .scaledToFit()
                            .frame(width: 80, height: 100, alignment: .center)
                            .clipped()
                            .background(.white)
                    }else{
                        Image("pork-liver") // Replace with the actual image name
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 100, alignment: .center)
                            .clipped()
                            .background(.green)
                    }
                    
                    // Quantity Stepper
                    Text("Quantity: \(quantity)")
                        .font(.headline)
                    Stepper(value: $quantity, in: 1...(item.stock_quantity ?? 20)) {
                        //viewModel.changeQuantity(product: item, quantity: quantity)
                    }
                }
                .frame(width: 130)
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text(item.name ?? "")
                        .font(.system(size: 15,weight: .semibold))
                    Text("$\(item.price ?? "$9.99")")
                        .font(.headline)
                        .foregroundColor(.green)
                    Spacer()
                    HStack{
                        Spacer()
                        Button {
                            self.showAlert = true
                        } label: {
                            Text("Remove")
                                .frame(maxWidth: 70)
                                .fontWeight(.regular)
                        }
                        .foregroundColor(.gray)
                        .buttonStyle(.borderedProminent)
                        .tint(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Are you sure you want to delete this item?"),
//                                message: Text("There is no undo"),
                                primaryButton: .destructive(Text("Delete")) {
                                    viewModel.removeFromCart(toRemove: item)
                                },
                                secondaryButton: .cancel()
                            )
                        }
                    }
                }
            }
            Divider()
        }
        .padding(10)
    }
}

struct TotalPriceView: View {
    let total: Double
    @State var presented: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Total:")
                    .font(.headline)
                Spacer()
                Text("₹\(String(format: "%.2f", total))")
                    .font(.headline)
            }
            .padding(.horizontal)
            
            Button(action: {
                self.presented = true
            }, label: {
                Text("Proceed")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .cornerRadius(10)
            })
            .padding(.top,30)
            .buttonStyle(.borderedProminent)
            .shadow(color: .themeColor,radius: 2)
            .padding(.horizontal)
            .navigationDestination(isPresented: $presented, destination:{
                CheckoutView(viewModel: SubscriptionViewModel())
            })
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(cartProducts: CartViewModel())
    }
}

struct CartLoadingView: View {
    var body: some View {
        VStack(alignment: .center) {
            GifImageView("shopping-cart")
                .frame(width: 50, height: 50, alignment: .center)
            Text("Your cart is empty").font(.headline)
        }
    }
}

