//
//  LectureRow.swift
//  TitechAppLite
//
//  Created by hoshiro ando on 2020/08/17.
//  Copyright © 2020 hoshiro ando. All rights reserved.
//

import SwiftUI

struct LectureRow: View {
    let lecture:Lecture
    var body: some View {
        HStack {
            Rectangle()
                .fill(Color("main"))
                .frame(width: 5, height: 100, alignment: .leading)
            VStack(alignment: .leading, spacing: 21){
                Text("00:00")
                    .font(Font.system(size: 13))
                    .foregroundColor(Color("textMain"))
                Text("00:00")
                    .font(Font.system(size: 13))
                    .foregroundColor(Color("textSub"))
            }
            VStack(alignment: .leading, spacing: 21){
                Text(lecture.name)
                    .lineLimit(1)
                    .font(Font.system(size: 15))
                    .foregroundColor(Color("textMain"))
                Text(lecture.description)
                    .lineLimit(1)
                    .font(Font.system(size: 15))
                    .foregroundColor(Color("textSub"))
            }
            Spacer()
            Text(self.lecture.location.joined(separator: ","))
                .lineLimit(2)
                .font(Font.system(size: 15))
                .foregroundColor(Color("main"))
                .frame(width: 44)
                .padding(.trailing,16)
        }.frame(height: 100)
    }
}

struct LectureRow_Previews: PreviewProvider {
    static var previews: some View {
        LectureRow(lecture:
            Lecture(
                id:"1",
                name: "電気的aaaaaaaaaaaaaaaaaahogehoge",
                description: "RC回 hogehogehogehoge",
                location: ["W833", "G114"])
        )
    }
}
