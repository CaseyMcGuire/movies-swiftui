//
//  MovieScreenHeader.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 3/21/21.
//  Copyright © 2021 Casey McGuire. All rights reserved.
//

import SwiftUI

struct MovieScreenHeader: View {
  var movie: MovieScreenViewModel.MovieDetails
  var body: some View {
    VStack {
      let backdropImage =  TMDBImageUtil.createImageMaybe(imagePath: movie.backdropPath, imageSize: .W780)
      if let backdropImage = backdropImage {
        Image(uiImage: backdropImage)
          .resizable()
          .scaledToFit()
          .overlay(TintOverlay())
      }
      
      
      VStack(alignment: .leading) {
        VStack {
          HStack {
            MoviePoster(backdropPath: movie.posterPath)
            Spacer()
            VStack {
              Text(String(self.movie.title))
                .font(.system(size: 24))
                .fontWeight(.semibold)
              
              if let tagline = movie.tagline {
                Text(String(tagline))
                  .font(.system(size: 17))
              }
            }
            Spacer()
          }
          .offset(y: backdropImage != nil ? -140 : 0)
          .padding(.bottom, backdropImage != nil ? -140 : 0)
          .padding(.horizontal)
        }
      }
    }
  }
}


/*struct MovieScreenHeader_Previews: PreviewProvider {
    static var previews: some View {
        MovieScreenHeader()
    }
}*/
