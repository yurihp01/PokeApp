//
//  PokemonsListViewController.swift
//  PokeApp
//
//  Created by Yuri Pedroso on 20/06/21.
//

import UIKit

final class PokemonsListViewController: BaseViewController {

  //  MARK: - Enum
    
  enum Titles: String {
    case error = "Error"
    case posted = "Success"
  }

  // MARK: - Variables
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var nextButton: UIButton!
  @IBOutlet weak var previousButton: UIButton!
  
  var viewModel: PokemonsListViewModelProtocol?
  var pokemons: [String] = []
  var indexPath: IndexPath? = nil
  
  weak var coordinator: PokemonsListCoordinator?
  
  // MARK: - Functions
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setTableView()
    getPokemons()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    coordinator?.back()
  }
    
  private func setTableView() {
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  private func getPokemons() {
    viewModel?.getPokemons()
    indicator.startAnimating()
  }
  
  @IBAction func previousButton(_ sender: UIButton) {
    indicator.startAnimating()
    viewModel?.getPokemonsWithPaging(.previous)
  }
  
  @IBAction func nextButton(_ sender: UIButton) {
    indicator.startAnimating()
    viewModel?.getPokemonsWithPaging(.next)
  }
}

// MARK: - Extensions

extension PokemonsListViewController: UITableViewDelegate, UITableViewDataSource {
  
  // MARK: - UITableView
  
  func numberOfSections(in tableView: UITableView) -> Int { 1 }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    pokemons.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = pokemons[indexPath.row].capitalized
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    indicator.startAnimating()
    viewModel?.postPokemon(with: pokemons[indexPath.row])
    self.indexPath = indexPath
  }
}

// MARK: - PokemonsListViewProtocol

extension PokemonsListViewController: PokemonsListViewProtocol {
  func showError(message: String?) {
    DispatchQueue.main.async {
      self.indicator.stopAnimating()
      self.showAlert(message: message, title: Titles.error.rawValue)
    }
  }
  
  func showAlert(message: String) {
    guard let indexPath = indexPath else { return }
    DispatchQueue.main.async {
      self.indicator.stopAnimating()
      self.showAlert(message: message, title: Titles.posted.rawValue)
      self.tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(systemName: "star.fill")
      self.tableView.reloadData()
    }
  }
  
  func getPokemons(with pokemons: [String]) {
    self.pokemons = pokemons
    
    DispatchQueue.main.async {
      self.indicator.stopAnimating()
      self.tableView.reloadData()
    }
  }
  
  func setButtonsVisibility(currentPage: Int, pages: Int) {
    DispatchQueue.main.async {
      self.nextButton.isEnabled = currentPage < pages
      self.previousButton.isEnabled = currentPage > 0
    }
  }
}
