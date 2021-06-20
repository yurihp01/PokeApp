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
  
  static func getPokemonsList(onSuccess: @escaping ([String]) -> Void, onFailure: @escaping (Error) -> Void) {
    PokemonAPI().pokemonService.fetchPokemonList { result in
      switch result {
        case .success(let pagination):
          guard let results = pagination.results as? [PKMNamedAPIResource] else { return }
          onSuccess(results.map { $0.name ?? "" })
        case .failure(let error):
          onFailure(error)
      }
    }
  }
}
