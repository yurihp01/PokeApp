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
  func showAlert(message: String)
  func setButtonsVisibility()
}

protocol PokemonsListViewModelProtocol {
  var bookmarkedPokemons: [(Int, Int)] { get set }

  func getPokemons()
  func getPokemonsWithPaging(_ pagination: PokemonPagination)
  func postPokemon(with name: String)
  func setEnabled(isNextButton: Bool) -> Bool
  func setColor(isNextButton: Bool) -> UIColor
  func setImage(indexPath: IndexPath, completion: () -> ())
  func addBookmarkedPokemon(indexPath: IndexPath)
}

protocol WebHooksProtocol {
  func postPokemon(pokemon: Pokemon, onSuccess: @escaping (String) -> Void, onError: @escaping (Error) -> Void)
}
