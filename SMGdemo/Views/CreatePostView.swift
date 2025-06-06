//
//  CreatePostView.swift
//  SMGdemo
//
//  Created by Vladimir Savic on 6. 6. 2025..
//

import SwiftUI

struct CreatePostView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var postBody: String = ""
    @State private var isSubmitting = false
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title")) {
                    TextField("Enter title", text: $title)
                }
                
                Section(header: Text("Body")) {
                    TextEditor(text: $postBody)
                        .frame(height: 150)
                }
                
                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }
                
                Button(action: {
                    Task {
                        await createPost()
                    }
                }) {
                    if isSubmitting {
                        ProgressView()
                    } else {
                        Text("Submit Post")
                    }
                }
                .disabled(title.isEmpty || postBody.isEmpty || isSubmitting)
            }
            .navigationTitle("Create Post")
        }
    }
    
    private func createPost() async {
        isSubmitting = true
        errorMessage = nil
        
        do {
            _ = try await APIService.shared.createPost(title: title, body: postBody, userId: 1)
        } catch {
            errorMessage = "Failed to submit post: \(error.localizedDescription)"
        }
        isSubmitting = false
    }
}

#Preview {
    CreatePostView()
}
