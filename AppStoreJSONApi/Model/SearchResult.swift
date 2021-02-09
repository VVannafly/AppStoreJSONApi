//
//  SearchResult.swift
//  AppStoreJSONApi
//
//  Created by Dmitriy Chernov on 09.02.2021.
//

import Foundation

struct SearchResult: Codable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Codable {
    let trackName: String
    let primaryGenreName: String
    var averageUserRating: Float?
//    let sreenshotUrls: [String]
    let artworkUrl100: String
}
