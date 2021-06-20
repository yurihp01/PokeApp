//
//  PokemonService.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 19/06/21.
//

import Foundation
import PokemonAPI

class PokemonService {
  static func getPokemon(name: String, onSuccess: @escaping (PKMPokemon) -> Void, onFailure: @escaping (Error) -> Void) {
    PokemonAPI().pokemonService.fetchPokemon(name) { result in
      switch result {
        case .success(let pokemon):
          onSuccess(pokemon)
        case .failure(let error):
          onFailure(error)
      }
    }
  }
}
