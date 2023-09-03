//
//  TestViewViewModel.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/3/23.
//

import Foundation

class TestViewViewModel: ObservableObject{
    @Published var testVar:String
    var testBool:Bool=false
    var testMsg:String=""
    
    init(_ param:String = "default"){
        testVar=param
    }
    func testFunc(param:String){
        testBool = testVar != param
        let temp=testVar
        testVar=param
        testMsg="changed from '\(temp)' to '\(testVar)'"
    }
}
