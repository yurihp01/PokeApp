//
//  PokemonDetailInterface.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 20/06/21.
//

import Foundation

protocol PokemonDetailViewProtocol: AnyObject {
  func setPokemon(with pokemon: Pokemon)
}

protocol PokemonDetailViewModelProtocol {
  func getPokemon()
}
