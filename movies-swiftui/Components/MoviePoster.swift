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
  
  private let defaultWidth: CGFloat = 100
  private let defaultHeight: CGFloat = 150
  
  var body: some View {
    
    if let backdropPath = self.backdropPath {
      if let image = TMDBImageUtil.createImage(imagePath: backdropPath, imageSize: .W300) {
        Image(uiImage: image)
          .resizable()
          .frame(width: self.defaultWidth, height: self.defaultHeight)
      } else {
        Rectangle()
          .fill(Color.gray)
          .frame(width: self.defaultWidth, height: self.defaultHeight)
      }
    } else {
      Rectangle()
        .fill(Color.gray)
        .frame(width: self.defaultWidth, height: self.defaultHeight)
    }
    
  }
}

struct MoviePoster_Previews: PreviewProvider {
  static var previews: some View {
    MoviePoster(backdropPath: "lasdkfj")
  }
}
