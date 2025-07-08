//
//  Extension.swift
//  Demo
//
//  Created by MohammadHossan on 08/07/2025.
//

import Foundation
import RepositoryModule

extension String {
  func toYearMonth() -> String {
    let isoFormatter = ISO8601DateFormatter()
    isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM"
    
    if let date = isoFormatter.date(from: self) {
      return formatter.string(from: date)
    } else {
      // fallback if fractional seconds decoding fails
      isoFormatter.formatOptions = [.withInternetDateTime]
      if let date = isoFormatter.date(from: self) {
        return formatter.string(from: date)
      }
    }
    
    return self
  }
}

public extension FeedElement {
  static let mock = FeedElement(
    id: "test_id",
    urls: Urls(
      raw: "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d",
      full: "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?crop=entropy&cs=srgb&fm=jpg&q=85",
      regular: "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=1080",
      small: "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&q=80&w=400"
    ),
    createdAt: "2024-07-07T12:00:00Z",
    altDescription: "Beautiful preview image for FeedCell",
    likes: 123,
    user: User(
      username: "testuser",
      name: "Test User",
      firstName: "Test",
      profileImage: ProfileImage(
        small: "https://randomuser.me/api/portraits/thumb/men/1.jpg",
        medium: "https://randomuser.me/api/portraits/med/men/1.jpg",
        large: "https://randomuser.me/api/portraits/men/1.jpg"
      ),
      instagramUsername: "test_insta"
    )
  )
}

public extension User {
  static let mock = User(username: "Tom", name: "@TomHope", firstName: "Tom", profileImage: ProfileImage(
    small: "https://randomuser.me/api/portraits/thumb/men/1.jpg",
    medium: "https://randomuser.me/api/portraits/med/men/1.jpg",
    large: "https://randomuser.me/api/portraits/men/1.jpg"
  ), instagramUsername: "test_insta")
}
