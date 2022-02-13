//
//  NewsApp.swift
//  News
//
//  Created by Evan Luo on 2022/2/13.
//

import SwiftUI

@main
struct NewsApp: App {
    @StateObject var articleBookmarkVM = ArticleBookmarkViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(articleBookmarkVM)
        }
    }
}
