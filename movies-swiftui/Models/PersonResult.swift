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
}
