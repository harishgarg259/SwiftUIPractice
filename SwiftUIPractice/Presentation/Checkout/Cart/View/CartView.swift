import SwiftUI

struct CartView: View {
    
    @ObservedObject var viewModel: CartViewModel
    @State var presented: Bool = false
    @State var couponViewPresent: Bool = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    List {
                        Section(header: Text("SHIPPING ADDRESS")) {
                            VStack(alignment: .leading, spacing: 8) {
                                // First line with the name and postal code
                                HStack {
                                    Text("Deliver to:")
                                        .font(.subheadline)
                                        .foregroundColor(.black)
                                    
                                    Text(viewModel.customerInfo)
                                        .font(.subheadline)
                                        .foregroundColor(.black)
                                        .lineLimit(1)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        self.presented.toggle()
                                    }) {
                                        Text("Change")
                                            .foregroundColor(.theme)
                                            .fontWeight(.bold)
                                    }
                                    .navigationDestination(isPresented: $presented, destination:{
                                        AddressDetailView(headerTitle: "Shipping Address", addressDetail: viewModel.shippingAddressArray())
                                    })
                                }
                                
                                // Second line with the detailed address
                                Text(viewModel.address)
                                    .font(.caption)
                                    .lineLimit(2)
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        Section(header: Text("ITEMS")) {
                            ForEach(viewModel.cartArray, id: \.id) { element in
                                CartItemRowView(item: element, viewModel: viewModel)
                            }
                            .onDelete { indexSet in
                                indexSet.forEach { index in
                                    viewModel.removeItem(viewModel.cartArray[index])
                                }
                            }
                        }
                        
                        Section(header: Text("COUPONS")) {
                            HStack {
                                if let selectedCoupon = viewModel.couponItem, viewModel.subtotal < (selectedCoupon.minimum_amount?.toDouble() ?? 0.0){
                                    VStack{
                                        HStack{
                                            Image(systemName: "checkmark")
                                                .resizable()
                                                .frame(width: 16, height: 16)
                                                .foregroundColor(.green)
                                            Text("CODE: \(selectedCoupon.code ?? "")")
                                                .font(.system(size: 14, weight: .semibold))
                                                .foregroundColor(.green)
                                            
                                        }
                                        // Description
                                        if ((selectedCoupon.minimum_amount?.toDouble() ?? 0.0) > 0.0){
                                            Text("\(selectedCoupon.amount ?? "") % off on purchase of CAD \(selectedCoupon.minimum_amount ?? "") or more")
                                                .font(.system(size: 12,weight: .regular))
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        self.viewModel.couponItem = nil
                                    }) {
                                        Text("Remove")
                                            .padding(.vertical, 8)
                                            .padding(.horizontal, 16)
                                            .background(Color.pink.opacity(0.2))
                                            .cornerRadius(5)
                                            .foregroundColor(.pink)
                                    }
                                }else{
                                    Image(systemName: "tag")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.black)
                                    
                                    Text("Apply Coupon")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(.black)
                                    
                                    Spacer()
                                    Button(action: {
                                        self.couponViewPresent.toggle()
                                    }) {
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.black)
                                    }
                                    
                                }
                            }
                            .navigationDestination(isPresented: $couponViewPresent, destination:{
                                CouponView(selectedCoupon: $viewModel.couponItem, totalPrice: self.viewModel.subtotal)
                            })
                            .padding(0)
                            .background(Color.white)
                        }
                        
                        Section(header: Text("PRICE DETAILS")) {
                            VStack(alignment: .leading, spacing: 10) {
                                
                                HStack {
                                    Text("Subtotal:")
                                    Spacer()
                                    Text(String(format: "CAD %.2f", viewModel.subtotal))
                                }
                                
                                if let selectedCoupon = viewModel.couponItem, viewModel.subtotal < (selectedCoupon.minimum_amount?.toDouble() ?? 0.0){
                                    HStack {
                                        Text("Coupon Discount:")
                                        Spacer()
                                        Text(String(format: "CAD %.2f", viewModel.couponDiscount))
                                    }
                                }
                                
                                HStack {
                                    Text("Shipping:")
                                    Spacer()
                                    Text(String(format: "CAD %.2f", viewModel.shipping))
                                }
                                
                                HStack {
                                    Text("Total (\(viewModel.cartArray.count) items):")
                                        .fontWeight(.bold)
                                    Spacer()
                                    Text(String(format: "CAD %.2f", viewModel.total))
                                        .fontWeight(.bold)
                                }
                            }
                            .padding(.horizontal, 8)
                            
                            Button(action: {
                                // Action for continuing to checkout
                            }) {
                                Text("Continue")
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.black)
                                    .cornerRadius(8)
                            }
                            .padding(.horizontal, 8)
                            .padding(.bottom, 20)
                        }
                    }
                }.frame(height: geometry.size.height)
            }
        }
        .onAppear(perform: {
            self.viewModel.getCartDetail()
            self.viewModel.loadShippingAddress()
        })
        .navigationBarTitle("Order Detail",displayMode: .inline)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

struct CartItemRowView: View {
    var item: ProductCartItems
    var viewModel: CartViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                if let imageURL = item.product.images?.first?.src {
                    ImageView(url: imageURL)
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .clipped()
                        .background(.white)
                }else{
                    Image("pork-liver") // Replace with the actual image name
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipped()
                        .background(.green)
                }
                
                VStack(alignment: .leading) {
                    Text(item.product.name ?? "")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    if let size = item.product.variations?.weight, !size.isEmpty{
                        Text("Size: \(item.product.variations?.weight ?? "")")
                            .font(.subheadline)
                            .lineLimit(1)
                    }
                    
                    HStack {
                        Text("Price:")
                            .font(.headline)
                        if !(item.product.regular_price?.isEmpty ?? true){
                            Text("$\(item.product.regular_price ?? "")")
                                .font(.subheadline)
                                .strikethrough()
                        }
                        Text("$\(item.price)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    HStack {
                        HStack {
                            Button(action: {
                                viewModel.incrementQuantity(for: item)
                            }) {
                                Image(systemName: "plus.circle")
                                    .foregroundColor(.blue)
                            }.buttonStyle(PlainButtonStyle())
                            
                            Text("\(item.quantity)")
                                .padding(.horizontal, 5)
                            
                            Button(action: {
                                viewModel.decrementQuantity(for: item)
                            }) {
                                Image(systemName: "minus.circle")
                                    .foregroundColor(.blue)
                            }.buttonStyle(PlainButtonStyle())
                                .disabled(item.quantity < 2)
                        }
                        Spacer()
                        
                        RemoveButton(item: item, viewModel: viewModel)
                    }
                }
            }
        }
        
    }
}

struct RemoveButton: View {
    
    var item: ProductCartItems
    var viewModel: CartViewModel
    @State private var showAlert = false
    
    var body: some View {
        Button(action: {
            self.showAlert = true
        }) {
            HStack {
                Image(systemName: "trash")
                    .frame(width: 8, height: 12)
            }.padding(5)
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.small)
        .foregroundStyle(.theme)
        .tint(.clear)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Confirm Deletion"),
                  message: Text("Are you sure you want to delete this item?"),
                  primaryButton: .destructive(Text("Delete")) {
                self.viewModel.removeItem(item)
            },
                  secondaryButton: .cancel())
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(viewModel: CartViewModel())
    }
}
