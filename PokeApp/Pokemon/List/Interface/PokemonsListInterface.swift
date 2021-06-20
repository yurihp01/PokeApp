//
//  PokemonsListInterface.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 20/06/21.
//

import Foundation
import PokemonAPI

protocol PokemonsListViewProtocol: AnyObject {
  func getPokemons(with pokemons: [String])
  func showError(message: String?)
}

protocol PokemonsListViewModelProtocol {
  func getPokemons()
}
