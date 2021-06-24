//
//  WebHooksService.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 21/06/21.
//

import Moya
import PokemonAPI

// MARK: - Enum

enum WebHooksService {
  case postPokemon(pokemon: Pokemon)
}

// MARK: - Extension

extension WebHooksService: TargetType {
  var baseURL: URL {
    return URL(string: "https://webhook.site")!
  }
  
  var path: String {
    return "/8218f88f-49c8-4e8e-92b2-87d40e8b9690"
  }
  
  var method: Moya.Method {
    return .post
  }
  
  var sampleData: Data {
    return Data()
  }
  
  var task: Task {
    switch self {
      case .postPokemon(let pokemon):
        return .requestJSONEncodable(pokemon)
    }
  }
  
  var headers: [String : String]? {
    return ["Content-type": "application/json"]
  }
}
