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
    @Published var multiDayLecture: [OneDayLecture] = [
        OneDayLecture(
            id: "1",
            lectures: [
                Lecture(
                    id: "1",
                    name: "電気的aaaaaaaaaaaaaaaaaahogehoge",
                    description: "RC回hogehogehogehoge",
                    location: ["W833", "G114"]
                ),
                Lecture(
                    id: "2",
                    name: "電気的aaaaaaaaaaaaaaaaaahogehoge",
                    description: "RC回hogehogehogehoge",
                    location: ["W833", "G114"]
                ),
                Lecture(
                    id: "3",
                    name: "電気的aaaaaaaaaaaaaaaaaahogehoge",
                    description: "RC回hogehogehogehoge",
                    location: ["W833", "G114"]
                ),
                Lecture(
                    id: "4",
                    name: "電気的aaaaaaaaaaaaaaaaaahogehoge",
                    description: "RC回hogehogehogehoge",
                    location: ["W833", "G114"]
                )
            ],
            date: "7/13"
        ),
        OneDayLecture(
            id: "2",
            lectures: [
                Lecture(
                    id: "1",
                    name: "電気的aaaaaaaaaaaaaaaaaahogehoge",
                    description: "RC回hogehogehogehoge",
                    location: ["W833", "G114"]
                ),
                Lecture(
                    id: "2",
                    name: "電気的aaaaaaaaaaaaaaaaaahogehoge",
                    description: "RC回hogehogehogehoge",
                    location: ["W833", "G114"]
                ),
                Lecture(
                    id: "3",
                    name: "電気的aaaaaaaaaaaaaaaaaahogehoge",
                    description: "RC回hogehogehogehoge",
                    location: ["W833", "G114"]
                ),
                Lecture(
                    id: "4",
                    name: "電気的aaaaaaaaaaaaaaaaaahogehoge",
                    description: "RC回hogehogehogehoge",
                    location: ["W833", "G114"]
                )
            ],
            date: "7/13"
        )
    ]
    
    private var cancellable: AnyCancellable!
    
    func appear(){
//        cancellable = ApiClient()
//            .fetch(URL(string:"https://secure.ocw.titech.ac.jp/ocwi/index.php?module=Ocwi&action=Webcal&iCalendarId=7a15a39b70381b5260413634e558159656ba26d9")!)
//            //                        .decode(type:String,decoder:JSONDecoder())
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { _ in
//                // TODO: エラーハンドリング
//            },
//                  receiveValue: { landmarks in
//                    //            self.landmarks = landmarks
//                    //                    print(String(data:landmarks,encoding: .utf8)!)
////                    let data = String(data:landmarks,encoding: .utf8)!
//                    let data = mockdata
//                    let ics = self.icsDecoder(icsString: data)
//                    print(ics!)
//            }
//        )
        let data = mockdata
        let ics = self.icsDecoder(icsString: data)
        print(ics!)
    }
    
    func ISO8601StringtoDateTime(dateString: String, timezone: TimeZone!)->Date{
        let fmt = ISO8601DateFormatter()
        
        var opt: ISO8601DateFormatter.Options = [.withFullDate, .withFullTime]
        opt.remove([.withDashSeparatorInDate, .withColonSeparatorInTime, .withColonSeparatorInTimeZone])
        fmt.formatOptions = opt
        
        fmt.timeZone = timezone   // 現地時間表記の場合
        return fmt.date(from: dateString + "Z")!
//        return fmt.date(from: "20180214T005131+0900")!
    }
    
    
    func icsDecoder(icsString: String)->ICS?{
        let TIMEZONE_HEADER = "X-WR-TIMEZONE"
        let BEGIN = "BEGIN:VEVENT"
        let DTSTAMP = "DTSTAMP"
        let DTEND = "DTEND"
        let DTSTART = "DTSTART"
        let LOCATION = "LOCATION"
        let DESCRIPTION = "DESCRIPTION"
        let SUMMARY = "SUMMARY"
        let UID = "UID"
        let END = "END:VEVENT"
        var ics = ICS(timezone: TimeZone.current, event:[])
        
//        var icsDictionary = [Date:[ICSEvent]]()
        var icsEvent = ICSEvent.init()
        var flag = false
        let calendar = Calendar.current
        
        icsString.enumerateLines{line,stop in
            if(line.contains(TIMEZONE_HEADER)){
                let arr = line.components(separatedBy: ":")
                ics.timezone = TimeZone(identifier: arr[1])!
            }
            print(line)
            if(line.contains(BEGIN)){
                flag = true
            }
            
            if flag {
                if(line.contains(DTSTAMP)){
                    let arr = line.components(separatedBy: ":")
                    icsEvent.dtstamp = self.ISO8601StringtoDateTime(dateString: arr[1], timezone: ics.timezone)
                }
                if(line.contains(DTSTART)){
                    let arr = line.components(separatedBy: ":")
                    icsEvent.dtstart = self.ISO8601StringtoDateTime(dateString: arr[1], timezone: ics.timezone)
                }
                if(line.contains(DTEND)){
                    let arr = line.components(separatedBy: ":")
                    icsEvent.dtend = self.ISO8601StringtoDateTime(dateString: arr[1], timezone: ics.timezone)
                }
                if(line.contains(LOCATION)){
                    let arr = line.components(separatedBy: ":")
                    icsEvent.location = arr[1]
                }
                if(line.contains(DESCRIPTION)){
                    let arr = line.components(separatedBy: ":")
                    icsEvent.description = arr[1]
                }
                if(line.contains(SUMMARY)){
                    let arr = line.components(separatedBy: ":")
                    icsEvent.summary = arr[1]
                }
                if(line.contains(UID)){
                    let arr = line.components(separatedBy: ":")
                    icsEvent.id = arr[1]
                }
                if(line.contains(END)){
//                    let dateOnly = self.roundDate(icsEvent.dtstart, calendar: calendar)
                    
//                    if let _ = ics.event[dateOnly] {
                        ics.event.append(icsEvent)
//                    }else {
//                        ics.event[dateOnly] = [icsEvent]
//                    }
                    icsEvent = ICSEvent.init()
                    flag = false
                }
            }
            
        }
        return ics
    }
    
    func roundDate(_ date: Date, calendar cal: Calendar) -> Date {
        return cal.date(bySettingHour: 0, minute: 0, second: 0, of: date)!
    }
}
