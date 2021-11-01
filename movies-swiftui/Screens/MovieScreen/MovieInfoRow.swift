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
        InfoRowView(items: getItems())
          .padding(.bottom, 12)
      }
  }
  
  private func getItems() -> [InfoRowItem] {
    var arr: [InfoRowItem] = []
    if let rating = self.rating {
      arr.append(InfoRowItem(title: "Rating", text: rating))
    }
    if let releaseDate = self.releaseDate {
      arr.append(InfoRowItem(title: "Release Date", text: releaseDate))
    }
    if let language = self.language {
      arr.append(InfoRowItem(title: "Language", text: language))
    }
    return arr
  }
}

struct MovieInfoRow_Previews: PreviewProvider {
  static var previews: some View {
    MovieInfoRow(rating: "8.2", releaseDate: "March 15, 2021", language: "English")
  }
}
