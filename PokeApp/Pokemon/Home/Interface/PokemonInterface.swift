//
//  PokemonInterface.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 19/06/21.
//

import PokemonAPI

// MARK: - Protocols

protocol ViewModelProtocol {  
  func getPokemon(with name: String?)
  func setPokemon(image: UIImage?)
}

protocol PokemonViewProtocol: AnyObject {
  func getPokemon(name: String, image: URL)
  func goToDetails(with pokemon: Pokemon)
  func showError(message: String)
}

protocol PokemonCoordinatorProtocol {
  func goToDetails(with pokemon: Pokemon)
  func goToAllPokemons()
}

