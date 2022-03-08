//
//  SearchResultErrorView.swift
//  CoolFinderiOS
//
//  Created by Luis Zapata on 08-03-22.
//

import SwiftUI

protocol SearchResultErrorViewUpdater {
    func updateErrorMessage(_ message: String)
}

struct SearchResultErrorView: View, SearchResultErrorViewUpdater {
    @ObservedObject var viewModel: SearchResultErrorViewModel = SearchResultErrorViewModel()

    public var body: some View {
        VStack {
            Text(viewModel.errorMessage)
        }
    }
    
    func updateErrorMessage(_ message: String) {
        viewModel.errorMessage = message
    }
    
    class SearchResultErrorViewModel: ObservableObject {
        @Published var errorMessage: String = ""
    }
}
