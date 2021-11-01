//
//  InfoRowView.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 10/31/21.
//  Copyright © 2021 Casey McGuire. All rights reserved.
//

import SwiftUI

struct InfoRowView: View {
  var items: [InfoRowItem]
  var body: some View {
    if items.isEmpty {
      EmptyView()
    }
    else {
      HStack {
        ForEach(items, id: \.self) { item in
          InfoRowViewItem(title: item.title, text: item.text)
        }
      }
    }
  }
}

struct InfoRowItem: Hashable {
  var title: String
  var text: String
}

private struct InfoRowViewItem: View {
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

struct InfoRowView_Previews: PreviewProvider {
    static var previews: some View {
        InfoRowView(items: [])
    }
}
