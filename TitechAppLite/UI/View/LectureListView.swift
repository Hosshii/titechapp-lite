//
//  LectureList.swift
//  TitechAppLite
//
//  Created by hoshiro ando on 2020/08/17.
//  Copyright © 2020 hoshiro ando. All rights reserved.
//

import SwiftUI

struct LectureListView: View {
    @EnvironmentObject var viewModel: LectureListViewModel
    @State var isPresented: Bool = false

    var body: some View {
        NavigationView {
            List {
                ForEach(self.viewModel.multiDayLecture) { oneDayLecture in
                    Section(header: LectureHeader(date: oneDayLecture.date)) {
                        ForEach(oneDayLecture.lectures) { lecture in
                            LectureRow(lecture: lecture)
                        }
                    }.listRowInsets(EdgeInsets())
                }
            }
            .navigationBarTitle(Text("スケジュール"), displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    MenuButton(isPresented: $isPresented)
                }
            }
        }
        .onAppear {
            self.viewModel.appear()
        }
        .sheet(
            isPresented: $isPresented,
            onDismiss: {
                viewModel.appear()
            },
            content: {
                UserSettingSheet()
            })
    }
}

struct LectureList_Previews: PreviewProvider {
    static var previews: some View {
        LectureListView()
    }
}
