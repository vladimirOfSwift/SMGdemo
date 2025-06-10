//
//  PostListsViewModel.swift
//  SMGdemo
//
//  Created by Vladimir Savic on 5. 6. 2025..
//

import Foundation

@MainActor
class PostListsViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    private let localPostsKey = "LocalPosts"
    
    func loadPosts() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let apiPosts = try await APIService.shared.fetchPosts()
            posts = apiPosts
        } catch {
            errorMessage = "Failed to load posts: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func addPost(_ post: Post) {
        posts.insert(post, at: 0)
    }
    
    func deletePost(at offsets: IndexSet) {
        posts.remove(atOffsets: offsets)
    }
}
