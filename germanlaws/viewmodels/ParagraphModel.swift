//
//  ParagraphModel.swift
//  germanlaws
//
//  Created by Lukas Deward on 08.12.22.
//

import Foundation


class ParagraphModel {
    
    
    func addParagraph(newParagraph: Article) {
        var paragraphs: [Article]
        if Storage.fileExists("savedLaws.json", in: .caches) {
            paragraphs = Storage.retrieve("savedLaws.json", from: .caches, as: [Article].self)
            paragraphs.append(newParagraph)
        } else {
            paragraphs = [newParagraph]
        }
        Storage.store(paragraphs, to: .caches, as: "savedLaws.json")
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
    
    func isParagraphSaved(p: Article) -> Bool {
        if Storage.fileExists("savedLaws.json", in: .caches) {
            let paragraphs = Storage.retrieve("savedLaws.json", from: .caches, as: [Article].self)
            return paragraphs.contains(p)
        }
        return false
    }
}


