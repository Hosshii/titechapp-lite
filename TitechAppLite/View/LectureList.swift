//
//  LectureList.swift
//  TitechAppLite
//
//  Created by hoshiro ando on 2020/08/17.
//  Copyright © 2020 hoshiro ando. All rights reserved.
//

import SwiftUI

struct LectureList: View {
    let lectures:[Lecture]
    var body: some View {
//        ForEachでやると変になった
//        List{
        List(lectures){lecture in
//            ForEach(lectures){lecture in
                LectureRow(lecture:lecture)
//            }
        
    }
    }
}

struct LectureList_Previews: PreviewProvider {
    static var previews: some View {
        LectureList(lectures:[Lecture(id:"1", name: ["電気的aaaaaaaaaaaaaaaaaa", "hogehoge"],
                                      description: ["RC回", "hogehoge", "hogehoge"],
                                      location: ["W833","G114"]),Lecture(id:"2", name: ["電気的aaaaaaaaaaaaaaaaaa", "hogehoge"],
                                                                         description: ["RC回", "hogehoge", "hogehoge"],
                                                                         location: ["W833","G114"]),Lecture(id:"3", name: ["電気的aaaaaaaaaaaaaaaaaa", "hogehoge"],
                                                                                                            description: ["RC回", "hogehoge", "hogehoge"],
                                                                                                            location: ["W833","G114"]),Lecture(id:"4", name: ["電気的aaaaaaaaaaaaaaaaaa", "hogehoge"],
                                                                                                                                               description: ["RC回", "hogehoge", "hogehoge"],
                                                                                                                                               location: ["W833","G114"])])
    }
}
