//
//  MainTabView.swift
//  Cookcademy
//
//  Created by Alice Jin on 2023-08-07.
//

import SwiftUI

struct MainTabView: View {
  @StateObject var recipeData = RecipeData()
  
  var body: some View {
    TabView {
      RecipeCategoryGridView()
        .tabItem { Label("Recipes", systemImage: "list.dash") }
      NavigationView {
          RecipesListView(viewStyle: .favorites)
      }.tabItem { Label("Favorites", systemImage: "heart.fill") }
    }
    .environmentObject(recipeData)
  }
}
 
struct MainTabView_Previews: PreviewProvider {
  static var previews: some View {
    MainTabView()
  }
}
