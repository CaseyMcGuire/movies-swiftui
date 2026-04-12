//
//  SearchScreenViewModel.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 4/5/26.
//  Copyright © 2026 Casey McGuire. All rights reserved.
//

import Foundation

@MainActor
@Observable
final class SearchScreenViewModel {
  
  private let searchService = SearchService()
  var loadingState: SearchLoadingState = .none
  var requestId = UUID()
  
  func query(_ queryText: String) {
    let modifiedQueryText = queryText.trimmingCharacters(in: .whitespacesAndNewlines)
    
    switch loadingState {
    case .none, .error:
      loadingState = createLoadingState(modifiedQueryText)
    case .loading(let searchText, let task):
      guard searchText != modifiedQueryText else { return }
      task.cancel()
      loadingState = createLoadingState(modifiedQueryText)
    case .loaded(let searchText, _):
      guard searchText != modifiedQueryText else { return }
      loadingState = createLoadingState(modifiedQueryText)
    }
  }
  
  private func createLoadingState(_ queryText: String) -> SearchLoadingState {
    requestId = UUID()
    let pendingRequestId = requestId
    if queryText.isEmpty {
      return .none
    }
    return .loading(
      searchText: queryText,
      task: Task {
        do {
          try await Task.sleep(for: .milliseconds(300))
          let results = try await searchService.searchMovies(query: queryText)
          guard pendingRequestId == requestId else { return }
          loadingState = .loaded(searchText: queryText, result: results.results)
        } catch is CancellationError {}
          catch let error as URLError where error.code == .cancelled {}
          catch {
            guard pendingRequestId == requestId else { return }
            loadingState = .error
          }
      })
  }
}

enum SearchLoadingState {
  case none
  case loading(searchText: String, task: Task<Void, Never>)
  case loaded(searchText: String, result: [MovieResult])
  case error
}
