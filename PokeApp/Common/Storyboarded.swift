//
//  Storyboarded.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 19/06/21.
//

import UIKit

enum Storyboard: String {
  case pokemon
  case pokemonDetails
}

// MARK: - Protocol

protocol Storyboarded {
  static func instatiate(storyboardName name: Storyboard) -> Self
}

// MARK: - Extension

extension Storyboarded where Self: UIViewController {
  static func instatiate(storyboardName name: Storyboard) -> Self {
    let fullName = NSStringFromClass(self)
    
    // get the value at position 1 because it's the view controller name.
    let className = fullName.components(separatedBy: ".")[1]
    
    let storyboard = UIStoryboard(name: name.rawValue, bundle: nil)
    return storyboard.instantiateViewController(identifier: className) as! Self
  }
}
