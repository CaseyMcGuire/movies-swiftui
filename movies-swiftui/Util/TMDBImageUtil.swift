//
//  TMDBImageUtil.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 4/3/20.
//  Copyright © 2020 Casey McGuire. All rights reserved.
//

import Foundation
import UIKit

class TMDBImageUtil {
  
  private static let baseURL = "https://image.tmdb.org/t/p/"
  
  public static func createImage(imagePath: String, imageSize: ImageSize) -> UIImage? {
    guard let url = URL(string: TMDBImageUtil.baseURL + imageSize.rawValue + imagePath) else {
      return nil
    }
    
    guard let imageData = try? Data(contentsOf: url) else {
      return nil
    }
    return UIImage(data: imageData)
  }
}

enum ImageSize: String {
  case
    W45 = "w45",
    W92 = "w92",
    W154 = "w154",
    W185 = "w185",
    W300 = "w300",
    W342 = "w342",
    W500 = "w500",
    H632 = "h632",
    W780 = "w780",
    W1280 = "w1280",
    ORIGINAL = "original"
}
