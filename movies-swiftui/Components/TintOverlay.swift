//
//  TintOverlay.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 3/8/21.
//  Copyright © 2021 Casey McGuire. All rights reserved.
//

import SwiftUI

// https://www.codebales.com/swiftui-background-image-with-gradient-tint
struct TintOverlay: View {
  @Environment(\.colorScheme) var colorScheme
  
  var body: some View {
    let color = self.colorScheme == .dark ? Color.black : Color.white
    ZStack {
      Text(" ")
    }
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    .background(LinearGradient(gradient: Gradient(colors: [color.opacity(0.1), color]), startPoint: .top, endPoint: .bottom))
  }
}

