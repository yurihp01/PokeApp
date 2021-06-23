//
//  PokeAppTests.swift
//  PokeAppTests
//
//  Created by Yuri Pedroso on 19/06/21.
//

import XCTest
@testable import PokeApp

class WebhooksTest: XCTestCase {
  
  // MARK: - Functions

  func testPostPokemonSuccess() throws {
    let pokemon = Pokemon(name: "Arceus", height: "20", weight: "30", move: "Cut", type: "Grass", ability: "Bite")
    
    WebHooksNetworkManagerStub(isFailure: false).postPokemon(pokemon: pokemon) { message in
      XCTAssertTrue(message == "Pokemon sent successfully")
    } onError: { _ in }
  }
  
  func testPostPokemonFailure() throws {
    let pokemon = Pokemon(name: "Arceus", height: "20", weight: "30", move: "Cut", type: "Grass", ability: "Bite")
    
    WebHooksNetworkManagerStub(isFailure: true).postPokemon(pokemon: pokemon) { _ in
    } onError: { error in
      XCTAssertEqual("The pokemon data has failed posting on WebHooks. Try again later.", error.localizedDescription)
    }
  }
}
