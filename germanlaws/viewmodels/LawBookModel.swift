//
//  LawBookModel.swift
//  germanlaws
//
//  Created by Lukas Deward on 01.12.22.
//


import SwiftUI




class LawBookModel: ObservableObject {
    
    @Published var law = LawBookSpecific(results: [Article]())
    
    func fetchData(id: Int) {
        
        guard let url = URL(string: "https://de.openlegaldata.io/api/laws/?book_id=" + String(id) + "&limit=10000") else {
            print("Error in guard LawBookModel")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            //print(String(decoding: data, as: UTF8.self))
            do {
                let lawBooks = try JSONDecoder().decode(LawBookSpecific.self, from: data)
                DispatchQueue.main.async {
                    self?.law.results = lawBooks.results
                    // ready = true
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
}


