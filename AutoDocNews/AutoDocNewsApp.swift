//
//  AutoDocNewsApp.swift
//  AutoDocNews
//
//  Created by Алексей Усанов on 02.02.2023.
//

import SwiftUI

@main
struct AutoDocNewsApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(NewsViewModel())
        }
    }
}
