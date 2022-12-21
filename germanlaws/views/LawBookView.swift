//
//  LawBookView.swift
//  germanlaws
//
//  Created by Lukas Deward on 01.12.22.
//

import SwiftUI

struct LawBookView: View {
    var id: Int
    var title: String
    var app: LawAppModel
    
    @StateObject var viewModel = LawBookModel()
    var paragraphModel = ParagraphModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            HStack {
                if articles.count == 0 {
                    ProgressView().progressViewStyle(CircularProgressViewStyle())
                } else {
                    List(articles, id: \.id) { article in
                        NavigationLink(article.section + " " + article.title) {
                                ParagraphView(article: article)
                            }.swipeActions {
                                if (paragraphModel.isParagraphSaved(p: article)) {
                                    Button("Entfernen") {
                                        viewModel.fetchData(id: id)
                                        paragraphModel.removeParagraph(p: article)
                                    }
                                    .tint(.red)
                                } else {
                                    Button("Speichern") {
                                        viewModel.fetchData(id: id)
                                        paragraphModel.addParagraph(newParagraph: article)
                                    }
                                    .tint(.green)
                                }
                            }
                        
                    }.refreshable {
                        viewModel.fetchData(id: id)
                    }
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        }
        .navigationTitle(title)
        .onAppear {
            viewModel.fetchData(id: id)
        }
    }
    
    
    var articles: [Article] {
        return viewModel.law.results.filter {
            let _title = $0.title
            if (searchText == "") {
                return true
            }
            return _title.lowercased().contains(searchText.lowercased()) || $0.slug.lowercased().contains(searchText.lowercased())
        }
    }

    
    init(app: LawAppModel, id: Int, title: String) {
        self.app = app
        self.id = id
        self.title = title
    }
}

