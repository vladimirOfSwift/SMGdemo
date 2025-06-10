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
    @State private var showSuccessToast = false
    
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
                            showSuccessToast = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                dismiss()
                            }
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
        .overlay(
            Group {
                if showSuccessToast {
                    Text("Post has been submitted and saved temporarily on your iPhone.")
                        .padding()
                        .background(Color.green.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(24)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .animation(.easeInOut,  value: showSuccessToast)
                }
            },
            alignment: .bottom
        )
    }
}

//#Preview {
//    CreatePostView()
//}
