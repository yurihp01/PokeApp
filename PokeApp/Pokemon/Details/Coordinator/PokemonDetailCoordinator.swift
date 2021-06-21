//
//  PokemonDetailCoordinator.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 20/06/21.
//

import PokemonAPI

class PokemonDetailCoordinator: Coordinator {
  
//  MARK: - Variables
  
  var navigationController: UINavigationController
  
  var childCoordinators: [Coordinator] = []
  
  var parentCoordinator: Coordinator?
  
  let pokemon: Pokemon
  
  init(pokemon: Pokemon, navigationController: UINavigationController) {
    self.navigationController = navigationController
    self.pokemon = pokemon
  }
  
  //  MARK: - Function
  
  func start() {
    let viewController = PokemonDetailViewController.instatiate(storyboardName: .pokemonDetails)
    let viewModel = PokemonDetailViewModel(pokemon: pokemon, view: viewController)
    viewController.coordinator = self
    viewController.viewModel = viewModel
    navigationController.pushViewController(viewController, animated: true)
  }
  
  func back() {
    navigationController.popViewController(animated: true)
    parentCoordinator?.remove(childCoordinator: self)
  }
}
