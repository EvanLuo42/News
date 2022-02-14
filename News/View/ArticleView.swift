//
//  ArticleView.swift
//  News
//
//  Created by Evan Luo on 2022/2/13.
//

import SwiftUI

struct ArticleView: View {
    let article: Article
    @Environment(\.presentationMode) var presentationModes
    
    var body: some View {
        Button("Back") {
            self.presentationModes.wrappedValue.dismiss()
        }.padding()
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 20) {
                AsyncImage(url: article.imageURL) { phase in
                    switch phase {
                    case .empty:
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                        
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        
                    case .failure:
                        HStack {
                            Spacer()
                            Image(systemName: "photo")
                                .imageScale(.large)
                            Spacer()
                        }
                        
                        
                    @unknown default:
                        fatalError()
                    }
                }
                .frame(minHeight: 200, maxHeight: 300)
                .background(Color.gray.opacity(0.3))
                .clipped()
                
                Text(article.title)
                    .font(.headline)
                    .padding()
                
                Divider()
                
                Text((article.content ?? article.description) ?? "")
                    .padding()
                
                Spacer()
            }
        }
    }
}
