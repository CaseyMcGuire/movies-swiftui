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
}
