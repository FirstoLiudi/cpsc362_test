//
//  BudgetView.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/2/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct BudgetView: View {
    @StateObject private var viewModel:BudgetViewViewModel=BudgetViewViewModel()
    var budget:[String:Double]=Dictionary(uniqueKeysWithValues: types.map{($0,0)})
    
    var body: some View {
        NavigationView {
            List(types,id: \.description){ type in
                Section(type) {
                    Text(String(format: "spent: $%.2f", viewModel.sum[type]!))
                    Text(String(format: "budget: $%.2f", viewModel.budget[type]!))
                }
            }
            .refreshable(action: {
                viewModel.getSum()
                viewModel.getBudget()
            })
            .navigationTitle("Budget")
            .toolbar{
                NavigationLink( destination: SetBudgetView(budget: viewModel.budget)){
                    Text("Set budget")
                }
            }
        }
    }
}

struct BudgetView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            //SetBudgetView(budget: [
            //    "Food":0,
            //    "Entertainment":0,
            //    "Education":0,
            //    "Transportation":0,
            //    "Others":0
            //])
            BudgetView()
        }
    }
}
