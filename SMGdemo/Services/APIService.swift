//
//  APIService.swift
//  SMGdemo
//
//  Created by Vladimir Savic on 5. 6. 2025..
//

import Foundation

class APIService {
    static let shared = APIService()
    private init() {}
    
    private let baseURL = Constants.shared.baseUrl
    
    func fetchPosts() async throws -> [Post] {
        guard let url = URL(string: "\(baseURL)/posts") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Post].self, from: data)
    }
    
    func fetchComments(for postId: Int) async throws -> [Comment] {
        guard let url = URL(string: "\(baseURL)/comments") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Comment].self, from: data)
    }
    
    func fetchPost(id: Int) async throws -> Post {
        guard let url = URL(string: "\(baseURL)/posts/\(id)") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(Post.self, from: data)
    }
    
    func createPost(title: String, body: String, userId: Int) async throws -> Post {
        guard let url = URL(string: "\(baseURL)/posts/") else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let post = Post(id: 0, userId: userId, title: title, body: body)
        request.httpBody = try JSONEncoder().encode(post)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(Post.self, from: data)
    }
}
