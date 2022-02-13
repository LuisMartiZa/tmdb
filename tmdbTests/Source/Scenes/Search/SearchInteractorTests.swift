//
//  SearchInteractorTests.swift
//  tmdbTests
//
//  Created by Luís Fernando Martínez Zarza on 13/2/22.
//

import XCTest
@testable import tmdb

class SearchInteractorTests: XCTestCase {
    var sut: SearchInteractor!
    var searchRepository: SearchRepositoryMock!
    
    override func setUp() {
        searchRepository = SearchRepositoryMock()
        sut = SearchInteractor(searchRepository)
    }
    
    func testGetSearchList_WhenTextIsEmpty_CallGetSearchList() {
        // When
        _ = sut.getSearchList(by: StringFactory.createEmptyString())
        
        // Then
        XCTAssertTrue(searchRepository.getSearchListCalled)
    }
    
    func testGetSearchList_WhenTextIsNotEmpty_CallGetSearchList() {
        // When
        _ = sut.getSearchList(by: StringFactory.createRandomString())
        
        // Then
        XCTAssertTrue(searchRepository.getSearchListCalled)
    }
    
    func testGetNextPage_WhenLastPageNotIsTheLast_CallGetNextPage() {
        // Given
        let lastPage = SearchPageFactory.getLastPageRandom()
        sut.lastPage = lastPage
        
        // When
        _ = sut.getNextPage(for: StringFactory.createRandomString())
        let hasPagesLeft = sut.shouldShowLoadingCell()
        
        // Then
        XCTAssertTrue(searchRepository.getSearchListCalled)
        XCTAssertTrue(hasPagesLeft)
    }
    
    func testGetNextPage_WhenLastPagIsTheLast_CallGetNextPage() {
        // Given
        let lastPage = SearchPageFactory.getLastPageForLastElement()
        sut.lastPage = lastPage
        
        // When
        _ = sut.getNextPage(for: StringFactory.createRandomString())
        let hasPagesLeft = sut.shouldShowLoadingCell()
        
        // Then
        XCTAssertFalse(searchRepository.getSearchListCalled)
        XCTAssertFalse(hasPagesLeft)
    }
}
