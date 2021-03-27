//
//  MovieResult.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 4/3/20.
//  Copyright © 2020 Casey McGuire. All rights reserved.
//

import Foundation

struct MovieResultList: Decodable {
  let page: Int
  let results: [MovieResult]
}

struct MovieResult: Decodable {
  let backdropPath: String?
  let id: Int
  let posterPath: String?
  let overview: String
  let title: String
  let adult: Bool
  let budget: Int?
  let genres: [Genre]?
  let homePage: String?
  let imdbId: String?
  let originalLanguage: String?
  let originalTitle: String?
  let popularity: Double?
  let status: String?
  let tagline: String?
  let video: Bool?
  let voteAverage: Double?
  let voteCount: Int?
  let releaseDate: String?
  let credits: CreditResult?
  let similar: MovieResultList?
}
