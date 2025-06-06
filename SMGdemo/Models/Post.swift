//
//  Post.swift
//  SMGdemo
//
//  Created by Vladimir Savic on 5. 6. 2025..
//

import Foundation

struct Post: Identifiable, Codable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
