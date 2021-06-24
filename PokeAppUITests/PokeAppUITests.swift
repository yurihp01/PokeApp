//
//  PokeAppUITests.swift
//  PokeAppUITests
//
//  Created by Yuri Pedroso on 19/06/21.
//

import XCTest

class PokeAppUITests: XCTestCase {

  // MARK: - Variable
  
  let app = XCUIApplication()
  
  // MARK: - Functions
  
  override func setUpWithError() throws {
      app.launch()
      continueAfterFailure = false
  }
  
  func testSearchPokemonIsEmpty() throws {
    let searchfield = app.searchFields.element(boundBy: 0)
    app.keyboards.buttons[Constants.finishButton].tap()
    
    XCTAssertTrue(app.staticTexts[Constants.emptyFieldError].exists, "Search button should shows a dialog with error message")
      
      app.buttons[Constants.okButton].tap()
      XCTAssertTrue(searchfield.title.isEmpty, "Search textfield should be empty")
  }
  
  func testPokemonsNotFound() throws {
    let searchfield = app.searchFields.element(boundBy: 0)
    searchfield.typeText("Abb")
    
    app.keyboards.buttons[Constants.finishButton].tap()
    
    XCTAssertTrue(app.staticTexts[Constants.notFoundError].waitForExistence(timeout: 10), "Search button should shows a dialog with error message")
      
    app.buttons[Constants.okButton].tap()
    XCTAssertTrue(searchfield.title.isEmpty, "Search textfield should be empty")
  }

  func testSearchPokemon() {
    XCUIDevice.shared.orientation = .portrait
    searchPokemon(pokemon: "Palkia")
    XCUIDevice.shared.orientation = .landscapeRight
    searchPokemon(pokemon: "Arceus")
    XCUIDevice.shared.orientation = .portrait
  }
  
  func testCheckPokemonDetailsLabelRotatingScreen() {
    searchPokemon(pokemon: "Palkia")
    
    app.buttons[Constants.detailsButton].tap()
    
    let labelExists = app.staticTexts["Height: 42"].exists
    XCTAssertTrue(labelExists, "Label Height should exists.")
    
    XCUIDevice.shared.orientation = .landscapeRight
    
    XCTAssertTrue(labelExists, "Label Height should exists.")
    
    XCUIDevice.shared.orientation = .portrait

  }
  
  private func searchPokemon(pokemon: String) {
    var imageValue = ""
    
    XCTAssertTrue(imageValue == "", "Image value should be empty.")
    XCTAssertFalse(app.staticTexts[pokemon].exists, "Pokemon Name should not exists.")
    
    let searchField = app.searchFields.element(boundBy: 0)
    searchField.tap()
    searchField.typeText(pokemon)
  
    app.keyboards.buttons[Constants.finishButton].tap()
    app.toolbars.buttons[Constants.doneButton].tap()
    
    let hasDetailsButton = app.buttons.staticTexts[Constants.detailsButton].exists
    
    imageValue = app.images.firstMatch.value as? String ?? ""
    
    XCTAssertTrue(hasDetailsButton, "Details button should appears")
    XCTAssertEqual(app.staticTexts[pokemon].label, pokemon, "Pokemon Name should appears.")
    XCTAssertTrue(imageValue == Constants.imageInserted, "Image value should be inserted")
  }
}
