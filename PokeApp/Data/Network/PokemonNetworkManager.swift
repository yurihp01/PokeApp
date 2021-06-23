//
//  PokemonService.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 19/06/21.
//

import Foundation
import PokemonAPI

// MARK: - Functions
protocol PokemonServiceProtocol {
  func getPokemon(name: String, onSuccess: @escaping (PKMPokemon) -> Void, onFailure: @escaping (Error) -> Void)
  func getPokemonsList(onSuccess: @escaping (PKMPagedObject<PKMPokemon>) -> Void, onFailure: @escaping (Error) -> Void)
  func getPokemonsListPaging(with pagedObject: PKMPagedObject<PKMPokemon>, pagination: PokemonPagination, onSuccess: @escaping (PKMPagedObject<PKMPokemon>) -> Void, onFailure: @escaping (Error) -> Void)
}

class PokemonService: PokemonServiceProtocol {
  
  func getPokemon(name: String, onSuccess: @escaping (PKMPokemon) -> Void, onFailure: @escaping (Error) -> Void) {
    PokemonAPI().pokemonService.fetchPokemon(name) { result in
      switch result {
        case .success(let pokemon):
          onSuccess(pokemon)
        case .failure(let error):
          onFailure(error)
      }
    }
  }
  
  func getPokemonsList(onSuccess: @escaping (PKMPagedObject<PKMPokemon>) -> Void, onFailure: @escaping (Error) -> Void) {
    PokemonAPI().pokemonService.fetchPokemonList { result in
      switch result {
        case .success(let pagination):
          onSuccess(pagination)
        case .failure(let error):
          onFailure(error)
      }
    }
  }
  
  func getPokemonsListPaging(with pagedObject: PKMPagedObject<PKMPokemon>, pagination: PokemonPagination, onSuccess: @escaping (PKMPagedObject<PKMPokemon>) -> Void, onFailure: @escaping (Error) -> Void) {
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
