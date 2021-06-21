//
//  PokemonInterface.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 19/06/21.
//

import PokemonAPI

protocol ViewModelProtocol {
  var pokemon: PKMPokemon? { get }
  
  func getPokemon(with name: String?)
  func setPokemon(image: UIImage?)
}

protocol ViewProtocol: AnyObject {
  func getPokemon(name: String, image: URL)
  func goToDetails(with pokemon: Pokemon)
  func showError(message: String)
}

protocol PokemonCoordinatorProtocol {
  func goToDetails(with pokemon: Pokemon)
  func goToAllPokemons()
}

