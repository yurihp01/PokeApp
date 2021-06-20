//
//  BaseCoordinator.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 19/06/21.
//

import UIKit

class BaseCoordinator: Coordinator {
  var navigationController: UINavigationController
  
  var childCoordinators: [Coordinator] = []
  
  var parentCoordinator: Coordinator?
  
  init() {
    navigationController = UINavigationController()
    navigationController.navigationBar.barTintColor = #colorLiteral(red: 0.2355829477, green: 0.5289153457, blue: 0.998261869, alpha: 1)
    navigationController.navigationBar.tintColor = .white
  }
  
  func start() {
    let childCoordinator = PokemonCoordinator(navigationController: navigationController)
    childCoordinator.parentCoordinator = self
    add(childCoordinator: childCoordinator)
    childCoordinator.start()
  }
}
