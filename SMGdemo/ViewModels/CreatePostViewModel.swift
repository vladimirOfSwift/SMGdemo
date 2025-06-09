//
//  CreatePostViewModel.swift
//  SMGdemo
//
//  Created by Vladimir Savic on 9. 6. 2025..
//

import Foundation

@MainActor
class CreatePostViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var body: String = ""
    @Published var isSubmitting = false
    @Published var errorMessage: String? = nil
    
    var isEmpty: Bool {
        title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            body.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func createPost() async -> Post? {
        isSubmitting = true
        errorMessage = nil
        
        do {
            let post = try await APIService.shared.createPost(title: title, body: body, userId: 1)
            isSubmitting = false
            return post
        } catch {
            errorMessage = "Failed to submit post: \(error.localizedDescription)"
            isSubmitting = false
            return nil
        }
    }
}
