

import SwiftUI
import ModelModule

struct CommentsView: View {
  @Binding var isPresented: Bool
  @State private var commentText = ""

  // Sample comments data
  let comments = [
    Comment(username: "averyk_124", text: "So many people showed up to watch me perform this weekend. I am so grateful for your support! #wow", time: "5h", likes: 0),
    Comment(username: "petrichorate", text: "SO GOOD! So many props haha 😍 Can't wait to see another show", time: "1h", likes: 1),
    Comment(username: "photosbyean", text: "what the heck! I didn't know you were a musician. So cool, invite me next time pls", time: "5h", likes: 1),
    Comment(username: "elaineforster892", text: "wut I am so confused right now :0 what is happening", time: "1h", likes: 2),
    Comment(username: "stephchon", text: "lol this looks fun! you gotta post some stories about it", time: "1h", likes: 1),
    Comment(username: "eloears", text: "Congrats!! The show looked awesome", time: "5h", likes: 0),
    Comment(username: "cheryl.art.sketch", text: "the lighting looks super nice", time: "5h", likes: 0),
  ]

  var body: some View {
    ZStack {
      Color.black.opacity(0.3)
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
          withAnimation {
            isPresented = false
          }
        }

      VStack(spacing: 0) {
        Spacer()

        VStack(spacing: 0) {
          // Header
          HStack {
            Text("Comments")
              .font(.headline)
              .padding()

            Spacer()

            Button(action: {
              withAnimation {
                isPresented = false
              }
            }) {
              Image(systemName: "xmark")
                .font(.headline)
                .padding()
            }
          }

          Divider()

          // Comments List
          ScrollView {
            VStack(alignment: .leading, spacing: 16) {
              ForEach(comments) { comment in
                HStack(alignment: .top, spacing: 12) {
                  Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.gray)

                  VStack(alignment: .leading, spacing: 4) {
                    Text("\(comment.username)")
                      .fontWeight(.semibold) +
                    Text(" \(comment.text)")

                    HStack(spacing: 16) {
                      Text(comment.time)
                      if comment.likes > 0 {
                        Text("\(comment.likes) likes")
                      }
                      Text("Reply")
                    }
                    .font(.caption)
                    .foregroundColor(.gray)
                  }

                  Spacer()

                  Image(systemName: "heart")
                    .foregroundColor(.gray)
                }
                .padding(.horizontal)
              }
            }
            .padding(.top)
          }

          Divider()

          // Emoji Reaction Bar
          ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
              ForEach(["😍", "❤️", "🔥", "⚡️", "💜", "🖤", "🎉"], id: \.self) { emoji in
                Text(emoji)
                  .font(.largeTitle)
              }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
          }

          Divider()

          // Input Bar
          HStack(spacing: 12) {
            Image(systemName: "person.circle.fill")
              .resizable()
              .frame(width: 36, height: 36)
              .foregroundColor(.gray)

            TextField("Add a comment...", text: $commentText)
              .textFieldStyle(PlainTextFieldStyle())

            Button(action: {
              print("Post comment: \(commentText)")
              commentText = ""
            }) {
              Text("Post")
                .foregroundColor(commentText.isEmpty ? .gray : .blue)
            }
          }
          .padding(.horizontal)
          .padding(.vertical, 8)
        }
        .background(Color.white)
        .cornerRadius(16, corners: [.topLeft, .topRight])
      }
      .transition(.move(edge: .bottom))
      .animation(.easeInOut, value: isPresented)
    }
  }
}
#Preview {
  CommentsViewPreviewWrapper()
}

struct CommentsViewPreviewWrapper: View {
  @State private var showComments = true

  var body: some View {
    CommentsView(isPresented: $showComments)
  }
}
