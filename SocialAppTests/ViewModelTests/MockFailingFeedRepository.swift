//
//  MockFailingProductRepository.swift
//  SocialAppTests
//
//  Created by MohammadHossan on 09/07/2025.
//
import Foundation
import RepositoryModule
import ModelModule
@testable import SocialApp

class MockFailingFeedRepository: FeedRepositoryProtocol {
  func fetchFeed(from urlString: String) async throws -> [FeedElement] {
    throw RepositoryError.requestFailed(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Network failure"]))
  }
}

