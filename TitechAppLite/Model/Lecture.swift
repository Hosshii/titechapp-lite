//
//  LectureRow.swift
//  TitechAppLite
//
//  Created by hoshiro ando on 2020/08/17.
//  Copyright © 2020 hoshiro ando. All rights reserved.
//

import Foundation

struct Lecture: Identifiable {
    let id: String
    let name: String
    let description: String
    let location: [String]
    let start: String
    let end: String
}

struct OneDayLecture: Identifiable {
    let id: Date
    let lectures: [Lecture]
    let date: String
}
