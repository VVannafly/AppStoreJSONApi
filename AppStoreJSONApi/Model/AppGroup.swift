//
//  AppGroup.swift
//  AppStoreJSONApi
//
//  Created by Dmitriy Chernov on 11.02.2021.
//

import Foundation

struct AppGroup: Codable {
    let feed: Feed
}

struct Feed: Codable {
    let title: String
    let results: [FeedResult]
}

struct FeedResult: Codable {
    let id: String
    let artistName: String
    let name: String
    let artworkUrl100: String
}
