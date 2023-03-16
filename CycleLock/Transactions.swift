//
//  Transactions.swift
//  CycleLock
//
//  Created by Luke Drushell on 3/14/23.
//

import SwiftUI

struct Transactions: View {
    
    @Binding var transactions: [Transaction]
    @Binding var showMap: Bool
    @Binding var selectedTransaction: Transaction?
    
    
    var body: some View {
        VStack() {
            HStack {
                Text("Transactions")
                    .font(.system(.title, design: .rounded, weight: .bold))
                    .shadow(color: .black.opacity(0.15), radius: 4.5)
                Spacer()
            } .padding(.leading)
            ForEach(transactions.indices) { index in
                TransactionCard(transaction: transactions[index], showMap: $showMap, selectedTransaction: $selectedTransaction)
                    .animation(.spring(), value: showMap)
            }
        }
    }
}

struct Transactions_Previews: PreviewProvider {
    static var previews: some View {
        Transactions(transactions: .constant([]), showMap: .constant(false), selectedTransaction: .constant(Transaction(amount: 0, date: Date(), longitude: 0, latitutde: 0, cardNum: 0)))
    }
}
