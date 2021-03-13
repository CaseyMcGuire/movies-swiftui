//
//  MovieInfoRow.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 3/12/21.
//  Copyright © 2021 Casey McGuire. All rights reserved.
//

import SwiftUI

struct MovieInfoRow: View {
  var rating: String?
  var releaseDate: String?
  var language: String?
  
  var body: some View {
    if self.rating == nil && self.releaseDate == nil && self.language == nil {
      EmptyView()
    } else {
        HStack {
          if let rating = self.rating {
            MovieInfoRowItem(title: "Rating", text: rating)
          }
          if let releaseDate = self.releaseDate {
            MovieInfoRowItem(title: "Release Date", text: releaseDate)
          }
          if let language = self.language {
            MovieInfoRowItem(title: "Language", text: language)
          }
          
        }
        .padding(.bottom, 12)
      }
  }
}



struct MovieInfoRow_Previews: PreviewProvider {
  static var previews: some View {
    MovieInfoRow(rating: "8.2", releaseDate: "March 15, 2021", language: "English")
  }
}

private struct MovieInfoRowItem: View {
  var title: String
  var text: String
  var body: some View {
    HStack {
      Spacer()
      VStack {
        Text(title)
          .font(.system(size: 17))
          .fontWeight(.semibold)
        Text(text)
          .font(.system(size: 15))
          .foregroundColor(.gray)
      }
      Spacer()
    }
  }
}
