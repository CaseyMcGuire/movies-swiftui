//
//  PersonResult.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 3/5/21.
//  Copyright © 2021 Casey McGuire. All rights reserved.
//

struct CreditResult: Decodable {
  let cast: [CastCreditResult]?
  let crew: [CrewCreditResult]?
}

struct CastCreditResult: Decodable {
  let adult: Bool?
  let gender: Int?
  let id: Int?
  let knownForDepartment: String?
  let name: String?
  let originalName: String?
  let popularity: Double?
  let profilePath: String?
  let castId: Int?
  let character: String?
  let creditId: String?
  let order: Int?
}

struct CrewCreditResult: Decodable {
  let adult: Bool?
  let gender: Int?
  let id: Int?
  let knownForDepartment: String?
  let name: String?
  let originalName: String?
  let popularity: Double?
  let profilePath: String?
  let department: String?
  let job: String?
}
