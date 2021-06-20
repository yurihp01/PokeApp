//
//  PokemonsListViewModel.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 20/06/21.
//

import Foundation
import PokemonAPI

class PokemonsListViewModel {
  
  weak var view: PokemonsListViewProtocol?
  
  private var pagedObject: PKMPagedObject<PKMPokemon>? = nil
  
  private var currentPage: Int {
    guard let currentPage = pagedObject?.currentPage else { return 0 }
    return currentPage
  }
  
  private var pages: Int {
    guard let pages = pagedObject?.pages else { return 0 }
    return pages
  }
  
  init() {
    print("INIT - PokemonsListViewModel")
  }
  
  deinit {
    print("DEINIT - PokemonsListViewModel")
  }
  
  // MARK: - Functions
  
  private func setButtonsVisibility() {
    view?.setButtonsVisibility(currentPage: currentPage, pages: pages)
  }
  
  private func getPokemonsSuccess(pagedObject: PKMPagedObject<PKMPokemon>) {
    self.pagedObject = pagedObject
    
    guard let results = pagedObject.results as? [PKMNamedAPIResource] else { return }
    let pokemons = results.map { $0.name ?? "" }
    
    self.view?.getPokemons(with: pokemons)
    self.setButtonsVisibility()
  }
}

// MARK: - Extension

extension PokemonsListViewModel: PokemonsListViewModelProtocol {
  
  func getPokemons() {
    PokemonService.getPokemonsList { [weak self] pagedObject in
      self?.getPokemonsSuccess(pagedObject: pagedObject)
    } onFailure: { [weak self] error in
      self?.view?.showError(message: error.localizedDescription)
    }
  }
  
  func getPokemonsWithPaging(_ pagination: PokemonPagination) {
    guard let pagedObject = pagedObject else { return }
    
    PokemonService.getPokemonsListPaging(with: pagedObject, pagination: pagination) { [weak self] pagedObject in
      self?.getPokemonsSuccess(pagedObject: pagedObject)
    } onFailure: { [weak self] error in
      self?.view?.showError(message: error.localizedDescription)
    }
  }
}
