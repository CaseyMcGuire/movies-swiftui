//
//  MoviePoster.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 2/16/21.
//  Copyright © 2021 Casey McGuire. All rights reserved.
//

import SwiftUI

struct MoviePoster: View {
  
  let backdropPath: String?
  var size: MoviePosterSize = .medium
  
  private let defaultWidth: CGFloat = 100
  private let defaultHeight: CGFloat = 150
  
  private let smallWidth: CGFloat = 50
  private let mediumWidth: CGFloat = 100
  private let largeWidth: CGFloat = 150
  
  
  private func getWidth() -> CGFloat {
    switch self.size {
    case .small:
      return self.smallWidth
    case .medium:
      return self.mediumWidth
    case .large:
      return self.largeWidth
    }
  }
  
  var body: some View {
    let width = self.getWidth()
    let height = width * (3/2)
    if let backdropPath = self.backdropPath {
      if let image = TMDBImageUtil.createImage(imagePath: backdropPath, imageSize: .W300) {
        Image(uiImage: image)
          .resizable()
          .frame(width: width, height: height)
      } else {
        Rectangle()
          .fill(Color.gray)
          .frame(width: width, height: height)
      }
    } else {
      Rectangle()
        .fill(Color.gray)
        .frame(width: width, height: height)
    }
    
  }
}

enum MoviePosterSize {
  case small
  case medium
  case large
}

struct MoviePoster_Previews: PreviewProvider {
  static var previews: some View {
    MoviePoster(backdropPath: "lasdkfj")
  }
}
