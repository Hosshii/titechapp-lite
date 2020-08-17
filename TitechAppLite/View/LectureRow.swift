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
            Rectangle().fill(Color("main")).frame(width: 5, height: 100, alignment: .leading)
            VStack(alignment:.leading,spacing:21){
                Text("00:00").font(Font.system(size: 15))
                Text("00:00").font(Font.system(size: 13)).foregroundColor(Color("textSub"))
            }
            VStack(alignment: .leading,spacing:21){
                Text(lecture.name.joined(separator:" ")).lineLimit(1).font(Font.system(size: 15))
                Text(lecture.description.joined(separator:" ")).lineLimit(1).font(Font.system(size: 15)).foregroundColor(Color("textSub"))
            }
            Spacer()
//            場所がいっぱいあるとはみ出るのでminにしたけどよくなさそう
            VStack(){
                ForEach(0..<min(lecture.location.count,2)){i in
                    Text(self.lecture.location[i]).font(Font.system(size:15)).foregroundColor(Color("main"))
                }
            }.padding(.trailing,20)

            
            
            
        }.frame(height: 100).listRowInsets(EdgeInsets(top: -20, leading: -20, bottom: -20, trailing: -20))
    }
    
}

struct LectureRow_Previews: PreviewProvider {
    static var previews: some View {
        LectureRow(lecture:Lecture(id:"1", name: ["電気的aaaaaaaaaaaaaaaaaa", "hogehoge"],
                                   description: ["RC回", "hogehoge", "hogehoge"],
                                   location: ["W833","G114"]))
    }
}