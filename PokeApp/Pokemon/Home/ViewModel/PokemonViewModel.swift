//
//  PokemonViewModel.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 19/06/21.
//

import PokemonAPI

class PokemonViewModel {
  
  // MARK: - Variables
  
  private unowned let view: PokemonViewProtocol
  private let network: PokemonNetworkProtocol
  
  var pokemon: Pokemon? = nil
  
  init(view: PokemonViewProtocol, network: PokemonNetworkProtocol) {
    self.view = view
    self.network = network
    
    print("INIT PokemonViewModel")
  }
  
  deinit {
    print("DEINIT PokemonViewModel")
  }
}

// MARK: - Extension

extension PokemonViewModel: PokemonViewModelProtocol {
  func getPokemon(with name: String?) {
    guard let name = name, !name.isEmpty else {
      view.showError(message: PokemonError.blankName.localizedDescription)
      return
    }
  
    network.getPokemon(name: name) { [weak self] pokemon in
      guard let pokemon = Pokemon.transformToPokemon(pokemon: pokemon) else { return }
      self?.pokemon = pokemon
      
      self?.view.getPokemon(with: pokemon)
    } onFailure: { [weak self] error in
      self?.view.showError(message: PokemonError.showError(error: error))
    }
  }
  
  func setPokemon(image: UIImage?) {
    guard var pokemon = pokemon,
          let image = image else { return }
    
    pokemon.image = image
    view.goToDetails(with: pokemon)
  }
}
