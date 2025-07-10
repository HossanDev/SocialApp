


import SwiftUI
import SharedUI
import RepositoryModule
import ModelModule

struct FeedCell: View {
  let feedElement: FeedElement
  let onCommentsTapped: () -> Void

  private let profileImageSize: CGFloat = 50
  private let horizontalPadding: CGFloat = 10
  private let verticalSpacing: CGFloat = 15
  private let buttonSpacing: CGFloat = 16

  var body: some View {
    VStack(alignment: .leading, spacing: verticalSpacing) {
      ProfileHeaderView(
        feedElement: feedElement,
        profileImageSize: profileImageSize
      )
      .padding(.horizontal, horizontalPadding)

      FeedImageView(feedElement: feedElement)

      HStack(spacing: buttonSpacing) {
        Button(action: {
          print("heart button is tapped")
        }) {
          Image(systemName: "heart")
            .imageScale(.large)
        }

        Button(action: {
          onCommentsTapped()
        }) {
          Image(systemName: "bubble.right")
            .imageScale(.large)
        }

        Button(action: {}) {
          Image(systemName: "paperplane")
            .imageScale(.large)
        }

        Spacer()
      }
      .foregroundStyle(.black)
      .padding(.horizontal, horizontalPadding)
      .padding(.top, 4)

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
  FeedCell(feedElement: .mock, onCommentsTapped: {})
}
