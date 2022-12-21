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
    
    @State private var searchText = ""
    
    @State private var loadingTimedOut = false;

    
    var body: some View {
        NavigationStack() {
            HStack {
                if lawBooks.count == 0 {
                    if loadingTimedOut {
                        Text("Kein Treffer gefunden.")
                    } else {
                        ProgressView().progressViewStyle(CircularProgressViewStyle())
                            .task {
                                await delayText()
                            }
                    }
                } else {
                    List(lawBooks, id: \.id){ lawBook in
                            NavigationLink(lawBook.title) {
                                LawBookView(app: app, id: lawBook.id, title: lawBook.title)
                            }
                        
                    }.task {
                        loadingTimedOut = false
                    }.refreshable {
                        viewModel.fetchData()
                    }
                }
            }
            .navigationTitle("Gesetzbücher")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .onAppear {
                viewModel.fetchData()
            }

        }
    
    }
    
    var lawBooks: [LawBook] {
        return viewModel.lawBooks.results.filter {
            if ($0.latest && $0.title.count < 40) {
                if (searchText == "") {
                    return true
                }
                return $0.title.lowercased().contains(searchText.lowercased()) || $0.slug.lowercased().contains(searchText.lowercased())
            }
            return false
        }
    }
    
    private func delayText() async {
        try? await Task.sleep(nanoseconds: 2_500_000_000)
        loadingTimedOut = true
    }

    init(app: LawAppModel) {
        self.app = app
        app.setNotifications(key: "home", value: nil)
    }
}

