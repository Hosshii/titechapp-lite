//
//  IcsTranslator.swift
//  TitechAppLite
//
//  Created by hoshiro ando on 2020/09/06.
//  Copyright © 2020 hoshiro ando. All rights reserved.
//

import Foundation

class IcsTranslator {
    static func roundDate(_ date: Date, calendar cal: Calendar) -> Date {
        return cal.date(bySettingHour: 0, minute: 0, second: 0, of: date)!
    }
    
    static func ics2lecture(icsEvents: [ICSEvent]) -> [OneDayLecture] {
        let sortedICSEvents = icsEvents.sorted{ $0.dtstart < $1.dtstart }
        var multiDayLectures: [OneDayLecture] = []
        let cal = Calendar.current
        
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.setLocalizedDateFormatFromTemplate("MMMdEEEE")
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short
        
        let today = roundDate(Date(), calendar: cal)
        // 今日から何日表示するか
        var sivIndex = 0
        L:for i in 0..<120 {
            guard let date = Calendar.current.date(byAdding: .day, value: i, to: today) else {
                print("error")
                continue
            }
            var tmpLectures: [Lecture] = []
            while roundDate(sortedICSEvents[sivIndex].dtstart, calendar: cal) < date {
                sivIndex += 1
                if sivIndex >= sortedICSEvents.count {
                    break L
                }
            }
            
            while roundDate(sortedICSEvents[sivIndex].dtstart, calendar: cal) == date {
                tmpLectures.append(
                    Lecture(
                        id: sortedICSEvents[sivIndex].id,
                        name: sortedICSEvents[sivIndex].summary,
                        description: sortedICSEvents[sivIndex].description,
                        location: sortedICSEvents[sivIndex].location.components(separatedBy: ","),
                        start: timeFormatter.string(from: sortedICSEvents[sivIndex].dtstart),
                        end: timeFormatter.string(from: sortedICSEvents[sivIndex].dtend)
                    )
                )
                sivIndex += 1
                if sivIndex >= sortedICSEvents.count {
                    break L
                }
            }
            
            let oneDaylecture = OneDayLecture(
                id: date,
                lectures: tmpLectures,
                date: formatter.string(from: date)
            )
            multiDayLectures.append(oneDaylecture)
        }
        
        return multiDayLectures
    }
}

