//
//  PostListView.swift
//  SMGdemo
//
//  Created by Vladimir Savic on 5. 6. 2025..
//

import SwiftUI

struct PostListView: View {
    @StateObject private var viewModel = PostListsViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.errorMessage {
                    Text(error).foregroundColor(.red)
                } else {
                    List(viewModel.posts, id: \.id) { post in
                        NavigationLink(destination: PostDetailsView(postId: post.id)) {
                            VStack(alignment: .leading) {
                                Text(post.title)
                                    .font(.headline)
                                Text(post.body)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .lineLimit(2)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
            .navigationTitle("Posts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: CreatePostView()) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .task {
            await viewModel.loadPosts()
        }
    }
}

#Preview {
    PostListView()
}
