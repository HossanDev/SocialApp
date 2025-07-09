//
//  FlowCoordinator.swift
//  SocialApp
//
//  Created by MohammadHossan on 09/07/2025.
//

import Foundation
import SwiftUI
import RepositoryModule

final class FlowCoordinator: ObservableObject {
  @Published var path = NavigationPath()
  
  func pushDetails(feed: FeedElement) {
    path.append(feed)
  }
  
  func pop() {
    if !path.isEmpty {
      path.removeLast()
    }
  }
}

