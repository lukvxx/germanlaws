//
//  ParagraphView.swift
//  germanlaws
//
//  Created by Lukas Deward on 02.12.22.
//

import SwiftUI
import WebKit

struct ParagraphView: View {
    
    var article: Article
    
    var viewModel = ParagraphModel()
    
    @State var content: String = ""
    @State var isSaved: Bool = false
    
    
    @Environment(\.colorScheme) var colorScheme
    
    var html: String {
        var color = ""
        if (colorScheme == .dark) {
            color = "background-color: black; color: white;"
        }
        return "</div><head><style> * {font-size: 16pt; font-family: arial; " + color + " } #paragraphContainer{ padding: 10%; }</style></head>"
    }
    
    
    var body: some View {

        NavigationStack {
            VStack {
                Text(article.slug)
                WebView(text: "<div id='paragraphContainer'>" + content + html)
                  .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)

            }
            .onAppear {
                content = article.content
            }
            .navigationTitle(article.section + " " + article.title)
            .toolbar {
                if (isSaved) {
                    ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                viewModel.removeParagraph(p: article)
                                isSaved = viewModel.isParagraphSaved(p: article)
                            } label: {
                                HStack {
                                    Text("Entfernen")
                                    Image(systemName: "square.and.arrow.up.on.square")
                                }.foregroundColor(.red)
                            }
                        }
                } else {
                    ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                viewModel.addParagraph(newParagraph: article)
                                isSaved = viewModel.isParagraphSaved(p: article)
                            } label: {
                                HStack {
                                    Text("Speichern")
                                    Image(systemName: "square.and.arrow.down.on.square")
                                }.foregroundColor(.green)
                            }
                        }
                }
                
            }.onAppear {
                isSaved = viewModel.isParagraphSaved(p: article)
            }
        }
    }
}


struct WebView: UIViewRepresentable {
  var text: String
   
  func makeUIView(context: Context) -> WKWebView {
    return WKWebView()
  }
   
  func updateUIView(_ uiView: WKWebView, context: Context) {
      uiView.loadHTMLString(text, baseURL: nil)
  }
}
