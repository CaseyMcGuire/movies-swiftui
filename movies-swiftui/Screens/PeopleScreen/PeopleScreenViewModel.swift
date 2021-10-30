//
//  PeopleScreenViewModel.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 10/8/21.
//  Copyright © 2021 Casey McGuire. All rights reserved.
//

import Foundation

class PeopleScreenViewModel: LoadableViewModel<PeopleDetails> {

  private let movieService = MovieService()
  
  func load(peopleId: Int) {
    movieService.fetchPerson(id: peopleId).then { result in
      self.state = .loaded(self.parse(result))
    }
    .catch { err in
      self.state = .error
    }
  }
  
  private func parse(_ result: PersonResult) -> PeopleDetails {
    return PeopleDetails(result: result)
  }
}


struct PeopleDetails {
  let result: PersonResult
  
  var name: String {
    get {
      result.name ?? ""
    }
  }
  
  var biography: String? {
    get {
      result.biography
    }
  }
  
  var profilePath: String? {
    get {
      result.profilePath
    }
  }
}
