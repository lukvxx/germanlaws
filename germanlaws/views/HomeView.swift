//
//  Home.swift
//  germanlaws
//
//  Created by Lukas Deward on 28.11.22.
//

import SwiftUI



struct HomeView: View {
    var app: LawAppModel
    
    @StateObject var viewModel = HomeModel()
    
    @StateObject var savedLawBooks = SavedLawBooks()
    
    @State private var searchText = ""
    
    @State private var showLawBookSelector = false;
    
    var body: some View {
        NavigationStack() {
            HStack {
                if lawBooks.count == 0 {
                    Text("Es wurden keine Gesetzbücher gespeichert.")
                } else {
                    List(lawBooks, id: \.id){ lawbook in
                            NavigationLink(lawbook.title) {
                                LawBookView(app: app, id: lawbook.id, title: lawbook.title)
                            }.swipeActions {
                                Button("Entfernen") {
                                    savedLawBooks.removeLawBook(l: lawbook)
                                    savedLawBooks.getLawBooks()
                                }
                                .tint(.red)
                            }
                    }
                }
            }
            .navigationTitle("Gesetzbücher")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .onChange(of: showLawBookSelector) { newVar in
                savedLawBooks.getLawBooks()
            }.onAppear {
                savedLawBooks.getLawBooks()
            }.toolbar {
                Button("Hinzufügen") {
                    showLawBookSelector = true
                }
            }.sheet(isPresented: $showLawBookSelector) {
                SelectLawBooksView(app: app)
            }
        }
    
    }
    
    var lawBooks: [LawBook] {
        return savedLawBooks.savedLawBooks.filter {
            if (searchText == "") {
                return true
            }
            return $0.title.lowercased().contains(searchText.lowercased()) || $0.slug.lowercased().contains(searchText.lowercased())
        }
    }

    init(app: LawAppModel) {
        self.app = app
        app.setNotifications(key: "home", value: nil)
    }
}
