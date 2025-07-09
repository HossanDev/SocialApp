//
//  MockFeedRepository.swift
//  SocialAppTests
//
//  Created by MohammadHossan on 09/07/2025.
//

import Foundation
import RepositoryModule
@testable import SocialApp

class MockFeedRepository: FeedRepositoryProtocol {
  func fetchFeed(from urlString: String) async throws -> [FeedElement] {
    let bundle = Bundle(for: MockFeedRepository.self)
    guard let url = bundle.url(forResource: "FeedData", withExtension: "json") else {
      throw RepositoryError.invalidURL("FeedData.json not found")
    }

    let data = try Data(contentsOf: url)
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    let result = try decoder.decode([FeedElement].self, from: data)
    return result
  }
}
