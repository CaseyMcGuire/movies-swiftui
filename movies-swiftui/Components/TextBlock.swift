//
//  TextBlock.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 10/28/21.
//  Copyright © 2021 Casey McGuire. All rights reserved.
//

import SwiftUI

struct TextBlock: View {
  
  var title: String
  var textBody: String
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(title)
        .font(.system(size: 24))
        .fontWeight(.medium)
        .padding(.bottom, 1)
      LongText(text: textBody, font: .system(size: 17), weight: .light)
    }
  }
}
