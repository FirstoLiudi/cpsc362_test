//
//  TransactionsView.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/2/23.
//

import SwiftUI

struct TransactionsView: View {
    var body: some View {
        NavigationView(){
            VStack{
                Text("list of transactions")
            }
            .toolbar{
                NavigationLink( destination: AddTransactionView()){
                    Text("add transaction")
                }
                
            }
        }
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView()
    }
}
