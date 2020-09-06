//
//  ics.swift
//  TitechAppLite
//
//  Created by hoshiro ando on 2020/09/03.
//  Copyright © 2020 hoshiro ando. All rights reserved.
//

import Foundation

struct ICSEvent: Identifiable {
    let dtstamp: Date
    let dtstart: Date
    let dtend: Date
    let location: String
    let description: String
    let summary: String
    let id: String
}
