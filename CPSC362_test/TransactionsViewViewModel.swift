//
//  TransactionsViewViewModel.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/9/23.
//
import FirebaseAuth
import FirebaseFirestore
import Foundation

class TransactionsViewViewModel: ObservableObject {
    @Published var transactions:[Transaction]=[]
    var transactionsDict:[[String:Any]]=[]
    
    init(){
        //print("initialized")
        guard let uid=Auth.auth().currentUser?.uid else {
            print("You are not logged in")
            return
        }
        print("proceed as \(uid)")
        let db=Firestore.firestore()
        let colRef=db.collection("transactions")
        
        colRef.whereField("uid", isEqualTo: uid)
            .getDocuments() { (querySnapshot, err) in
                if let err=err {
                    print("error getting docs: \(err)")
                } else {
                    //print("processing data of \(uid)")
                    for doc in querySnapshot!.documents {
                        let data=doc.data()
                        //let transaction=Transaction(item: data["item"], cost: data["cost"], type: data["type"])
                        self.transactionsDict.append(data)
                        //print("\(doc.documentID) => \(String(describing: item))")
                    }
                }
            }
        //print("end Init")
        for transaction in transactionsDict{
            transactions.append(Transaction(item: transaction["item"] as! String, cost: transaction["cost"] as! Float, type: transaction["type"] as! String))
        }
    }
}
