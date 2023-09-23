//
//  TransactionsView.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/2/23.
//

import SwiftUI
import Charts

struct TransactionsView: View {
    @StateObject var viewModel:TransactionsViewViewModel=TransactionsViewViewModel()
    @State private var type:String="All"
    @State private var dateFrom=Date(timeIntervalSince1970: 0)
    @State private var dateTo=Date()
    @State private var graphType:String="Category"
    
    init(){
        self.dateFrom=viewModel.transactions.last?.datetime ?? Date()
        self.dateTo=viewModel.transactions.first?.datetime ?? Date()
    }
    
    var body: some View {
        NavigationView(){
            VStack{
                List {
                    Picker("Graph", selection: $graphType) {
                        Text("Category").tag("Category")
                        Text("Month").tag("Month")
                    }
                    .pickerStyle(.segmented)
                    
                    if graphType=="Category" {
                        Chart(viewModel.transactions){
                            BarMark(
                                x: .value("Type", $0.type),
                                y: .value("cost", $0.cost)
                            )
                        }
                        .padding()
                        .aspectRatio(2, contentMode: .fit)
                    }

                    if graphType=="Month" {
                        Chart(viewModel.transactions){
                            let dateComponent=Calendar.current.dateComponents([.month,.year], from: $0.datetime)
                            let calendar = Calendar(identifier: .gregorian)
                            let date=calendar.date(from: dateComponent)
                            BarMark(
                                x: .value("Date", date!),
                                y: .value("cost", $0.cost)
                            )
                        }
                        .padding()
                        .aspectRatio(2, contentMode: .fit)
                    }
                        
                    Section("Filter"){
                        Picker("Category", selection: $type) {
                            Text("All").tag("All")
                            ForEach(types,id: \.description){
                                Text($0).tag($0)
                            }
                        }
                        DatePicker("From",selection: $dateFrom)
                        DatePicker("To",selection: $dateTo)
                    }
                    
                    Section("Transactions"){
                        ForEach(viewModel.transactions){
                            if(dateFrom<=$0.datetime && $0.datetime<=dateTo){
                                if(type=="All") {
                                    TransactionItemView(transaction: $0)
                                } else {
                                    if($0.type==type) {
                                        TransactionItemView(transaction: $0)
                                    }
                                }
                            }
                        }
                    }
                }
                .refreshable {
                    viewModel.getTransactions()
                }
            }
            .navigationTitle("Transactions")
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
