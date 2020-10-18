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
    private let lectureListUseCase: LectureListUseCase
    
    private var cancellable: AnyCancellable!
    
    init(lectureListUseCase: LectureListUseCase) {
        self.lectureListUseCase = lectureListUseCase
    }
    
    func appear(){
        guard let url = lectureListUseCase.getOcwCalenderURL() else {
            print("url not found")
            return
        }
        print("url found")
        cancellable = ApiClient()
//            .fetch(URL(string:"https://ocwi-mock.titech.app/ocwi/index.php?module=Ocwi&action=Webcal&iCalendarId=test")!)
            .fetch(url)
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
