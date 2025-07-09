//
//  DetailsHeaderView.swift
//  SocialApp
//
//  Created by MohammadHossan on 09/07/2025.
//

import SwiftUI
import RepositoryModule
import SharedUI

struct DetailsHeaderView: View {
  let feedElement: FeedElement
  let profileImageSize: CGFloat

  var body: some View {
    VStack(spacing: 12) {
      
      // Profile Image centered horizontally
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
      
      // Username aligned to leading (left)
      if let user = feedElement.user {
        Text("Username: \(user.instagramUsername ?? "Unknown")")
          .font(.headline)
          .fontWeight(.semibold)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.horizontal)

        
        Text("Firstname: \(user.firstName)")
          .font(.footnote)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.horizontal)
        
        Text("Likes: \(user.totalLikes)")
          .font(.footnote)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.horizontal)
        
        Text("Photos: \(user.totalPhotos)")
          .font(.footnote)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.horizontal)
        
        Text("Collections: \(user.totalCollections)")
          .font(.footnote)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.horizontal)
        
        Text("BIO: \(user.bio ?? "Unknown")")
          .font(.footnote)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.horizontal)
        
      }
    }
    .frame(maxWidth: .infinity)
    .padding(.top, 20)
  }
}


#Preview {
  DetailsHeaderView(feedElement: .mock, profileImageSize: 150)
}
