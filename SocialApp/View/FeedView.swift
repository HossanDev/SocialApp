//
//  FeedView.swift
//  InstagramDemo
//
//  Created by MohammadHossan on 07/07/2025.
//

import SwiftUI
import RepositoryModule
import NetworkModule

struct FeedView: View {
  @StateObject var viewModel: FeedListViewModel
  @State private var isErrorOccured = true
  
  var body: some View {
    NavigationStack {
      VStack {
        StoriesBarView()
          .padding(.vertical, 8)
      }
      VStack {
        switch viewModel.viewState {
        case .loading:
          ProgressView()
          
        case .loaded, .loadingMore:
          showFeedListView()
          
        case .error:
          showErrorView()
        }
      }
      .navigationTitle("Feed")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Image("logo")
            .resizable()
            .backgroundStyle(.white)
            .frame(width: 100, height: 32)
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
          Image(systemName: "paperplane")
            .imageScale(.large)
        }
      }
    }
    .task {
      await getDataFromAPI()
    }
  }
  
  func getDataFromAPI() async {
    await viewModel.getFeedList()
  }
  
  @ViewBuilder
  func showFeedListView() -> some View {
    ScrollView {
      
      LazyVStack(spacing: 32) {
        ForEach(viewModel.feedList, id: \.self) { feed in
          FeedCell(feedElement: feed)
            .onAppear {
              if feed == viewModel.feedList.last {
                Task {
                  await viewModel.loadMoreFeed()
                }
              }
            }
        }
        if viewModel.viewState == .loadingMore {
          ProgressView()
            .padding()
        }
      }
      .padding(.top, 8)
    }
  }
  
  @ViewBuilder
  func showErrorView() -> some View {
    ProgressView()
      .alert(isPresented: $isErrorOccured) {
        Alert(
          title: Text("Error Occurred"),
          message: Text("Something went wrong"),
          dismissButton: .default(Text("Ok"))
        )
      }
  }
}

#Preview {
  FeedView(viewModel:  FeedListViewModel(repository: FeedRepository(networkService: NetworkManager())))
}
