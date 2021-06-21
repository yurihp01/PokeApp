//
//  Pokemon.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 20/06/21.
//

import PokemonAPI

struct Pokemon {
  let name, height, weight, move, type, ability: String
  let image: UIImage
  
  init(name: String, height: String, weight: String, move: String, type: String, ability: String, image: UIImage) {
    self.name = name
    self.height = height
    self.weight = weight
    self.move = move
    self.type = type
    self.ability = ability
    self.image = image
  }
}
