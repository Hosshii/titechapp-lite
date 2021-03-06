//
//  LectureList.swift
//  TitechAppLite
//
//  Created by hoshiro ando on 2020/08/17.
//  Copyright © 2020 hoshiro ando. All rights reserved.
//

import SwiftUI

struct LectureListView: View {
    @ObservedObject var viewModel = LectureListViewModel()
    var body: some View {
        NavigationView{
            List{
                ForEach(self.viewModel.multiDayLecture) { oneDayLecture in
                    Section(header: LectureHeader(date: oneDayLecture.date)){
                        ForEach(oneDayLecture.lectures) { lecture in
                            LectureRow(lecture: lecture)
                        }
                    }.listRowInsets(EdgeInsets())
                }                
            }
            .navigationBarTitle(Text("スケジュール"), displayMode: .inline)
        }
        .onAppear{
            self.viewModel.appear()
        }
    }
}

struct LectureList_Previews: PreviewProvider {
    static var previews: some View {
        LectureListView()
    }
}
