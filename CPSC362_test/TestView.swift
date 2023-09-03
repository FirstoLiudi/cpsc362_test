//
//  TestView.swift
//  CPSC362_test
//
//  Created by Liudi, Firsto on 9/3/23.
//

import SwiftUI

struct TestView: View {
    @StateObject var viewModel=TestViewViewModel()
    var body: some View {
        Form{
            if viewModel.testBool{
                Text(viewModel.testMsg)
                    .foregroundColor(.red)
            }
            TextField("text?",text: $viewModel.testVar)
            Text(viewModel.testVar)
                .foregroundColor(.green)
            Button("xyz"){
                viewModel.testFunc(param: "xyz")
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
