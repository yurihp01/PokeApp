//
//  PokemonCoordinator.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 19/06/21.
//

import UIKit
import PokemonAPI

class PokemonCoordinator: Coordinator {
  var navigationController: UINavigationController
  
  var childCoordinators: [Coordinator] = []
  
  var parentCoordinator: Coordinator?
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let viewController = PokemonViewController.instatiate(storyboardName: .pokemon)
    viewController.coordinator = self
    
    let viewModel = PokemonViewModel()
    viewModel.view = viewController
    viewController.viewModel = viewModel
    navigationController.pushViewController(viewController, animated: true)
  }
  
  func back() {
    navigationController.popViewController(animated: true)
  }
}

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
