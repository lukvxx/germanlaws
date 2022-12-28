//
//  News.swift
//  germanlaws
//
//  Created by Lukas Deward on 28.11.22.
//

import SwiftUI

struct SavedView: View {
    @StateObject var viewModel = SavedModel()
    @State var searchText : String = ""
    var app: LawAppModel
    
    var body: some View {
        NavigationStack() {
            HStack {
                if articles.count == 0 {
                    Text("Es wurden keine Paragraphen gespeichert.")
                } else {
                    List(articles, id: \.id){ article in
                            NavigationLink(article.title) {
                                ParagraphView(article: article)
                            }.swipeActions {
                                Button("Entfernen") {
                                    viewModel.removeParagraph(p: article)
                                    viewModel.getParagraphs()
                                }
                                .tint(.red)
                            }
                    }
                }
            }
            .navigationTitle("Gespeichert")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .onAppear {
                viewModel.getParagraphs()
            }
        }
    }
    
    var articles: [Article] {
        //viewModel.fetchData(id: id)
        return viewModel.savedParagraphs.filter {
            let _title = $0.title
            if (searchText == "") {
                return true
            }
            return _title.lowercased().contains(searchText.lowercased()) || $0.title.lowercased().contains(searchText.lowercased())
        }
    }

    
    init(app: LawAppModel) {
        self.app = app
    }
}

