//
//  PokemonViewModel.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 19/06/21.
//

import Foundation
import PokemonAPI

class PokemonViewModel {
  
  weak var view: ViewProtocol?
  var pokemon: PKMPokemon? = nil
  
  init() {
    print("INIT PokemonViewModel")
  }
  
  deinit {
    print("DEINIT PokemonViewModel")
  }
}

extension PokemonViewModel: ViewModelProtocol {
  func getPokemon(with name: String?) {
    guard let name = name else { return }
  
    PokemonService.getPokemon(name: name) { [weak self] pokemon in
      guard let image = URL(string: pokemon.sprites?.backDefault ?? ""),
            let name = pokemon.name else { return }
      
      self?.pokemon = pokemon
      self?.view?.getPokemon(name: name.capitalized, image: image)
    } onFailure: { [weak self] error in
      self?.view?.showError(message: error.localizedDescription)
    }
  }
}
