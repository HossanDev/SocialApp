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
    VStack(alignment: .leading, spacing: 12) {
      HStack(alignment: .center, spacing: 20) {

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
        if let user = feedElement.user {
          HStack(spacing: 30) {
            VStack {
              Text("Likes")
                .font(.caption)
              
              Text("\(user.totalLikes)")
                .font(.headline)
                .fontWeight(.bold)
              
            }
            VStack {
              
              Text("Photos")
                .font(.caption)
              
              Text("\(user.totalPhotos)")
                .font(.headline)
                .fontWeight(.bold)
              
            }
            VStack {
              
              Text("Collections")
                .font(.caption)
              
              Text("\(user.totalCollections)")
                .font(.headline)
                .fontWeight(.bold)
            }
          }
        }
      }
      .padding(.horizontal)

      if let user = feedElement.user {
        Text("Username: \(user.instagramUsername ?? "Unknown")")
          .font(.headline)
          .fontWeight(.semibold)
          .padding(.horizontal)

        Text("BIO: \(user.bio ?? "Unknown")")
          .font(.footnote)
          .padding(.horizontal)
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.top, 20)
  }
}


#Preview {
  DetailsHeaderView(feedElement: .mock, profileImageSize: 150)
}
