//
//  LawAppModel.swift
//  germanlaws
//
//  Created by Lukas Deward on 28.11.22.
//

import SwiftUI


class LawAppModel: ObservableObject {
    private static var tabNotifications: Dictionary<String, String?> = ["home": nil, "saved": nil, "info": nil]
    
    func setNotifications(key: String, value: String?) {
        LawAppModel.tabNotifications[key] = value
    }
    
    func getNotifications(key: String) -> String? {
        return LawAppModel.tabNotifications[key]!
    }
}







