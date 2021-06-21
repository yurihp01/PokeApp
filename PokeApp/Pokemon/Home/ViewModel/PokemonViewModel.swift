//
//  PokemonViewModel.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 19/06/21.
//

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
    guard let name = name else {
      
      return }
  
    PokemonService.getPokemon(name: name) { [weak self] pokemon in
      guard let image = URL(string: pokemon.sprites?.backDefault ?? ""),
            let name = pokemon.name else { return }
      
      self?.pokemon = pokemon
      self?.view?.getPokemon(name: name.capitalized, image: image)
    } onFailure: { [weak self] error in
      self?.view?.showError(message: error.localizedDescription)
    }
  }
  
  func setPokemon(image: UIImage?) {
    guard let name = pokemon?.name?.capitalized,
          let height = pokemon?.height?.description,
          let weight = pokemon?.weight?.description,
          let ability = pokemon?.abilities?.first?.ability?.name?.capitalized,
          let move = pokemon?.moves?.first?.move?.name?.capitalized,
          let type = pokemon?.types?.first?.type?.name?.capitalized,
          let image = image else { return }
    
    let pokemon = Pokemon(name: name, height: height, weight: weight, move: move, type: type, ability: ability, image: image)
    
    view?.goToDetails(with: pokemon)
  }
}
