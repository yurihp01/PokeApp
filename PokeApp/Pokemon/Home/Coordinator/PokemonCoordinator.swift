//
//  PokemonCoordinator.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 19/06/21.
//

import UIKit
import PokemonAPI

class PokemonCoordinator: Coordinator {
  
  // MARK: - Variables
  
  var navigationController: UINavigationController
  
  var childCoordinators: [Coordinator] = []
  
  var parentCoordinator: Coordinator?
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  // MARK: - Functions
  
  func start() {
    let viewController = PokemonViewController.instatiate(storyboardName: .pokemon)
    let service = PokemonService()
    let viewModel = PokemonViewModel(view: viewController, service: service)
    
    viewController.coordinator = self
    viewController.viewModel = viewModel
    navigationController.pushViewController(viewController, animated: true)
  }
  
  func back() {
    navigationController.popViewController(animated: true)
  }
}

// MARK: - Extension

extension PokemonCoordinator: PokemonCoordinatorProtocol {
  func goToDetails(with pokemon: Pokemon) {
    let coordinator = PokemonDetailCoordinator(pokemon: pokemon, navigationController: navigationController)
    coordinator.parentCoordinator = self
    add(childCoordinator: coordinator)
    coordinator.start()
  }
  
  func goToAllPokemons() {
    let coordinator = PokemonsListCoordinator(navigationController: navigationController)
    coordinator.parentCoordinator = self
    add(childCoordinator: coordinator)
    coordinator.start()
  }
}
