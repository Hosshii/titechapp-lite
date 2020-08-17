//
//  LectureListViewModel.swift
//  TitechAppLite
//
//  Created by hoshiro ando on 2020/08/17.
//  Copyright © 2020 hoshiro ando. All rights reserved.
//

import Foundation

import Combine
class LectureListViewModel: ObservableObject {
    @Published var lectures: [Lecture]=[
        Lecture(
            id:"1",
            name: "電気的aaaaaaaaaaaaaaaaaahogehoge",
            description: "RC回hogehogehogehoge",
            location: ["W833","G114"]
        ),
        Lecture(
            id:"2",
            name: "電気的aaaaaaaaaaaaaaaaaahogehoge",
            description: "RC回hogehogehogehoge",
            location: ["W833","G114"]
        ),
        Lecture(
            id:"3",
            name: "電気的aaaaaaaaaaaaaaaaaahogehoge",
            description: "RC回hogehogehogehoge",
            location: ["W833","G114"]
        ),
        Lecture(
            id:"4",
            name: "電気的aaaaaaaaaaaaaaaaaahogehoge",
            description: "RC回hogehogehogehoge",
            location: ["W833","G114"]
        )
    ]
    
}
