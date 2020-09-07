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
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                // TODO: エラーハンドリング
            },
                  receiveValue: { ics in
 
                    let icsString = String(data: ics, encoding: .utf8) ?? ""
                    let icsEvents = IcsDecoder.icsDecoder(icsString: icsString)
                    let lectures = IcsTranslator.ics2lecture(icsEvents: icsEvents)
                    self.multiDayLecture = lectures
            }
        )
    }
}
