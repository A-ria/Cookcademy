//
//  RecipeDetailView.swift
//  Cookcademy
//
//  Created by Alice Jin on 2023-07-24.
//

import SwiftUI

struct RecipeDetailView: View {
  @Binding var recipe: Recipe
 
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    @State private var isPresenting = false
   
  var body: some View {
    VStack {
      HStack {
        Text("Author: \(recipe.mainInformation.author)")
          .font(.subheadline)
          .padding()
        Spacer()
      }
      HStack {
        Text(recipe.mainInformation.description)
          .font(.subheadline)
          .padding()
        Spacer()
      }
        List {
            Section(header: Text("Ingredients")) {
                ForEach(recipe.ingredients.indices, id: \.self) { index in
                    let ingredient = recipe.ingredients[index]
                    Text(ingredient.description)
                        .foregroundColor(listTextColor)
                }
            }.listRowBackground(listBackgroundColor)
            Section(header: Text("Directions")) {
                      ForEach(recipe.directions.indices, id: \.self) { index in
                        let direction = recipe.directions[index]
                        HStack {
                          Text("\(index + 1). ").bold()
                          Text("\(direction.isOptional ? "(Optional) " : "")"
                                + "\(direction.description)")
                        }.foregroundColor(listTextColor)
                      }
                    }.listRowBackground(listBackgroundColor)        }
    }
    .navigationTitle(recipe.mainInformation.name)
    .toolbar {
        ToolbarItem {
            HStack {
                Button("Edit") {
                    isPresenting = true
                }
                Button(action: {
                    recipe.isFavorite.toggle()
                }) {
                    Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                }
            }
        }
    }
    .sheet(isPresented: $isPresenting) {
            NavigationView {
              ModifyRecipeView(recipe: $recipe)
                .toolbar {
                  ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                      isPresenting = false
                    }
                  }
                }
                .navigationTitle("Edit Recipe")
            }
          }
  }
}
 
struct RecipeDetailView_Previews: PreviewProvider {
  @State static var recipe = Recipe.testRecipes[0]
  static var previews: some View {
    NavigationView {
        RecipeDetailView(recipe: $recipe)
    }
  }
}
