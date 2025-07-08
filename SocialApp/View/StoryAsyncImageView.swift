//
//  SwiftUIView.swift
//  SharedUI+Extention
//
//  Created by MohammadHossan on 08/07/2025.
//
import SwiftUI
import SharedUI

public struct StoryAsyncImageView: View {
  let urlString: String
  var height: CGFloat?
  var width: CGFloat?
  
  public init(urlString: String, height: CGFloat? = nil, width: CGFloat? = nil) {
    self.urlString = urlString
    self.height = height
    self.width = width
  }
  
  var uiImage: UIImage? {
    if urlString.starts(with: "data:image") {
      guard let commaIndex = urlString.firstIndex(of: ",") else { return nil }
      let base64String = String(urlString[urlString.index(after: commaIndex)...])
      if let data = Data(base64Encoded: base64String) {
        return UIImage(data: data)
      }
      return nil
    }
    return nil
  }
  
  public var body: some View {
    if let image = uiImage {
      Image(uiImage: image)
        .resizable()
        .scaledToFill()
        .frame(width: width, height: height ?? 250)
        .clipped()
        .cornerRadius(12)
    } else if let url = URL(string: urlString) {
      CacheAsyncImage(url: url) { phase in
        switch phase {
        case .success(let image):
          image
            .resizable()
            .scaledToFill()
            .frame(width: width, height: height ?? 250)
            .clipped()
            .cornerRadius(12)
        case .failure:
          Image(systemName: "camera.fill")
            .resizable()
            .scaledToFit()
            .frame(width: width ?? 100, height: height ?? 250)
            .foregroundColor(.gray)
            .background(Color.gray.opacity(0.1))
            .clipped()
            .cornerRadius(12)
        case .empty:
          ZStack {
            Color.gray.opacity(0.1)
            ProgressView()
          }
          .frame(width: width, height: height ?? 250)
          .cornerRadius(12)
        @unknown default:
          EmptyView()
        }
      }
    } else {
      Image(systemName: "camera.fill")
        .resizable()
        .scaledToFit()
        .frame(width: width ?? 100, height: height ?? 250)
        .foregroundColor(.gray)
        .background(Color.gray.opacity(0.1))
        .clipped()
        .cornerRadius(12)
    }
  }
}
