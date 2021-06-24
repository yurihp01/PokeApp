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
  private let network: PokemonNetworkProtocol
  
  private var pagedObject: PagedObject? = nil
  var bookmarkedPokemons: [(Int, Int)] = []
  
  init(view: PokemonsListViewProtocol, network: PokemonNetworkProtocol) {
    self.view = view
    self.network = network
    
    print("INIT - PokemonsListViewModel")
  }
  
  deinit {
    print("DEINIT - PokemonsListViewModel")
  }
  
  // MARK: - Functions
  
  private func getPokemonsSuccess(object: PKMPagedObject<PKMPokemon>) {
    self.pagedObject = PagedObject(pagedObject: object)

    guard let results = object.results as? [PKMNamedAPIResource],
          let pagedObject = pagedObject else { return }
    
    let names = pagedObject.getPokemonNames(results: results)
    
    view.getPokemons(with: names)
    view.setButtonsVisibility()
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
    network.getPokemonsList { [weak self] pagedObject in
      self?.getPokemonsSuccess(object: pagedObject)
    } onFailure: { [weak self] error in
      self?.view.showError(message: PokemonError.showError(error: error))
    }
  }
  
  func getPokemonsWithPaging(_ pagination: PokemonPagination) {
    guard let pagedObject = pagedObject else { return }
    
    network.getPokemonsListPaging(with: pagedObject.pagedObject, pagination: pagination) { [weak self] pagedObject in
      self?.getPokemonsSuccess(object: pagedObject)
    } onFailure: { [weak self] error in
      self?.view.showError(message: PokemonError.showError(error: error))
    }
  }
  
  func postPokemon(with name: String) {
    network.getPokemon(name: name) { [weak self] pokemon in
      guard let pokemon = Pokemon.transformToPokemon(pokemon: pokemon) else { return }
      self?.postPokemon(pokemon: pokemon)
    } onFailure: { [weak self] error in
      self?.view.showError(message: PokemonError.showError(error: error))
    }
  }
  
  func setEnabled(isNextButton: Bool) -> Bool {
    guard let pagedObject = pagedObject else { return false }
    
    if isNextButton {
      return pagedObject.currentPage < pagedObject.pages - 1
    } else {
      return pagedObject.currentPage > 0
    }
  }
  
  func setColor(isNextButton: Bool) -> UIColor {
      return setEnabled(isNextButton: isNextButton) ? #colorLiteral(red: 0.2355829477, green: 0.5289153457, blue: 0.998261869, alpha: 1) : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
  }
  
  func setImage(indexPath: IndexPath, completion: () -> ()) {
    guard let pagedObject = pagedObject else { return }

    bookmarkedPokemons.forEach { row, page in
      if pagedObject.currentPage == page, indexPath.row == row {
        completion()
      }
    }
  }
  
  func addBookmarkedPokemon(indexPath: IndexPath) {
    guard let pagedObject = pagedObject else { return }
    bookmarkedPokemons.append((indexPath.row, pagedObject.currentPage))
  }
}
