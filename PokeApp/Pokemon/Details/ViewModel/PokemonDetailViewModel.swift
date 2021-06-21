//
//  PokemonDetailViewModel.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 20/06/21.
//

import Foundation

class PokemonDetailViewModel {
  
  // MARK: - Variable
  
  private let pokemon: Pokemon
  
  private unowned var view: PokemonDetailViewProtocol
  
  init(pokemon: Pokemon, view: PokemonDetailViewProtocol) {
    self.pokemon = pokemon
    self.view = view
    
    print("INIT - PokemonDetailViewModel")
  }
  
  deinit {
    print("DEINIT - PokemonDetailViewModel")
  }
  
}

// MARK: - Extension

extension PokemonDetailViewModel: PokemonDetailViewModelProtocol {
  func getPokemon() {
    view.setPokemon(with: pokemon)
  }
}
