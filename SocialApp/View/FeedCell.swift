//
//  FeedCell.swift
//  InstagramDemo
//
//  Created by MohammadHossan on 07/07/2025.
//

import SwiftUI
import SharedUI
import RepositoryModule

struct FeedCell: View {
  let feedElement: FeedElement
  
  private let profileImageSize: CGFloat = 50
  private let horizontalPadding: CGFloat = 10
  private let verticalSpacing: CGFloat = 15
  private let buttonSpacing: CGFloat = 16
  
  var body: some View {
    VStack(alignment: .leading, spacing: verticalSpacing) {
      ProfileHeaderView(
        feedElement: feedElement,
        profileImageSize: 50
      )
      .padding(.horizontal, horizontalPadding)
      
      FeedImageView(feedElement: feedElement)
      
      ActionButtonsView(spacing: buttonSpacing)
        .padding(.horizontal, horizontalPadding)
        .padding(.top, 4)
        .foregroundStyle(.black)
      
      LikesView(likes: feedElement.likes ?? 0)
        .padding(.horizontal, horizontalPadding)
      
      CaptionView(caption: feedElement.altDescription)
        .padding(.horizontal, horizontalPadding)
      
      CreatedAtView(dateString: feedElement.createdAt)
        .padding(.horizontal, horizontalPadding)
    }
    .padding(.vertical, verticalSpacing)
  }
}

#Preview {
  FeedCell(feedElement: .mock)
}
