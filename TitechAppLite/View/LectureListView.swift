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
//        ForEachでやると変になった
//        List{
        List(viewModel.lectures){lecture in
//            ForEach(viewModel.lectures){lecture in
                LectureRow(lecture:lecture)
            }
        
//    }
    }
}

struct LectureList_Previews: PreviewProvider {
    static var previews: some View {
        LectureListView()
    }
}
