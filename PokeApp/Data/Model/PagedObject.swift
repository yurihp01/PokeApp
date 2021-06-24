//
//  PagedObject.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 23/06/21.
//

import PokemonAPI

struct PagedObject {
  
  let pagedObject: PKMPagedObject<PKMPokemon>
  
  var currentPage: Int {
    return pagedObject.currentPage
  }
  
  var pages: Int {
    return pagedObject.pages
  }
  
  init(pagedObject: PKMPagedObject<PKMPokemon>) {
    self.pagedObject = pagedObject
  }
  
  func getPokemonNames(results: [PKMNamedAPIResource<PKMPokemon>]) -> [String] {
    return results.map { $0.name ?? "" }
  }
}
