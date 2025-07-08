//
//  StoryView.swift
//  Demo
//
//  Created by MohammadHossan on 08/07/2025.
//

import SwiftUI
import RepositoryModule

public struct StoriesBarView: View {
  
  @State private var stories: [Story] = [
    Story(username: "Your Story", imageName: "", isUserStory: true),
    Story(username: "Alice", imageName: "https://images.unsplash.com/profile-1709065895933-d850a940fe3cimage?ixlib=rb-4.1.0&crop=faces&fit=crop&w=64&h=64", isUserStory: false),
    Story(username: "Bob", imageName: "https://images.unsplash.com/profile-1732310856252-1295830bb8e8image?ixlib=rb-4.1.0&crop=faces&fit=crop&w=64&h=64", isUserStory: false),
    Story(username: "Carol", imageName: "https://images.unsplash.com/profile-1644850813919-b50b3d3f0559image?ixlib=rb-4.1.0&crop=faces&fit=crop&w=64&h=64", isUserStory: false),
    
    Story(username: "David", imageName: "https://images.unsplash.com/profile-1644850813919-b50b3d3f0559image?ixlib=rb-4.1.0&crop=faces&fit=crop&w=64&h=64", isUserStory: false)
  ]
  
  @State private var isShowingImagePicker = false
  @State private var pickedImage: UIImage? = nil
  @State private var selectedStory: Story? = nil
  
  public init() { }
  
  public var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 16) {
        ForEach(stories) { story in
          StoryView(story: story)
            .onTapGesture {
              if story.isUserStory {
                isShowingImagePicker = true
              } else {
                selectedStory = story
              }
            }
        }
      }
      .padding(.horizontal, 8)
      .sheet(isPresented: $isShowingImagePicker) {
        ImagePicker(selectedImage: $pickedImage)
      }
      .sheet(item: $selectedStory) { story in
        StoryFullScreenView(imageUrl: story.imageName)
      }
      .onChange(of: pickedImage) { _, _ in
        guard let image = pickedImage else { return }
        addUserStoryImage(image)
      }
    }
  }
  
  private func addUserStoryImage(_ image: UIImage) {
    if let data = image.jpegData(compressionQuality: 0.8) {
      let base64String = data.base64EncodedString()
      let dataURL = "data:image/jpeg;base64,\(base64String)"
      
      if let index = stories.firstIndex(where: { $0.isUserStory }) {
        stories[index] = Story(username: "Your Story", imageName: dataURL, isUserStory: true)
      } else {
        stories.insert(Story(username: "Your Story", imageName: dataURL, isUserStory: true), at: 0)
      }
    }
  }
}
