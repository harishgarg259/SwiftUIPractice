import SwiftUI

struct CartView: View {
    @ObservedObject var viewModel: CartViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(viewModel.cartArray, id: \.id) { element in
                        CartItemRowView(item: element, viewModel: viewModel)
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            viewModel.removeItem(viewModel.cartArray[index])
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Subtotal")
                        Spacer()
                        Text(String(format: "USD %.2f", viewModel.subtotal))
                    }
                    
                    HStack {
                        Text("Shipping")
                        Spacer()
                        Text("Free")
                    }
                    
                    HStack {
                        Text("Total (\(viewModel.cartArray.count) items)")
                            .fontWeight(.bold)
                        Spacer()
                        Text(String(format: "USD %.2f", viewModel.total))
                            .fontWeight(.bold)
                    }
                }
                .padding(.horizontal, 16)
                
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
                .padding(.horizontal, 16)
                .padding(.bottom, 20)
            }
        }
        .onAppear(perform: {
            self.viewModel.getCartDetail()
        })
        .navigationBarTitle("Order Detail",displayMode: .inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .tint(.themeColor)
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
                    
                    Text("Price: \(item.price)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
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
    
    var body: some View {
        Button(action: {
            // Action for the remove button
            print("Remove button tapped")
        }) {
            HStack {
                Image(systemName: "trash")
                    .frame(width: 8, height: 12)
                Text("REMOVE")
                    .font(.system(size: 10, weight: .medium))
            }
            .foregroundColor(Color(.sRGB, red: 172/255, green: 117/255, blue: 103/255, opacity: 1)) // Matching color
            .padding(8)
            .frame(maxWidth: 80)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(.sRGB, red: 172/255, green: 117/255, blue: 103/255, opacity: 1), lineWidth: 1)
            )
        }
        .background(Color.clear)
        .cornerRadius(8)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(viewModel: CartViewModel())
    }
}
