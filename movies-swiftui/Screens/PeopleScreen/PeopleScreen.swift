//
//  PeopleScreen.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 10/3/21.
//  Copyright © 2021 Casey McGuire. All rights reserved.
//

import SwiftUI

struct PeopleScreen: View {
  
  @ObservedObject var viewModel = PeopleScreenViewModel()
  var personId: Int
  
  var body: some View {
    LoadableView(viewModel: viewModel) { data in
      ScrollView {
        VStack {
          PictureScreenHeader(backdropPath: data.profilePath, imagePath: nil, title: data.name, subtitle: nil, includeImage: false)
          VStack {
            let items = getItems(data)
            if !items.isEmpty {
              InfoRowView(items: getItems(data))
                .padding(.bottom, 12)
            }
            if let biography = data.biography {
              TextBlock(title: "Biography", textBody: biography)

            }
            if let movieCredits = data.movieCredits {
              MoviePosterScroll(movies: movieCredits.map { MoviePosterData(id: $0.id, path: $0.posterPath, title: $0.title) })
            }
          }.padding(10)
        }
      }
    }.onAppear(perform: load)
  }
  
  func getItems(_ details: PeopleDetails) -> [InfoRowItem] {
    var arr: [InfoRowItem] = []
    if let birthday = details.birthday {
      arr.append(InfoRowItem(title: "Birthday", text: birthday))
    }
    if let deathDay = details.deathDate{
      arr.append(InfoRowItem(title: "Death Date", text: deathDay))
    }
    if let knownFor = details.knownForDepartment {
      arr.append(InfoRowItem(title: "Known For", text: knownFor))
    }
    return arr
  }
  
  func load() {
    viewModel.load(peopleId: personId)
  }
}

/*struct PeopleScreen_Previews: PreviewProvider {
    static var previews: some View {
        PeopleScreen()
    }
}*/
