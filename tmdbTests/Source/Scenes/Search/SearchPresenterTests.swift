//
//  SearchPresenterTests.swift
//  tmdbTests
//
//  Created by Luís Fernando Martínez Zarza on 13/2/22.
//

import XCTest
@testable import tmdb

class SearchPresenterTests: XCTestCase {

    var sut: SearchPresenter!
    var view: SearchViewMock!
    var interactor: SearchInteractorMock!
    var wireframe: SearchWireframeMock!
        
    var searchs: [SearchItem] = []
    var shouldLoadingCell = false
    var lastSearchString: String = ""
    
    override func setUp() {
        view = SearchViewMock()
        interactor = SearchInteractorMock()
        wireframe = SearchWireframeMock()
        
        sut = SearchPresenter(view: view, interactor: interactor, wireframe: wireframe)
    }
    
    func testNumberOfSections_IfSectionsIs1() {
        // Given
        let sections = 1
        // When
        let sectionsSut = sut.numberOfSections()
        // Then
        XCTAssertTrue(sections == sectionsSut)
    }
    
    func testNumberOfSections_IfSectionsAre2() {
        // Given
        let sections = 2
        // When
        let sectionsSut = sut.numberOfSections()
        // Then
        XCTAssertFalse(sections == sectionsSut)
    }
    
    func testNumberOfItems_IfItemsAre2() {
        // Given
        let items = 2
        let searchs = SearchItemFactory.getSearchItemArrayRandom(with: 2)
        // When
        sut.searchs = searchs
        let itemsSut = sut.numberOfItems(section: 1)
        // Then
        XCTAssertTrue(items == itemsSut)
    }
    
    func testSearchItem_IfRowIsIndice1() {
        // Given
        let indice = 1
        let searchs = SearchItemFactory.getSearchItemArrayRandom(with: 2)
        // When
        sut.searchs = searchs
        let searchItem = sut.searchItem(for: indice)
        // Then
        XCTAssertNotNil(searchItem)
    }
    
    func testSearchItem_IfRowIsIndice2() {
        // Given
        let indice = 2
        let searchs = SearchItemFactory.getSearchItemArrayRandom(with: indice)
        // When
        sut.searchs = searchs
        let searchItem = sut.searchItem(for: indice)
        // Then
        XCTAssertNil(searchItem)
    }
    
    func testGetLastSearch_IfLastSearchIsNotEmpty() {
        // Given
        let lastSearch = StringFactory.createRandomString()
        // When
        sut.lastSearchString = lastSearch
        let lastSearchString = sut.getLastSearch()
        // Then
        XCTAssertTrue(lastSearch == lastSearchString)
    }
    
    func testGetLastSearch_IfLastSearchIsEmpty() {
        // Given
        let lastSearch = StringFactory.createRandomString()
        let lastSearchEmpty = StringFactory.createEmptyString()
        // When
        sut.lastSearchString = lastSearchEmpty
        let lastSearchString = sut.getLastSearch()
        // Then
        XCTAssertFalse(lastSearch == lastSearchString)
    }
    
    func testDidSelect_ItRowIs1() {
        // Given
        let row = 1
        let section = 1
        let searchs = SearchItemFactory.getSearchItemArrayRandom(with: 2)
        // When
        sut.searchs = searchs
        sut.didSelect(row: row, section: section)
        // Then
        XCTAssertTrue(wireframe.presentMovieDetail)
    }
    
    func testDidSelect_ItRowIs2() {
        // Given
        let row = 2
        let section = 1
        let searchs = SearchItemFactory.getSearchItemArrayRandom(with: 2)
        // When
        sut.searchs = searchs
        sut.didSelect(row: row, section: section)
        // Then
        XCTAssertTrue(view.displayErrorCalled)
    }
    
    func testShouldShowLoadingCell_IfNotNeedShowLoadingCell() {
        // Given
        let shouldShowLoadingCell = false
        // When
        sut.shouldLoadingCell = shouldShowLoadingCell
        let shouldLoadingCellSut = sut.shouldShowLoadingCell()
        // Then
        XCTAssertTrue(shouldShowLoadingCell == shouldLoadingCellSut)
    }
    
    func testShouldShowLoadingCell_IfShowLoadingCellFails() {
        // Given
        let shouldShowLoadingCell = false
        let shouldShowLoadingCellOK = true
        // When
        sut.shouldLoadingCell = shouldShowLoadingCellOK
        let shouldLoadingCellSut = sut.shouldShowLoadingCell()
        // Then
        XCTAssertFalse(shouldShowLoadingCell == shouldLoadingCellSut)
    }
    
    func isLoadingIndexPath(_ indexPath: IndexPath){
    }
    
    func testIsLoadingIndexPath_WhenIndexPathAreEqualThatLoadingIndexPath() {
        // Given
        let indexPath = IndexPath(row: 2, section: 1)
        let searchs = SearchItemFactory.getSearchItemArrayRandom(with: 2)
        // When
        sut.searchs = searchs
        sut.shouldLoadingCell = true
        let isLoading = sut.isLoadingIndexPath(indexPath)
        // Then
        XCTAssertTrue(isLoading)
    }
    
    func testIsLoadingIndexPath_WhenIndexPathAreNotEqualThatLoadingIndexPath() {
        // Given
        let indexPath = IndexPath(row: 1, section: 1)
        let searchs = SearchItemFactory.getSearchItemArrayRandom(with: 2)
        // When
        sut.searchs = searchs
        sut.shouldLoadingCell = true
        let isLoading = sut.isLoadingIndexPath(indexPath)
        // Then
        XCTAssertFalse(isLoading)
    }
    
    func testSearch_WithRandomString() {
        // Given
        let lastSearchString = StringFactory.createRandomString()
        // When
        _ = interactor.getSearchList(by: lastSearchString)
        view.reloadData()
        
        // Then
        XCTAssertTrue(interactor.getSearchListCalled)
        XCTAssertTrue(view.reloadDataCalled)
    }
    
    func testNextPage_WithRandomString() {
        // Given
        let lastSearchString = StringFactory.createRandomString()
        // When
        _ = interactor.getNextPage(for: lastSearchString)
        view.reloadData()
        
        // Then
        XCTAssertTrue(interactor.getNextPageCalled)
        XCTAssertTrue(view.reloadDataCalled)
    }
    
    func testCleanSearch_IfSearchShouldLoadingCellAndLastSearchStringAreEmpty() {
        // Given
        searchs = []
        shouldLoadingCell = false
        lastSearchString = StringFactory.createEmptyString()
        // When
        sut.cleanSearch()
        // Then
        XCTAssertTrue(sut.searchs.count == searchs.count)
        XCTAssertTrue(sut.lastSearchString == lastSearchString)
        XCTAssertTrue(view.reloadDataCalled)
    }

}
