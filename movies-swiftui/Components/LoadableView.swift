//
//  LoadableView.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 10/24/21.
//  Copyright © 2021 Casey McGuire. All rights reserved.
//

import SwiftUI

struct LoadableView<T, Content: View>: View {

  var viewModel: LoadableViewModel<T>
  var content: (T) -> Content
  
  var body: some View {
    switch self.viewModel.state {
    case .loading:
      ProgressView()
    case .loaded(let data):
      content(data)
    case .error:
      Text("Error")
    }
  }
}
