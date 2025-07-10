//
//  DetailsHeaderView.swift
//  SocialApp
//
//  Created by MohammadHossan on 09/07/2025.
//

import SwiftUI
import RepositoryModule
import SharedUI
import ModelModule

struct DetailsHeaderView: View {
  let feedElement: FeedElement
  let profileImageSize: CGFloat

  var body: some View {
    VStack(spacing: 12) {
      
      if let urlString = feedElement.user?.profileImage.large ?? feedElement.user?.profileImage.medium,
         let url = URL(string: urlString) {
        
        FeedAsyncImageView(url: url)
          .scaledToFill()
          .frame(width: profileImageSize, height: profileImageSize)
          .clipShape(Circle())
        
      } else {
        Image(systemName: "person.circle.fill")
          .resizable()
          .scaledToFill()
          .frame(width: profileImageSize, height: profileImageSize)
          .clipShape(Circle())
          .foregroundColor(.gray)
      }
      
      VStack(alignment: .leading, spacing: 8) {
        if let user = feedElement.user {
          Text("Username: \(user.instagramUsername ?? "Unknown")")
            .font(.headline)
            .fontWeight(.semibold)
            .padding(.horizontal)
          
          HStack(spacing: 10) {
            Text("Firstname: \(user.firstName)")
            Text("Likes: \(user.totalLikes)")
            Text("Photos: \(user.totalPhotos)")
            Text("Collections: \(user.totalCollections)")
          }
          .font(.caption)
          .fontWeight(.bold)
          .padding(.horizontal)
          .padding(.top ,10)
          .lineLimit(1)
          
          Text("BIO: \(user.bio ?? "Unknown")")
            .font(.footnote)
            .padding(.horizontal)
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.top, 10)
    }
    .frame(maxWidth: .infinity)
    .padding(.top, 20)
  }
}

#Preview {
  DetailsHeaderView(feedElement: .mock, profileImageSize: 150)
}
