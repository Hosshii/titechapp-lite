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
        for i in 0..<120 {
            guard let date = Calendar.current.date(byAdding: .day, value: i, to: today) else {
                continue
            }
            var tmpLectures: [Lecture] = []
            for icsEvent in sortedICSEvents {
                if roundDate(icsEvent.dtstart, calendar: cal) == date {
                    tmpLectures.append(
                        Lecture(
                            id: icsEvent.id,
                            name: icsEvent.summary,
                            description: icsEvent.description,
                            location: icsEvent.location.components(separatedBy: ","),
                            start: timeFormatter.string(from: icsEvent.dtstart),
                            end: timeFormatter.string(from: icsEvent.dtend)
                        )
                    )
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

