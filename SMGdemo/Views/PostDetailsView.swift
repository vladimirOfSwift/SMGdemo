//
//  PostDetailsView.swift
//  SMGdemo
//
//  Created by Vladimir Savic on 5. 6. 2025..
//

import SwiftUI

struct PostDetailsView: View {
    let postId: Int
    
    @State private var post: Post?
    @State private var comments: [Comment] = []
    @State private var isLoading = true
    @State private var errorMessage: String?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if isLoading {
                    ProgressView("Loading...")
                } else if let error = errorMessage {
                    Text(error).foregroundColor(.red)
                } else if let post = post {
                    AsyncImage(url: URL(string: Constants.shared.imagesUrl)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.gray.frame(height: 200)
                    }
                    
                    Text(post.title)
                        .font(.title)
                        .bold()
                    
                    Text(post.body)
                        .font(.body)
                    
                    Divider()
                    
                    Text("Comments")
                        .font(.headline)
                    
                    ForEach(comments.prefix(3), id: \.id) { comment in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(comment.name)
                                .font(.subheadline)
                                .bold()
                            Text(comment.body)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Post Details")
        .task {
            await loadData()
        }
    }
    
    private func loadData() async {
        do {
            async let fetchedPost = APIService.shared.fetchPost(id: postId)
            async let fetchedComments = APIService.shared.fetchComments(for: postId)
            
            (post, comments) = try await (fetchedPost, fetchedComments)
            isLoading = false
        } catch {
            errorMessage = "Failed to load data: \(error.localizedDescription) The data was not saved on the server."
            isLoading = false
        }
    }
    
}

#Preview {
    PostDetailsView(postId: 1)
}

