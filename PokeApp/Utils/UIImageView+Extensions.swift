//
//  UIImageView.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 19/06/21.
//

import UIKit

extension UIImageView {

  func makeRounded() {
      self.layer.borderWidth = 1
      self.layer.masksToBounds = false
      self.layer.borderColor = #colorLiteral(red: 0.2355829477, green: 0.5289153457, blue: 0.998261869, alpha: 1)
      self.layer.cornerRadius = self.frame.height / 2
      self.clipsToBounds = true
  }
  
  func setImageView(url: URL) {
      self.kf.indicatorType = .activity
      self.kf.setImage(with: url, options: [.transition(.fade(0.2)), .cacheOriginalImage, .fromMemoryCacheOrRefresh])
  }
}
