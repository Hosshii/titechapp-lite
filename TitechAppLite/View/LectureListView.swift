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
    @State var isPresented: Bool = false
    
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) { // <3>
                    MenuButton(isPresented: $isPresented)
                }
            }
        }
        .onAppear{
            self.viewModel.appear()
        }
        .sheet(isPresented: $isPresented){
            SheetView()
        }
    }
}

struct SheetView: View {
    @State var ocwiCalenderUrl: String = ""
    var body: some View {
        NavigationView {
            Form {
                TextField("URL",text: $ocwiCalenderUrl)
                Button(action: {
                    print("Button Tapped")
                }){
                    Text("保存")
                }
                //                .foregroundColor(Color("main"))
                .disabled(!ValidURL.verifyUrl(urlString: ocwiCalenderUrl))
            }
            
        }
    }
}


struct LectureList_Previews: PreviewProvider {
    static var previews: some View {
        LectureListView()
    }
}
