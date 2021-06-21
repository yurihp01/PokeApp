//
//  UIAlertController+Extensions.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 19/06/21.
//

import UIKit

extension UIAlertController {
  
  // MARK: - Function

  static func showAlertDialog(title: String, message: String) -> UIAlertController {
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
      alert.addAction(okAction)
      return alert
  }
}
