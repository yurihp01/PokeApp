//
//  Pokemon.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 20/06/21.
//

import PokemonAPI

struct Pokemon: Encodable {
  let name, height, weight, move, type, ability: String
  let image: UIImage
  
  init(name: String, height: String, weight: String, move: String, type: String, ability: String, image: UIImage = UIImage()) {
    self.name = name
    self.height = height
    self.weight = weight
    self.move = move
    self.type = type
    self.ability = ability
    self.image = image
  }
  
  static func transformToPokemon(pokemon: PKMPokemon, image: UIImage? = UIImage()) -> Pokemon? {
    guard let name = pokemon.name?.capitalized,
          let height = pokemon.height?.description,
          let weight = pokemon.weight?.description,
          let ability = pokemon.abilities?.first?.ability?.name?.capitalized,
          let move = pokemon.moves?.first?.move?.name?.capitalized,
          let type = pokemon.types?.first?.type?.name?.capitalized,
          let image = image else { return nil }
    
    let pokemon = Pokemon(name: name, height: height, weight: weight, move: move, type: type, ability: ability, image: image)
    
    return pokemon
  }
  
  static func loadJson(fileName: String) -> PKMPokemon? {
     let decoder = JSONDecoder()
     guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
           let data = try? Data(contentsOf: url),
           let pokemon = try? decoder.decode(PKMPokemon.self, from: data) else { return nil }
     return pokemon
  }
}

extension Pokemon {
  enum CodingKeys: String, CodingKey {
    case name, height, weight, ability, move, type, image
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)

    try container.encode(name, forKey: .name)
    try container.encode(height, forKey: .height)
    try container.encode(weight, forKey: .weight)
    try container.encode(ability, forKey: .ability)
    try container.encode(move, forKey: .move)
    try container.encode(type, forKey: .type)
  }
}
