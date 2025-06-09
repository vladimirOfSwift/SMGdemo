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
            let localPosts = loadLocalPosts()
            posts = apiPosts + localPosts
        } catch {
            errorMessage = "Failed to load posts: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    func addPost(_ post: Post) {
        var savedPosts = loadLocalPosts()
        savedPosts.insert(post, at: 0)
        if let data = try? JSONEncoder().encode(savedPosts) {
            UserDefaults.standard.set(data, forKey: localPostsKey)
        }
        posts.insert(post, at: 0)
    }
    
    private func loadLocalPosts() -> [Post] {
        guard let data = UserDefaults.standard.data(forKey: localPostsKey), let posts = try? JSONDecoder().decode([Post].self, from: data) else {
            return []
        }
        return posts
    }
}
