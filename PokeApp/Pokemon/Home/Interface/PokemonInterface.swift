//
//  PokemonInterface.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 19/06/21.
//

import Foundation
import PokemonAPI

protocol ViewModelProtocol {
  var pokemon: PKMPokemon? { get }
  func getPokemon(with name: String?)
}

protocol ViewProtocol: AnyObject {
  func getPokemon(name: String, image: URL)
  func showError(message: String)
}

protocol PokemonCoordinatorProtocol {
  func goToDetails(with pokemon: PKMPokemon?)
}

