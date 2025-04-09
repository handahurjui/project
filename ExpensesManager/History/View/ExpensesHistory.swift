//
//  ExpensesHistory.swift
//  ExpensesManager
//
//  Created by Anda on 09.04.2025.
//

import SwiftUI
import Combine

struct ExpensesHistory<ViewModel: ExpensesHistoryViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading:
                VStack {
                    Text("Loading...")
                        .font(.title)
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(2)
                        .padding()
                }
            case .idle:
                EmptyView()
            case .loaded(let response):
                List {
                    ForEach(response, id: \.id) { item in
                        ExpenseItemView(expense: item)
                  }
                }
            case .failed(let error):
                VStack {
                    Text("No entries retrieved \(error)")
                        .font(.title)
                }
            }
        }
        .onAppear {
            viewModel.loadExpenses()
        }
    }
}
