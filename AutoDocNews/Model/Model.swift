//
//  Model.swift
//  AutoDocNews
//
//  Created by Алексей Усанов on 02.02.2023.
//

import Foundation
import SwiftUI

struct Root: Codable {
    var news: [News]
    var totalCount: Int
}

struct News: Codable, Identifiable {
    var id: Int
    var title: String
    var description: String
    var publishedDate: String
    var url: String
    var fullUrl: String
    var titleImageUrl: String?
    var categoryType: String
}
