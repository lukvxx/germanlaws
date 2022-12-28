//
//  SavedLawBooksModel.swift
//  Gesetze
//
//  Created by Lukas Deward on 28.12.22.
//

import Foundation


class SavedLawBooks: ObservableObject {
    
    @Published var savedLawBooks : [LawBook] = [LawBook]()
    
    func getLawBooks() {
        if Storage.fileExists("savedLawBooks.json", in: .caches) {
            savedLawBooks = Storage.retrieve("savedLawBooks.json", from: .caches, as: [LawBook].self)
        }
    }
    
    func addLawBook(newLawBook: LawBook) {
        var lawbooks: [LawBook]
        if Storage.fileExists("savedLawBooks.json", in: .caches) {
            lawbooks = Storage.retrieve("savedLawBooks.json", from: .caches, as: [LawBook].self)
            lawbooks.append(newLawBook)
        } else {
            lawbooks = [newLawBook]
        }
        Storage.store(lawbooks, to: .caches, as: "savedLawBooks.json")
    }
    
    func removeLawBook(l: LawBook) {
        if Storage.fileExists("savedLawBooks.json", in: .caches) {
            let lawbooks = Storage.retrieve("savedLawBooks.json", from: .caches, as: [LawBook].self)
            let newLawBooks = lawbooks.filter { law in
                return law != l
            }
            Storage.store(newLawBooks, to: .caches, as: "savedLawBooks.json")
        }
    }
    
    func isLawBookSaved(l: LawBook) -> Bool {
        return savedLawBooks.contains(l)
    }
}
