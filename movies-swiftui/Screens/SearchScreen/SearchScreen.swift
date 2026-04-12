//
//  SearchScreen.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 4/5/26.
//  Copyright © 2026 Casey McGuire. All rights reserved.
//

import SwiftUI

struct SearchScreen : View {
  
  @State private var viewModel = SearchScreenViewModel()
  @State private var searchText = ""
  
  var body: some View {
    NavigationStack {
      Group {
        switch viewModel.loadingState {
        case .none:
          ContentUnavailableView("Search", systemImage: "magnifyingglass")
        case .loading(_, _):
          ProgressView()
        case .loaded(_, let result):
          List(result, id: \.id) { result in
            NavigationLink {
              MovieScreen(movieId: result.id)
            } label: {
              Text(result.title)
            }
          }
        case .error:
          Text("Error")
        }
      }.searchable(text: $searchText)
       .onChange(of: searchText) { _, newValue in
         viewModel.query(newValue)
       }
    }
  }
}
