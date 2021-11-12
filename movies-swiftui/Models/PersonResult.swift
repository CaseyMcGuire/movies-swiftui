//
//  PersonResulkt.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 10/8/21.
//  Copyright © 2021 Casey McGuire. All rights reserved.
//

import Foundation

struct PersonResult : Decodable {
  var name: String?
  var biography: String?
  var profilePath: String?
  var knownForDepartment: String?
  var deathDay: String?
  var placeOfBirth: String?
  var birthday: String?
  var movieCredits: [String: [MovieResult]]?
}
