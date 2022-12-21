//
//  SavedModel.swift
//  germanlaws
//
//  Created by Lukas Deward on 08.12.22.
//

import Foundation


class SavedModel: ObservableObject {
    @Published var savedParagraphs : [Article] = [Article]()
    
    func getParagraphs() {
        if Storage.fileExists("savedLaws.json", in: .caches) {
            savedParagraphs = Storage.retrieve("savedLaws.json", from: .caches, as: [Article].self)
        }
    }
    
    func removeParagraph(p: Article) {
        if Storage.fileExists("savedLaws.json", in: .caches) {
            let paragraphs = Storage.retrieve("savedLaws.json", from: .caches, as: [Article].self)
            let newParagraphs = paragraphs.filter { article in
                return article != p
            }
            Storage.store(newParagraphs, to: .caches, as: "savedLaws.json")

        }
    }
}





