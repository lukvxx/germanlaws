//
//  Models.swift
//  germanlaws
//
//  Created by Lukas Deward on 05.12.22.
//

import SwiftUI


struct LawBooks: Codable, Hashable {
    var results: Array<LawBook>
}

struct LawBook: Codable, Hashable, Equatable {
    var id: Int
    var title: String
    var code: String
    var slug: String
    var latest: Bool
}


struct LawBookSpecific: Codable, Hashable {
    var results: Array<Article>
}

struct Law: Codable, Hashable {
    var id: String
    var firstPublished: String
    var sourceTimestamp: String
    var titleLong: String
    var abbreviation: String
    var contents: Array<Article>
}

struct Article: Codable, Hashable, Equatable {
    var id: Int
    var slug: String
    var title: String
    var content: String
    var section: String
}


