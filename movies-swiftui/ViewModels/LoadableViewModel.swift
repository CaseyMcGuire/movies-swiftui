//
//  LoadableViewModel.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 10/23/21.
//  Copyright © 2021 Casey McGuire. All rights reserved.
//

import Foundation
import Observation

// A base view model for screens that load async data. Subclass with your data type,
// then set `state` to `.loaded(data)` or `.error` when your async work completes.
// Pair with `LoadableView` to automatically show a loading spinner, error state,
// or your content.
//
// Example:
//
//   class MyViewModel: LoadableViewModel<MyData> {
//     func load() async {
//       do {
//         let result = try await fetchData()
//         self.state = .loaded(result)
//       } catch {
//         self.state = .error
//       }
//     }
//   }
//
//   struct MyScreen: View {
//     @State private var viewModel = MyViewModel()
//     var body: some View {
//       LoadableView(viewModel: viewModel) { data in
//         Text(data.title)
//       }
//       .task { await viewModel.load() }
//     }
//   }
@Observable
class LoadableViewModel<T> {
  var state: LoadingState<T> = .loading
}

enum LoadingState<Value> {
  case loading
  case loaded(Value)
  case error
}
