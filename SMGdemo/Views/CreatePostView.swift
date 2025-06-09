//
//  CreatePostView.swift
//  SMGdemo
//
//  Created by Vladimir Savic on 6. 6. 2025..
//

import SwiftUI

struct CreatePostView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel = CreatePostViewModel()
    
    var onPostCreated: ((Post) -> Void)?
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title")) {
                    TextField("Enter title", text: $viewModel.title)
                }
                
                Section(header: Text("Body")) {
                    TextEditor(text: $viewModel.body)
                        .frame(height: 150)
                }
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }
                
                Button(action: {
                    Task {
                        if let post = await viewModel.createPost() {
                            onPostCreated?(post)
                            dismiss()
                        }
                    }
                }) {
                    if viewModel.isSubmitting {
                        ProgressView()
                    } else {
                        Text("Submit Post")
                    }
                }
                .disabled(viewModel.isEmpty || viewModel.isSubmitting)
            }
            .navigationTitle("Create Post")
        }
    }
}

#Preview {
    CreatePostView()
}
