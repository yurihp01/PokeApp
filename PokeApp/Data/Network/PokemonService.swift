//
//  PokemonService.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 19/06/21.
//

import Foundation
import PokemonAPI

// MARK: - Functions

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
  
  static func getPokemonsList(onSuccess: @escaping (PKMPagedObject<PKMPokemon>) -> Void, onFailure: @escaping (Error) -> Void) {
    PokemonAPI().pokemonService.fetchPokemonList { result in
      switch result {
        case .success(let pagination):
          onSuccess(pagination)
        case .failure(let error):
          onFailure(error)
      }
    }
  }
  
  static func getPokemonsListPaging(with pagedObject: PKMPagedObject<PKMPokemon>, pagination: PokemonPagination, onSuccess: @escaping (PKMPagedObject<PKMPokemon>) -> Void, onFailure: @escaping (Error) -> Void) {
    PokemonAPI().pokemonService.fetchPokemonList(paginationState: .continuing(pagedObject, pagination == .next ? .next : .previous)) { result in
      switch result {
        case .success(let pagination):
          onSuccess(pagination)
        case .failure(let error):
          onFailure(error)
      }
    }
  }
}
