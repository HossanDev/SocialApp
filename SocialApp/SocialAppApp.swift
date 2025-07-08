//
//  SocialAppApp.swift
//  SocialApp
//
//  Created by MohammadHossan on 08/07/2025.
//

import SwiftUI
import NetworkModule
import RepositoryModule

@main
struct SocialAppApp: App {
  var body: some Scene {
    WindowGroup {
      FeedView(viewModel: FeedListViewModel(repository: FeedRepository(networkService: NetworkManager())))
    }
  }
}
