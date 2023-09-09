//
//  Transaction.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/9/23.
//

import Foundation

class Transaction {
    var item:String
    var cost:Float
    var type:String
    
    init(item:String,cost:Float,type:String){
        self.item=item
        self.cost=cost
        self.type=type
    }
}
