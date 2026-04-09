//
//  SearchScreenViewModel.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 4/5/26.
//  Copyright © 2026 Casey McGuire. All rights reserved.
//

import Foundation

@MainActor
final class SearchScreenViewModel: LoadableViewModel<MovieResultList> {
  
  private let searchService = SearchService()
  
  // type-safe since we're always on the main thread
  private var lastQuery: String?
  
  func load(searchText: String) async {
    if searchText == lastQuery, case .loaded = state {
        return
    }
    state = .loading
    lastQuery = searchText
    do {
      let result = try await searchService.searchMovies(query: searchText)
      state = .loaded(result)
    } catch is CancellationError {
      // ignore
    } catch let urlError as URLError where urlError.code == .cancelled {
      // ignore
    } catch {
      state = .error
    }
  }
}
