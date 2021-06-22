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
  
  var pokemon: PKMPokemon? = nil
  
  init(view: PokemonViewProtocol) {
    self.view = view
    
    print("INIT PokemonViewModel")
  }
  
  deinit {
    print("DEINIT PokemonViewModel")
  }
}

// MARK: - Extension

extension PokemonViewModel: ViewModelProtocol {
  func getPokemon(with name: String?) {
    guard let name = name, !name.isEmpty else {
      view.showError(message: PokemonError.blankName.localizedDescription)
      return
    }
  
    PokemonService.getPokemon(name: name) { [weak self] pokemon in
      guard let image = URL(string: pokemon.sprites?.backDefault ?? ""),
            let name = pokemon.name else { return }
      
      self?.pokemon = pokemon
      self?.view.getPokemon(name: name.capitalized, image: image)
    } onFailure: { [weak self] error in
      self?.view.showError(message: PokemonError.showError(error: error))
    }
  }
  
  func setPokemon(image: UIImage?) {
    guard let pkmPokemon = pokemon,
          let pokemon = Pokemon.transformToPokemon(pokemon: pkmPokemon, image: image) else { return }
    
    view.goToDetails(with: pokemon)
  }
}
