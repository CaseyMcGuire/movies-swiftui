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
        if !searchText.isEmpty {
          LoadableView(viewModel: viewModel) { data in
            List(data.results, id: \.id) { result in
              NavigationLink {
                MovieScreen(movieId: result.id)
              } label: {
                Text(result.title)
              }
            }
          }.task(id: searchText) {
            try? await Task.sleep(for: .milliseconds(300))
            guard !Task.isCancelled else { return }
            await viewModel.load(searchText: searchText)
          }
        }
        else {
          ContentUnavailableView {
            Text("Please search")
          }
        }
      }.searchable(text: $searchText)
    }
  }
}
