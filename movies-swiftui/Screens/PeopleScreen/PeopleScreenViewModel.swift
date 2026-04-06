//
//  PeopleScreenViewModel.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 10/8/21.
//  Copyright © 2021 Casey McGuire. All rights reserved.
//

import Foundation

@MainActor
final class PeopleScreenViewModel: LoadableViewModel<PeopleDetails> {

  private let movieService = MovieService()
  
  func load(peopleId: Int) async {
    state = .loading
    do {
      let result = try await movieService.fetchPerson(id: peopleId)
      state = .loaded(parse(result))
    } catch {
      state = .error
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
  
  var knownForDepartment: String? {
    get {
      result.knownForDepartment
    }
  }
  
  var birthday: String? {
    get {
      result.birthday
    }
  }
  
  var deathDate: String? {
    get {
      result.deathDay
    }
  }
  
  var movieCredits: [MovieResult] {
    get {
      result.movieCredits?["cast"] ?? []
    }
  }
}
