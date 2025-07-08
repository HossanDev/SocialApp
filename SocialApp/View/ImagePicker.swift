//
//  ImagePicker.swift
//  Demo
//
//  Created by MohammadHossan on 08/07/2025.
//

import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
  @Binding var selectedImage: UIImage?
  @Environment(\.dismiss) var dismiss
  
  func makeUIViewController(context: Context) -> PHPickerViewController {
    var config = PHPickerConfiguration()
    config.filter = .images
    config.selectionLimit = 1
    
    let picker = PHPickerViewController(configuration: config)
    picker.delegate = context.coordinator
    
    return picker
  }
  
  func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  class Coordinator: NSObject, PHPickerViewControllerDelegate {
    let parent: ImagePicker
    
    init(_ parent: ImagePicker) {
      self.parent = parent
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
      guard let provider = results.first?.itemProvider else {
        parent.dismiss()
        return
      }
      if provider.canLoadObject(ofClass: UIImage.self) {
        provider.loadObject(ofClass: UIImage.self) { image, error in
          DispatchQueue.main.async {
            self.parent.selectedImage = image as? UIImage
            self.parent.dismiss()
          }
        }
      } else {
        parent.dismiss()
      }
    }
  }
}
