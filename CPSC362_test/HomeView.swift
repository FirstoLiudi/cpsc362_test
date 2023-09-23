//
//  ContentView.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/2/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class DataViewModel: ObservableObject{
    @Published var transactions:[Transaction]=[]
    @Published var categories:[String:Float]=[
        "Food":0,
        "Entertainment":0,
        "Education":0,
        "Transportation":0,
        "Others":0
    ]
    @Published var total=0
    
    init(){
        getData()
    }
    
    func getData(){
        self.transactions.removeAll()
        for type in categories.keys { categories[type]=0 }
        guard let uid=Auth.auth().currentUser?.uid else {
            print("no one is logged in???")
            return
        }
        let db=Firestore.firestore()
        let query=db
            .collection("transactions")
            .whereField("uid", isEqualTo: uid)
            .order(by: "datetime",descending: true)
        query.getDocuments() { (querySnapshot, error) in
            if let error=error {
                print("Error getDocuments: \(error)")
            }
            else {
                for doc in querySnapshot!.documents {
                    do {
                        let transaction=try doc.data(as: Transaction.self)
                        //print("xxx \(doc.data())")
                        self.transactions.append(transaction)
                    } catch {
                        print(error)
                    }
                }
                for transaction in self.transactions {
                    if self.categories.keys.contains(transaction.type) {
                        self.categories[transaction.type]!+=transaction.cost
                    }
                    else {
                        self.categories["Others"]!+=transaction.cost
                    }
                }
                print("getDocument success")
            }
        }
    }
}

struct HomeView: View {
    @StateObject var data=DataViewModel()
    var body: some View {
        TabView {
            BudgetView(data: data)
                .tabItem {
                    Label("Budget", systemImage: "dollarsign.circle.fill")
                }
            TransactionsView()
                .tabItem {
                    Label("Transactions", systemImage: "book")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
