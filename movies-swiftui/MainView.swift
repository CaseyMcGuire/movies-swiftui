//
//  MainView.swift
//  movies-swiftui
//
//  Created by Casey McGuire on 3/18/21.
//  Copyright © 2021 Casey McGuire. All rights reserved.
//

import SwiftUI

struct MainView: View {
  var body: some View {
    TabView {
      HomeScreen()
        .tabItem {
          Label("Home", systemImage: "house")
        }
    }
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
