//
//  HomeModel.swift
//  germanlaws
//
//  Created by Lukas Deward on 29.11.22.
//

import SwiftUI


class HomeModel: ObservableObject {
    
    @Published var lawBooks = LawBooks(results: [LawBook]())
    @Published var connectionNotPossible = false
    

    func fetchData() {
        print("Api called")
        //if the done search is empty get the Grundgesetz
        
        /*guard let url = URL(string: "https://api.rechtsinformationsportal.de/v1/search?q=" + (search ?? "Grundgesetz") + "&type=laws&per_page=100") else {
            print("Error in guard HomeModel")
            return
        }*/
        guard let url = URL(string: "https://de.openlegaldata.io/api/law_books/?limit=10000") else {
            print("Error in guard HomeModel")
            return
        }
        
        //Storage.store([Article(id: 0, slug: "", title: "", content: "", section: "")], to: .caches, as: "savedLaws.json")
    
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                print("error in session")
                print(error?.localizedDescription ?? "")
                return
            }
            do {
                let lawBooks = try JSONDecoder().decode(LawBooks.self, from: data)
                DispatchQueue.main.async {
                    self?.lawBooks = lawBooks
                }
            } catch {
                //ignore when empty
            }
        }
        task.resume()
    }
    
}
