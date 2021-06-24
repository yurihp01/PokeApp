//
//  PokemonNetworkInterface.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 23/06/21.
//

import PokemonAPI

protocol PokemonNetworkProtocol {
  func getPokemon(name: String, onSuccess: @escaping (PKMPokemon) -> Void, onFailure: @escaping (Error) -> Void)
  func getPokemonsList(onSuccess: @escaping (PKMPagedObject<PKMPokemon>) -> Void, onFailure: @escaping (Error) -> Void)
  func getPokemonsListPaging(with pagedObject: PKMPagedObject<PKMPokemon>, pagination: PokemonPagination, onSuccess: @escaping (PKMPagedObject<PKMPokemon>) -> Void, onFailure: @escaping (Error) -> Void)
}
