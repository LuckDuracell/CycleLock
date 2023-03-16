//
//  TransactionCard.swift
//  CycleLock
//
//  Created by Luke Drushell on 3/14/23.
//

import SwiftUI

struct TransactionCard: View {
    
    let transaction: Transaction
    @Binding var showMap: Bool
    @Binding var selectedTransaction: Transaction?
    
    @State var offsetTransaction = false
    @State var initialOffset: CGFloat = 0
    
    var body: some View {
        HStack {
            Text(transaction.amount, format: .currency(code: "USD"))
                .bold()
            Spacer()
                Text(transaction.date, format: .dateTime)
        } .padding()
            .background(.regularMaterial)
            .cornerRadius(15)
            .padding(.horizontal)
            .onTapGesture {
                withAnimation {
                    initialOffset = -18
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                        withAnimation {
                            offsetTransaction.toggle()
                        }
                    })
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
                    selectedTransaction = transaction
                    initialOffset = 0
                })
            }
            .offset(x: offsetTransaction ? screen().width : initialOffset)
            .onChange(of: selectedTransaction, perform: { selection in
                if selection?.amount == -5 {
                    withAnimation(.spring()) {
                        offsetTransaction = false
                    }
                }
            })
    }
}

struct TransactionCard_Previews: PreviewProvider {
    static var previews: some View {
        TransactionCard(transaction: Transaction(amount: 1.55, date: Date(), longitude: -121.7476, latitutde: 38.5489, cardNum: 4128), showMap: .constant(false), selectedTransaction: .constant(Transaction(amount: 0, date: Date(), longitude: 0, latitutde: 0, cardNum: 0)))
    }
}

struct Transaction: Identifiable, Hashable {
    let id = UUID()
    let amount: Double
    let date: Date
    let longitude: Double
    let latitutde: Double
    let cardNum: Int
    // ^^ last 4 digits of the card number
}
