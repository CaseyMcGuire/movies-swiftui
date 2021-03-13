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
  var circle = false

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
        if self.circle {
          Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: width)
            .clipShape(Circle())
        }
        else {
          Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
        }
      } else {
        if self.circle {
          Circle()
            .fill(Color.gray)
            .frame(width: width, height: width)
        }
        else {
          Rectangle()
            .fill(Color.gray)
            .frame(width: width, height: height)
        }
      }
    } else {
      if self.circle {
        Circle()
          .fill(Color.gray)
          .frame(width: width, height: width)
      }
      else {
        Rectangle()
          .fill(Color.gray)
          .frame(width: width, height: height)
      }
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
    MoviePoster(backdropPath: "/6KErczPBROQty7QoIsaa6wJYXZi.jpg")
  }
}
