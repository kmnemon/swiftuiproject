//
//  Prospect.swift
//  HotProspects
//
//  Created by Paul Hudson on 03/01/2022.
//

import SwiftData
import Foundation

@Model
class Prospect {
    var name: String
    var emailAddress: String
    var isContacted: Bool
    var addDate: Date
    
    init(name: String, emailAddress: String, isContacted: Bool, addDate: Date) {
        self.name = name
        self.emailAddress = emailAddress
        self.isContacted = isContacted
        self.addDate = addDate
    }
}
