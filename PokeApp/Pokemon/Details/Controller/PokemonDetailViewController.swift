//
//  PokemonDetailViewController.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 20/06/21.
//

import UIKit

class PokemonDetailViewController: BaseViewController {

  // MARK: - Variables
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var heightLabel: UILabel!
  @IBOutlet weak var weightLabel: UILabel!
  @IBOutlet weak var typeLabel: UILabel!
  @IBOutlet weak var abilityLabel: UILabel!
  @IBOutlet weak var moveLabel: UILabel!
  
  var viewModel: PokemonDetailViewModelProtocol?
  weak var coordinator: PokemonDetailCoordinator?
  
  // MARK: - Functions
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    getPokemon()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    coordinator?.back()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    if imageView.image != .none {
      imageView.makeRounded()
    }
  }
  
  private func getPokemon() {
    viewModel?.getPokemon()
  }
}

//MARK: - Extensions

extension PokemonDetailViewController: PokemonDetailViewProtocol {
  func setPokemon(with pokemon: Pokemon) {
    nameLabel.text = pokemon.name
    heightLabel.text = "Height: \(pokemon.height)"
    weightLabel.text = "Weight: \(pokemon.weight)"
    typeLabel.text = "Type: \(pokemon.type)"
    abilityLabel.text = "Ability: \(pokemon.ability)"
    moveLabel.text = "Move: \(pokemon.move)"
    imageView.image = pokemon.image
    imageView.makeRounded()
  }
}
