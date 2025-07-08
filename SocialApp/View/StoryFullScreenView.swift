//
//  StoryFullScreenView.swift
//  Demo
//
//  Created by MohammadHossan on 08/07/2025.
//

import SwiftUI

struct StoryFullScreenView: View {
  let imageUrl: String
  @Environment(\.dismiss) var dismiss
  
   init(imageUrl: String) {
    self.imageUrl = imageUrl
  }
  
   var body: some View {
    ZStack(alignment: .topTrailing) {
      Color.black
        .ignoresSafeArea()
      
      StoryAsyncImageView(urlString: imageUrl)
        .scaledToFit()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 20)
        .padding(.vertical, 60)
      
      Button(action: {
        dismiss()
      }) {
        Image(systemName: "xmark.circle.fill")
          .resizable()
          .frame(width: 40, height: 40)
          .foregroundColor(.white)
          .padding()
      }
    }
  }
}

#Preview {
  StoryFullScreenView(imageUrl: "https://images.unsplash.com/profile-1644850813919-b50b3d3f0559image?ixlib=rb-4.1.0&crop=faces&fit=crop&w=64&h=64")
}
