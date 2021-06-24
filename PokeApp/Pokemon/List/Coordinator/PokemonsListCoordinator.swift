//
//  PokemonsListCoordinator.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 20/06/21.
//

import UIKit

class PokemonsListCoordinator: Coordinator {
  var navigationController: UINavigationController
  
  var childCoordinators: [Coordinator] = []
  
  var parentCoordinator: Coordinator?
  
  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func start() {
    let viewController = PokemonsListViewController.instatiate(storyboardName: .pokemonsList)
    let network = PokemonNetworkManager()
    let viewModel = PokemonsListViewModel(view: viewController, network: network)
    
    viewController.coordinator = self
    viewController.viewModel = viewModel
    navigationController.pushViewController(viewController, animated: true)
  }
  
  func back() {
    parentCoordinator?.remove(childCoordinator: self)
  }
}
