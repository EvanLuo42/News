//
//  ArticleListView.swift
//  News
//
//  Created by Evan Luo on 2022/2/13.
//

import SwiftUI

import SwiftUI

struct ArticleListView: View {
    
    let articles: [Article]
    @State var selectedArticle: Article?
    
    var body: some View {
        List {
            ForEach(articles) { article in
                ArticleRowView(article: article)
                    .onTapGesture {
                        self.selectedArticle = article
                    }
                    .fullScreenCover(item: $selectedArticle) { item in
                        ArticleView(article: item)
                    }
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

struct ArticleListView_Previews: PreviewProvider {
    
    @StateObject static var articleBookmarkVM = ArticleBookmarkViewModel.shared
    
    static var previews: some View {
        NavigationView {
            ArticleListView(articles: Article.previewData)
                .environmentObject(articleBookmarkVM)
        }
    }
}
