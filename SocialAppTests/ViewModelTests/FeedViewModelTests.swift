//
//  FeedViewModelTests.swift
//  SocialAppTests
//
//  Created by MohammadHossan on 09/07/2025.
//

import XCTest
@testable import SocialApp
import RepositoryModule

@MainActor
final class FeedListViewModelTests: XCTestCase {
  
  func test_getFeedList_success() async throws {
    
    // GIVEN
    let repository = MockFeedRepository()
    let viewModel = FeedListViewModel(repository: repository)
    
    XCTAssertEqual(viewModel.viewState, .loading)
    XCTAssertTrue(viewModel.feedList.isEmpty)
    
    // WHEN
    await viewModel.getFeedList()
    
    // THEN
    XCTAssertEqual(viewModel.viewState, .loaded)
    XCTAssertFalse(viewModel.feedList.isEmpty)
    XCTAssertEqual(viewModel.feedList.first?.id, "lLenwc__YmU")
  }
  
  func test_getFeedList_failure() async throws {
    
    // GIVEN
    let repository = MockFailingFeedRepository()
    let viewModel = FeedListViewModel(repository: repository)
    
    // WHEN
    await viewModel.getFeedList()
    
    // THEN
    XCTAssertEqual(viewModel.viewState, .error)
    XCTAssertTrue(viewModel.feedList.isEmpty)
  }
  
  func test_loadMoreFeed_success() async throws {
    
    // GIVEN
    let repository = MockFeedRepository()
    let viewModel = FeedListViewModel(repository: repository)
    
    // WHEN
    await viewModel.getFeedList()
    
    let initialCount = viewModel.feedList.count
    
    await viewModel.loadMoreFeed()
    
    // THEN
    XCTAssertEqual(viewModel.viewState, .loaded)
    XCTAssertTrue(viewModel.feedList.count >= initialCount)
  }
  
  func test_loadMoreFeed_failure() async throws {
    
    // GIVEN
    let repository = MockFailingFeedRepository()
    let viewModel = FeedListViewModel(repository: repository)
    
    // WHEN
    await viewModel.getFeedList()
    await viewModel.loadMoreFeed()
    
    // THEN
    XCTAssertEqual(viewModel.viewState, .error)
  }
}
