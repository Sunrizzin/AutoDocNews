//
//  NewsModel.swift
//  AutoDocNews
//
//  Created by Алексей Усанов on 02.02.2023.
//

import Foundation

@MainActor
class NewsViewModel: ObservableObject {
    @Published var news: [News] = []
    @Published var errorShow: Bool = false
    @Published var error: String = ""
    var page: Int = 1
    
    func load() async {
        let url = URL(string: "https://webapi.autodoc.ru/api/news/\(page)/15")!
        let urlSession = URLSession.shared
        do {
            let (data, _) = try await urlSession.data(from: url)
            let root = try JSONDecoder().decode(Root.self, from: data)
            self.news.append(contentsOf: root.news)
            errorShow = false
        }
        catch {
            self.error = error.localizedDescription
            errorShow = true
        }
    }
    
    func getMore() {
        page += 1
        reload()
    }
    
    func reload() {
        Task {
            await load()
        }
    }
}
