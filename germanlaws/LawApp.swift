//
//  ContentView.swift
//  germanlaws
//
//  Created by Lukas Deward on 28.11.22.
//


import SwiftUI

struct LawApp: View {
    
    @ObservedObject var app = LawAppModel()
    
    var body: some View {
        TabView {
            HomeView(app: app)
                .tabItem {
                    Label("Gesetzbücher", systemImage: "books.vertical")
                }
                .badge(app.getNotifications(key: "home"))
            SavedView(app: app)
                .tabItem {
                    Label("Gespeichert", systemImage: "newspaper.fill")
                }
                .badge(app.getNotifications(key: "saved"))
            InfoView(app: app)
                .tabItem {
                    Label("Informationen", systemImage: "info.circle.fill")
                }
                .badge(app.getNotifications(key: "info"))
        }
    }
}

struct LawApp_Previews: PreviewProvider {
    static var previews: some View {
        LawApp()
    }
}
