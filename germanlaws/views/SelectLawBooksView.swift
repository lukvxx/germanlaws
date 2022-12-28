//
//  SelectLawBooksView.swift
//  Gesetze
//
//  Created by Lukas Deward on 24.12.22.
//

import SwiftUI

struct SelectLawBooksView: View {
    
    var app: LawAppModel
    
    @StateObject var viewModel = HomeModel()
    
    @StateObject var savedLawBooks = SavedLawBooks()
    
    @State private var searchText = ""
    
    @State private var loadingTimedOut = false;
        
        var body: some View {
            NavigationView {
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
                            HStack {
                                Text(lawBook.title)
                                Spacer()
                                if (savedLawBooks.isLawBookSaved(l: lawBook)) {
                                            Button {
                                                savedLawBooks.removeLawBook(l: lawBook)
                                                savedLawBooks.getLawBooks()
                                            } label: {
                                                HStack {
                                                    Text("Entfernen")
                                                    Image(systemName: "square.and.arrow.up.on.square")
                                                }.foregroundColor(.red)
                                            }
                                        
                                } else {
                                            Button {
                                                savedLawBooks.addLawBook(newLawBook: lawBook)
                                                savedLawBooks.getLawBooks()
                                            } label: {
                                                HStack {
                                                    Text("Speichern")
                                                    Image(systemName: "square.and.arrow.down.on.square")
                                                }.foregroundColor(.green)
                                            }
                                        
                                }

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
                    savedLawBooks.getLawBooks()
                }
            }
        }
    
    
    var lawBooks: [LawBook] {
        return viewModel.lawBooks.results.filter {
            if ($0.latest) {
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



struct Contact: Identifiable {
    var id = UUID()
    var name: String
}
