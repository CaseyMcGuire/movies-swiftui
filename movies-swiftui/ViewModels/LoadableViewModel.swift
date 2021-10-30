//
//  LoadableViewModel.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 10/23/21.
//  Copyright © 2021 Casey McGuire. All rights reserved.
//

import Foundation

class LoadableViewModel<T>: ObservableObject {
  @Published var state: LoadingState<T> = .loading
  
  func load() {}
}

enum LoadingState<Value> {
  case loading
  case loaded(Value)
  case error
}
