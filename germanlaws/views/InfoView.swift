//
//  Profile.swift
//  germanlaws
//
//  Created by Lukas Deward on 28.11.22.
//

import SwiftUI



struct InfoView: View {
    
    var app: LawAppModel
    var body: some View {
        NavigationStack() {
            List(){
                VStack {
                    Text("Informationen").bold()
                    Text("\nDiese App basiert auf der API von OpenLegalData:  https://de.openlegaldata.io . Für die dargestellten Informationen wird keine Haftung übernommen. https://de.openlegaldata.io/pages/imprint/")
                }
                VStack {
                    Text("Impressum").bold()
                    Text("\nMaximilian Grohmann\nMG Development (Einzelunternehmer)\nWelserstraße 3, 87463 Dietmannsried\n\nTelefon: +49 (0) 160 92 99 22 88 oder E-Mail: info@mg-development.de\n\nwww.mg-development.de\nwww.mg-development.de/datenschutz").frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .center)
                }
                Text("MG-Development © " + String(Calendar.current.component(.year, from: Date())) + " Lukas Deward" ).bold().frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .center)
                
            }
            .navigationTitle("Infos")
        }
    }
    init(app: LawAppModel) {
        self.app = app
    }
    
}


