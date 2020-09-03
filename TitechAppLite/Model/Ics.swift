//
//  ics.swift
//  TitechAppLite
//
//  Created by hoshiro ando on 2020/09/03.
//  Copyright © 2020 hoshiro ando. All rights reserved.
//

import Foundation

struct ICSEvent: Identifiable {
    var dtstamp: Date
    var dtstart: Date
    var dtend: Date
    var location: String
    var description: String
    var summary: String
    var id: String
    
    init(){
        self.dtstamp = Date.init()
        self.dtstart = Date.init()
        self.dtend = Date.init()
        self.location = ""
        self.description = ""
        self.summary = ""
        self.id = ""
    }
}

struct ICS {
    var timezone: TimeZone!
    var event: [ICSEvent]

}

 
