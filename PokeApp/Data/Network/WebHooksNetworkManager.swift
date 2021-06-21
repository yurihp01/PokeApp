//
//  WebHooksNetworkManager.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 21/06/21.
//

import Foundation
import Moya
import PokemonAPI

fileprivate let successMessage = "Pokémon Posted with Success!"

final class WebHooksNetworkManager: WebHooksProtocol {
  
  static let shared = WebHooksNetworkManager()
  var provider = MoyaProvider<WebHooksService>()
  
  private init() {}
  
  func postPokemon(pokemon: PKMPokemon, onSuccess: @escaping (String) -> Void, onError: @escaping (Error) -> Void) {
    provider.request(.postPokemon(pokemon: pokemon.name!)) { result in
      switch result {
        case .success:
          onSuccess(successMessage)
        case .failure:
          onError(PokemonError.postFailure)
      }
    }
  }
}
