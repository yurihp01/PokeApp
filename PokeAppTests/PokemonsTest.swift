//
//  PokemonsTest.swift
//  PokeAppTests
//
//  Created by Yuri Pedroso on 22/06/21.
//

import XCTest
import PokemonAPI
@testable import PokeApp

class PokemonsTest: XCTestCase {

  // MARK: - Functions
  
  func testPokemonFromJson() {
    guard let pokemon = getPokemon(),
          let pokemonWeight = pokemon.weight?.description,
          let pokemonName = pokemon.name else { return }
    let name = "arceus"
    let weight = "3200"
    
    XCTAssertEqual(weight, pokemonWeight, "Pokemon's weight should be \(weight)")
    XCTAssertEqual(name, pokemonName, "Pokemon's name should be \(name)")
  }
  
  func testTransformPokemonWithoutImage() {
    guard let pkm = getPokemon() else { return }
    
    let image = UIImage()
    let pokemon = Pokemon.transformToPokemon(pokemon: pkm)
    
    XCTAssertEqual(pokemon?.name, "Arceus", "Pokemon's name should be Arceus")
    XCTAssertEqual(pokemon?.weight, "3200", "Pokemon's weight should be 3200")
    XCTAssertEqual(pokemon?.image, image, "Pokemon's image should be empty")
  }
  
  func testTransformPokemonWithImage() {
    guard let pkm = getPokemon() else { return }
    
    let image = UIImage(systemName: "star")
    let pokemon = Pokemon.transformToPokemon(pokemon: pkm, image: image)
    
    XCTAssertEqual(pokemon?.name, "Arceus", "Pokemon's name should be Arceus")
    XCTAssertEqual(pokemon?.weight, "3200", "Pokemon's weight should be 3200")
    XCTAssertNotEqual(pokemon?.image, UIImage(), "Pokemon's image should not be empty")
  }
  
  func testPokemonNotFoundError() {
    let message = "Error 404: Pokémon not found"
    let error = NSError(domain: message, code: 404, userInfo: nil)
    
    let errorMessage = PokemonError.showError(error: error)
    
    XCTAssertEqual(errorMessage, "Pokémon not found. Check the name typed and try again!", "Error should be: Not Found")
  }
  
  func testPokemonNoInternetConnectionError() {
    let message = "Error 408: No internet connection"
    let error = NSError(domain: message, code: 408, userInfo: nil)
    
    let errorMessage = PokemonError.showError(error: error)
    
    XCTAssertEqual(errorMessage, "The internet connection appears to be offline. Check your connection and try again.", "Error should be: No Internet Connection")
  }
  
  private func getPokemon() -> PKMPokemon? {
    guard let pokemon = Pokemon.loadJson(fileName: "arceus") else { return nil }
    return pokemon
  }
}
