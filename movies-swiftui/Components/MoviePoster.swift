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
  
    var body: some View {
      
      if let backdropPath = self.backdropPath {
        if let image = TMDBImageUtil.createImage(imagePath: backdropPath, imageSize: .W300) {
          Image(uiImage: image)
            .resizable()
            .frame(width: 100, height: 150)
        } else {
          Rectangle()
           .fill(Color.gray)
           .frame(width: 100, height: 150)
        }
      } else {
        Rectangle()
         .fill(Color.gray)
         .frame(width: 100, height: 150)
      }

    }
}

struct MoviePoster_Previews: PreviewProvider {
    static var previews: some View {
        MoviePoster(backdropPath: "lasdkfj")
    }
}
