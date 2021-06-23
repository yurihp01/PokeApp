//
//  PokemonServiceMock.swift
//  PokeAppTests
//
//  Created by Yuri Pedroso on 22/06/21.
//

@testable import PokeApp
import Foundation
import Moya

class WebHooksNetworkManagerStub: WebHooksProtocol {
  
  // MARK: - Variable
  
  private var provider: MoyaProvider<WebHooksService>
  
  init(isFailure: Bool) {
    if isFailure {
      let customEndpointClosure = { (target: WebHooksService) -> Endpoint in
          return Endpoint(url: URL(target: target).absoluteString,
                          sampleResponseClosure: { .networkError(NSError()) },
                          method: target.method,
                          task: target.task,
                          httpHeaderFields: target.headers)
      }

      let stubbingProvider = MoyaProvider<WebHooksService>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub)
      provider = stubbingProvider
    } else {
      provider = MoyaProvider<WebHooksService>(stubClosure: MoyaProvider.immediatelyStub)
    }
  }
  
  // MARK: - Function
  
  func postPokemon(pokemon: Pokemon, onSuccess: @escaping (String) -> Void, onError: @escaping (Error) -> Void) {
    provider.request(.postPokemon(pokemon: pokemon)) { result in
      switch result {
        case .success:
          onSuccess("Pokemon sent successfully")
        case .failure:
          onError(PokemonError.postFailure)
      }
    }
  }
}
