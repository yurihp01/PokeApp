//
//  PokemonsListViewModel.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 20/06/21.
//

import Foundation
import PokemonAPI

class PokemonsListViewModel {
  
  weak var view: PokemonsListViewProtocol?
  
  init() {
    print("INIT - PokemonsListViewModel")
  }
  
  deinit {
    print("DEINIT - PokemonsListViewModel")
  }
}

// MARK: - Extension

extension PokemonsListViewModel: PokemonsListViewModelProtocol {
  
  func getPokemons() {
    PokemonService.getPokemonsList { [weak self] pokemons in
      self?.view?.getPokemons(with: pokemons)
    } onFailure: { [weak self] error in
      self?.view?.showError(message: error.localizedDescription)
    }
  }
}
