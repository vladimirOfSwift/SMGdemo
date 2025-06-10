//
//  Constants.swift
//  SMGdemo
//
//  Created by Vladimir Savic on 10. 6. 2025..
//

struct Constants {
    static let shared = Constants()
    
    private init() {}
    
    let baseUrl = "https://jsonplaceholder.typicode.com"
    let imagesUrl = "https://picsum.photos/600/200"
    let successfulMessage = "Post has been submitted and saved temporarily on your iPhone."
}
