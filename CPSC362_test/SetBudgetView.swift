//
//  SetBudgetView.swift
//  CPSC362_test
//
//  Created by csuftitan on 10/7/23.
//
import FirebaseFirestore
import FirebaseAuth
import SwiftUI

func setBudget(newBudget:[String:Double]){
    guard let uid=Auth.auth().currentUser?.uid else {
        print("error getting uid")
        return;
    }

    let query=Firestore.firestore().collection("users")
        .whereField("uid", isEqualTo: uid)
    query.getDocuments { querySnapshot, error in
        if let error=error {
            print(error.localizedDescription)
        }
        else {
            print(querySnapshot!.documents.count)
            
            for doc in querySnapshot!.documents{
                doc.reference.updateData(["budget":newBudget]) { error in
                    if let error = error {
                        print("Error updating document: \(error)")
                    } else {
                        print("Document successfully updated")
                    }
                }
            }
        }
    }
}

struct SetBudgetView: View {
    @State var budget: [String: Double]
    

    var body: some View {
        Form {
            ForEach(types, id: \.self) { type in
                Section(header: Text(type)) {
                    TextField("Enter budget for \(type)", value: Binding(
                        get: { budget[type] ?? 0 },
                        set: { newValue in
                            budget[type] = Double(newValue)
                        }
                    ), formatter: {
                        let formatter = NumberFormatter()
                        formatter.numberStyle = .decimal
                        formatter.minimumFractionDigits = 2
                        return formatter
                    } ())
                    .keyboardType(.decimalPad)
                }
            }
            Button("Set budget") {
                setBudget(newBudget: budget)
            }
        }
        .navigationTitle("Set Budget")
    }
}

struct SetBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        SetBudgetView(budget:Dictionary(uniqueKeysWithValues: types.map{($0,0)}))
    }
}
