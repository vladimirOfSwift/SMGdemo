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
    
    func loadPosts() async {
        isLoading = true
        errorMessage = nil
        
        do {
            posts = try await APIService.shared.fetchPosts()
        } catch {
            errorMessage = "Failed to load posts: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
