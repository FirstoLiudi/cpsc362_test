//
//  TransactionsViewViewModel.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/9/23.
//
import FirebaseFirestore
import Foundation

class TransactionsViewViewModel: ObservableObject {
    @Published var transactions:[Transaction]=[]
    var collection=Firestore.firestore().collection("transactions")
    init(){
        collection.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let transaction = Transaction(item: data.item, cost: data.cost, type: data.type)
                    // Use the data from the document
                    print("Document data: \(data)")
                }
            }
        }
    }
}
