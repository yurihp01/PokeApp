//
//  PokemonsListInterface.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 20/06/21.
//

import Foundation
import PokemonAPI

// MARK: - Enum

enum PokemonPagination {
  case next
  case previous
}

// MARK: - Protocols

protocol PokemonsListViewProtocol: AnyObject {
  func getPokemons(with pokemons: [String])
  func showError(message: String?)
  func setButtonsVisibility(currentPage: Int, pages: Int)
}

protocol PokemonsListViewModelProtocol {
  func getPokemons()
  func getPokemonsWithPaging(_ pagination: PokemonPagination)
}
