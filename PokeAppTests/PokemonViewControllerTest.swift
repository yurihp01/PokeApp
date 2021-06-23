//
//  PokemonViewControllerTest.swift
//  PokeAppTests
//
//  Created by Yuri Pedroso on 22/06/21.
//

import XCTest
@testable import PokeApp

class PokemonViewControllerTest: XCTestCase {

  // MARK: - Variable
  
  var sut: PokemonViewController!
  
  // MARK: - Functions
  
  override func setUpWithError() throws {
    sut = PokemonViewController.instatiate(storyboardName: .pokemon)
    sut.viewDidLoad()
  }

  override func tearDownWithError() throws {
      sut = nil
  }
  
  func testSetSearchBar() {
    sut.searchBar.searchTextField.backgroundColor = .none
    
    XCTAssertNotEqual(sut.searchBar.searchTextField.backgroundColor, .white, "Search Bar background should not be white.")
    
    sut.setSearchBar()
    
    XCTAssertEqual(sut.searchBar.searchTextField.backgroundColor, .white, "Search Bar background should be white.")
  }
  
  func testMakeImageRounded() {
    sut.imageView.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    sut.imageView.clipsToBounds = false
    
    XCTAssertFalse(sut.imageView.layer.borderColor == #colorLiteral(red: 0.2355829477, green: 0.5289153457, blue: 0.998261869, alpha: 1), "Border color should be white")
    XCTAssertFalse(sut.imageView.clipsToBounds, "Clips to bounds should be false")
    
    sut.imageView.makeRounded()
    
    XCTAssertTrue(sut.imageView.layer.borderColor == #colorLiteral(red: 0.2355829477, green: 0.5289153457, blue: 0.998261869, alpha: 1), "Border color should be blue")
    XCTAssertTrue(sut.imageView.clipsToBounds, "Clips to bounds should be true")
  }

  func testGetPokemon() {
    let name = "Palkia"
    let image = "arceus.org"

    sut.imageView.image = UIImage()
    sut.label.text = ""

    XCTAssertTrue(sut.label.text?.isEmpty ?? false, "Label should be empty.")
    XCTAssertEqual(sut.imageView.image, UIImage(), "ImageView should be empty")

    sut.getPokemon(name: name, image: URL(fileURLWithPath: image))

    XCTAssertTrue(sut.label.text == name, "Label should be \(name).")
    XCTAssertNotEqual(sut.imageView.image, UIImage(), "ImageView should not be empty")
  }
}
