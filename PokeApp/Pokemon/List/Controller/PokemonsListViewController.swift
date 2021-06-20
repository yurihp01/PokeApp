//
//  PokemonsListViewController.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 20/06/21.
//

import UIKit

final class PokemonsListViewController: BaseViewController {

  // MARK: - Variables
  
  @IBOutlet weak var tableView: UITableView!
  
  var viewModel: PokemonsListViewModelProtocol?
  weak var coordinator: PokemonsListCoordinator?
  
  var pokemons: [String] = []
  
  // verificar se dá para trazer as imagens dos pokemons de maneira facil.
  
  // MARK: - Override functions
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setTableView()
    getPokemons()
  }
    
  // MARK: - Private Functions
  
  private func setTableView() {
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  private func getPokemons() {
    viewModel?.getPokemons()
  }
  
}

// MARK: - Extensions

extension PokemonsListViewController: UITableViewDelegate, UITableViewDataSource {
  
  // MARK: - UITableView
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 0
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    pokemons.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = pokemons[indexPath.row]
    
    return cell
  }
}

// MARK: - PokemonsListViewProtocol

extension PokemonsListViewController: PokemonsListViewProtocol {
  func showError(message: String?) {
    showAlert(message: message)
  }
  
  func getPokemons(with pokemons: [String]) {
    self.pokemons = pokemons
  }
}
