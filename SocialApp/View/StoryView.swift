//
//  SwiftUIView.swift
//  SharedUI+Extention
//
//  Created by MohammadHossan on 08/07/2025.
//
import SwiftUI
import RepositoryModule

 struct StoryView: View {
  let story: Story
  
   init(story: Story) {
    self.story = story
  }
  
   var body: some View {
    VStack {
      StoryAsyncImageView(urlString: story.imageName, height: 90, width: 90)
        .clipShape(Circle())
        .overlay(
          Circle().stroke(story.isUserStory ? Color.gray : Color.red, lineWidth: 2)
        )
      Text(story.username)
        .font(.caption)
    }
    .frame(width: 80)
  }
}

#Preview {
  StoryView(story: .mock)
}
