//
//  LectureHeader.swift
//  TitechAppLite
//
//  Created by hoshiro ando on 2020/08/23.
//  Copyright © 2020 hoshiro ando. All rights reserved.
//

import SwiftUI

struct LectureHeader: View {
    var body: some View {
        HStack{
            Rectangle()
                .fill(Color("grayMain"))
                .frame(width: 5, height: 55, alignment: .leading)
            Text("7月18日")
                .font(Font.system(size: 13))
                .foregroundColor(Color("textSub"))
                .padding(.leading ,15)
            Spacer()
        }
        .frame(height:55)
        .background(Color("backgroundMain"))
    }
}

struct LectureHeader_Previews: PreviewProvider {
    static var previews: some View {
        LectureHeader()
    }
}
