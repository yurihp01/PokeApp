//
//  BaseViewController.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 19/06/21.
//

import UIKit

class BaseViewController: UIViewController {

//  func showAlert(message: String?) {
//      guard let message = message else { return }
//      let alert = UIAlertController.showAlertDialog(title: Constants.titleError, message: message)
//      self.present(alert, animated: true, completion: nil)
//  }
  
  // MARK: - Variables
  lazy var indicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(frame: CGRect(x: view.center.x - 24, y: view.center.y, width: 40, height: 40))
    indicator.style = .large
    indicator.hidesWhenStopped = true
    return indicator
  }()
  
  // MARK: - Override Functions
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(indicator)
  }
  
  // MARK: Functions
  
  func showAlert(message: String?) {
    
  }
}
