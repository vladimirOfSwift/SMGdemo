//
//  Comment.swift
//  SMGdemo
//
//  Created by Vladimir Savic on 5. 6. 2025..
//

struct Comment: Identifiable, Codable {
    let id: Int
    let postId: Int
    let name: String
    let email: String
    let body: String
}
