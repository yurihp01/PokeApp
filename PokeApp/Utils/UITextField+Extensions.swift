//
//  UITextField+Extensions.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 21/06/21.
//

import UIKit

// MARK: - Functions
extension UITextField {
  func setDoneOnKeyboard() {
      let keyboardToolbar = UIToolbar()
      keyboardToolbar.sizeToFit()
      let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
      let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
      keyboardToolbar.items = [flexBarButton, doneBarButton]
      self.inputAccessoryView = keyboardToolbar
  }

  @objc private func dismissKeyboard() {
    self.resignFirstResponder()
  }
}
