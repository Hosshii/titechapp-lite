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
    @Published var multiDayLecture: [OneDayLecture] = []
    
    private var cancellable: AnyCancellable!
    
    func appear(){
        cancellable = ApiClient()
            .fetch(URL(string:"https://ocwi-mock.titech.app/ocwi/index.php?module=Ocwi&action=Webcal&iCalendarId=test")!)
            //                        .decode(type:String,decoder:JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                // TODO: エラーハンドリング
            },
                  receiveValue: { landmarks in
 
                    let data = String(data:landmarks,encoding: .utf8)!
//                                                let data = mockdata
                    let icsEvents = IcsDecoder.icsDecoder(icsString: data)
                    let lectures = IcsTranslator.ics2lecture(icsEvents: icsEvents)
                    self.multiDayLecture = lectures
            }
        )
    }
}
