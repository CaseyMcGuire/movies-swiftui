//
//  MovieListItem.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 4/19/26.
//  Copyright © 2026 Casey McGuire. All rights reserved.
//

import SwiftUI

struct MovieListItem: View {
  var movie: MovieResult
  
  var body: some View {
    HStack {
      MoviePoster(backdropPath: movie.posterPath, title: nil, size: .medium, circle: false)
      VStack(spacing: 8) {
        Text(movie.title)
          .font(.system(size: 16, weight: .bold))
          .frame(maxWidth: .infinity, alignment: .center)
          .multilineTextAlignment(.center)
        if let releaseDate = movie.releaseDate {
          Text(releaseDate)
            .font(.system(size: 12, weight: .regular))
            .foregroundStyle(.secondary)
          Spacer()
        }
        
        Text(movie.overview)
          .font(Font.system(size: 14, weight: .regular))
          .lineLimit(6)
          .frame(maxWidth: .infinity, alignment: .center)
          .multilineTextAlignment(.center)

        Spacer()
      }
      .frame(maxWidth: .infinity)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}
