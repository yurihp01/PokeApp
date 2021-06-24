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
  var indexPath = IndexPath()
  
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
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    indicator.center = view.center
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
    cell.imageView?.image = nil
    
    viewModel?.setImage(indexPath: indexPath, completion: {
      cell.imageView?.image = UIImage(systemName: "star.fill")
    })
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    indicator.startAnimating()
    viewModel?.postPokemon(with: pokemons[indexPath.row])
    viewModel?.addBookmarkedPokemon(indexPath: indexPath)
    self.indexPath = indexPath
  }
}

// MARK: - PokemonsListViewProtocol

extension PokemonsListViewController: PokemonsListViewProtocol {
  func showError(message: String?) {
    performUIUpdate {
      self.indicator.stopAnimating()
      self.showAlert(message: message, title: Titles.error.rawValue)
    }
  }
  
  func showAlert(message: String) {
    performUIUpdate {
      self.indicator.stopAnimating()
      self.showAlert(message: message, title: Titles.posted.rawValue)
      self.tableView.cellForRow(at: self.indexPath)?.imageView?.image = UIImage(systemName: "star.fill")
      self.tableView.reloadData()
    }
  }
  
  func getPokemons(with pokemons: [String]) {
    performUIUpdate {
      self.pokemons = pokemons
      self.indicator.stopAnimating()
      self.tableView.reloadData()
    }
  }
  
  func setButtonsVisibility() {
    performUIUpdate {
      guard let viewModel = self.viewModel else { return }
      
      self.nextButton.backgroundColor = viewModel.setColor(isNextButton: true)
      self.nextButton.isEnabled = viewModel.setEnabled(isNextButton: true)
      self.previousButton.isEnabled = viewModel.setEnabled(isNextButton: false)
      self.previousButton.backgroundColor = viewModel.setColor(isNextButton: false)
      self.tableView.reloadData()
    }
  }
}
