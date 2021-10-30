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
          HStack {
            MoviePoster(backdropPath: data.profilePath, size: .large)
            VStack {
              if let name = data.name {
                Text(name)
              }
            }
          }
          TextBlock(title: "Biography", textBody: data.biography!)
        }
      }.padding(10)
    }.onAppear(perform: load)
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
