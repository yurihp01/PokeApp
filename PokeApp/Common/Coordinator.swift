//
//  Coordinator.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 19/06/21.
//

import UIKit

protocol Coordinator: AnyObject {
  
  // MARK: - Variable
  var navigationController: UINavigationController { get set }
  var childCoordinators: [Coordinator] { get set }
  var parentCoordinator: Coordinator? { get set }
  
  // MARK: - Functions
  func start()
  func back()
  func add(childCoordinator coordinator: Coordinator)
  func remove(childCoordinator coordinator: Coordinator)
  func childDidFinish(_ child: Coordinator?)
}

// MARK: - Extension

extension Coordinator {
  func back() {}
  
  func add(childCoordinator coordinator: Coordinator) {
    childCoordinators.append(coordinator)
  }
  
  func remove(childCoordinator coordinator: Coordinator) {
    childCoordinators.removeAll {
      $0 === coordinator
    }
  }
  
  func childDidFinish(_ child: Coordinator?) {
    guard let child = child else { return }
    remove(childCoordinator: child)
  }
}
