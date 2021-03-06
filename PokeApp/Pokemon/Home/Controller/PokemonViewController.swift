//
//  PokemonViewController.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 19/06/21.
//

import UIKit
import Kingfisher

final class PokemonViewController: BaseViewController {
  
  // MARK: - Variables

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var detailsButton: UIButton!
  
  var viewModel: PokemonViewModelProtocol?
  weak var coordinator: PokemonCoordinator?
  
  // MARK: - Functions
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setSearchBar()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    indicator.center = view.center
    
    if imageView.image != .none {
      detailsButton.isHidden = false
      setImageView()
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
  
  func setImageView() {
    imageView.makeRounded()
  }
  
  func setSearchBar() {
    searchBar.delegate = self
    searchBar.searchTextField.backgroundColor = .white
    searchBar.searchTextField.setDoneOnKeyboard()
    searchBar.searchTextField.becomeFirstResponder()
  }
    
  @IBAction func detailsButton(_ sender: UIButton) {
    viewModel?.setPokemon(image: imageView.image)
  }
  
  @IBAction func allPokemonsButton(_ sender: UIButton) {
    coordinator?.goToAllPokemons()
  }
}

// MARK: - Extensions

extension PokemonViewController: UISearchBarDelegate {
  
// MARK: - UISearchBarDelegate
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    indicator.startAnimating()
    viewModel?.getPokemon(with: searchBar.text?.lowercased())
    searchBar.text = .none
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.text = .none
  }
}

// MARK: - ViewProtocol

extension PokemonViewController: PokemonViewProtocol {
  func goToDetails(with pokemon: Pokemon) {
    coordinator?.goToDetails(with: pokemon)
  }
  
  func getPokemon(with pokemon: Pokemon) {
    performUIUpdate {
      self.indicator.stopAnimating()
      self.setImageView()
      self.label.text = pokemon.name
      self.detailsButton.isHidden = false
      self.imageView.setImageView(url: pokemon.spriteImage)
      self.imageView.accessibilityValue = "Image Inserted"
    }
  }
  
  func showError(message: String) {
    performUIUpdate {
      self.indicator.stopAnimating()
      self.showAlert(message: message, title: "Error")
    }
  }
}
