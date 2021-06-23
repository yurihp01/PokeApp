//
//  PokemonsListViewModel.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 20/06/21.
//

import PokemonAPI

class PokemonsListViewModel {
  
  // MARK: - Variables
  
  private unowned let view: PokemonsListViewProtocol
  private let service: PokemonServiceProtocol
  
  private var pagedObject: PKMPagedObject<PKMPokemon>? = nil
  
  private var currentPage: Int {
    guard let currentPage = pagedObject?.currentPage else { return 0 }
    return currentPage
  }
  
  private var pages: Int {
    guard let pages = pagedObject?.pages else { return 0 }
    return pages
  }
  
  init(view: PokemonsListViewProtocol, service: PokemonServiceProtocol) {
    self.view = view
    self.service = service
    
    print("INIT - PokemonsListViewModel")
  }
  
  deinit {
    print("DEINIT - PokemonsListViewModel")
  }
  
  // MARK: - Functions
  
  private func setButtonsVisibility() {
    view.setButtonsVisibility(currentPage: currentPage, pages: pages)
  }
  
  private func getPokemonsSuccess(pagedObject: PKMPagedObject<PKMPokemon>) {
    self.pagedObject = pagedObject
    
    guard let results = pagedObject.results as? [PKMNamedAPIResource] else { return }
    let pokemons = results.map { $0.name ?? "" }
    
    self.view.getPokemons(with: pokemons)
    self.setButtonsVisibility()
  }
  
  private func postPokemon(pokemon: Pokemon) {
    WebHooksNetworkManager.shared.postPokemon(pokemon: pokemon) { [weak self] message in
      self?.view.showAlert(message: message)
    } onError: { [weak self] error in
      self?.view.showError(message: error.localizedDescription)
    }
  }
}

// MARK: - Extension

extension PokemonsListViewModel: PokemonsListViewModelProtocol {

  func getPokemons() {
    service.getPokemonsList { [weak self] pagedObject in
      self?.getPokemonsSuccess(pagedObject: pagedObject)
    } onFailure: { [weak self] error in
      self?.view.showError(message: PokemonError.showError(error: error))
    }
  }
  
  func getPokemonsWithPaging(_ pagination: PokemonPagination) {
    guard let pagedObject = pagedObject else { return }
    
    service.getPokemonsListPaging(with: pagedObject, pagination: pagination) { [weak self] pagedObject in
      self?.getPokemonsSuccess(pagedObject: pagedObject)
    } onFailure: { [weak self] error in
      self?.view.showError(message: PokemonError.showError(error: error))
    }
  }
  
  func postPokemon(with name: String) {
    service.getPokemon(name: name) { [weak self] pokemon in
      guard let pokemon = Pokemon.transformToPokemon(pokemon: pokemon) else { return }
      
      self?.postPokemon(pokemon: pokemon)
    } onFailure: { [weak self] error in
      self?.view.showError(message: PokemonError.showError(error: error))
    }
  }
}
