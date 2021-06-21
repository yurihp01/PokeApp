//
//  PokemonError.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 20/06/21.
//

import Foundation

// MARK: Enums
enum PokemonError: Error {
  case notFound
  case blankName
  case internetConnection
  case postFailure
}

// MARK: Extensions

extension PokemonError: LocalizedError {
  var errorDescription: String? {
    switch self {
      case .notFound:
        return "Pokémon not found. Check the name typed and try again!"
      case .blankName:
        return "The field is empty. Type a pokemon name!"
      case .internetConnection:
        return "The internet connection appears to be offline. Check your connection and try again."
      case .postFailure:
        return "The pokemon data has failed posting on WebHooks. Try again later."
    }
  }
  
  static func showError(error: Error) -> String {
    error.localizedDescription.contains("404") ?  PokemonError.notFound.localizedDescription : PokemonError.internetConnection.localizedDescription
  }
}
