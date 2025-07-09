//
//  FeedViewModel.swift
//  Demo
//
//  Created by MohammadHossan on 07/07/2025.
//

import Foundation
import RepositoryModule
import NetworkModule

enum ViewState {
  case loading
  case error
  case loaded
  case loadingMore
}

protocol FeedListViewModelAction: ObservableObject {
  func getFeedList() async
  func loadMoreFeed() async
}

@MainActor
final class FeedListViewModel: ObservableObject {
  
  @Published private(set) var viewState: ViewState = .loading
  @Published var feedList: [FeedElement] = []
  
  private var currentPage = 1
  private var hasMorePages = true
  private let perPage = 10
  private let repository: FeedRepositoryProtocol
  
  init(repository: FeedRepositoryProtocol) {
    self.repository = repository
  }
  
  func getFeedList() async {
    viewState = .loading
    currentPage = 1
    hasMorePages = true
    
    do {
      let list = try await repository.fetchFeed(from: EndPoint.photosURL(page: currentPage, perPage: perPage))
      feedList = list
      hasMorePages = !list.isEmpty
      viewState = .loaded
    } catch {
      viewState = .error
      print(error)
    }
  }
  
  func loadMoreFeed() async {
    
    guard hasMorePages else { return }
    viewState = .loadingMore
    
    do {
      let nextPage = currentPage + 1
      let nextList = try await repository.fetchFeed(from: EndPoint.photosURL(page: nextPage, perPage: perPage))
      feedList.append(contentsOf: nextList)
      hasMorePages = !nextList.isEmpty
      if !nextList.isEmpty {
        currentPage = nextPage
      }
      viewState = .loaded
    } catch {
      viewState = .error
    }
  }
}
