//
//  IcsTranslator.swift
//  TitechAppLite
//
//  Created by hoshiro ando on 2020/09/06.
//  Copyright © 2020 hoshiro ando. All rights reserved.
//

import Foundation

class IcsTranslator {
    static func roundDate(_ date: Date, calendar cal: Calendar) -> Date? {
        return cal.date(bySettingHour: 0, minute: 0, second: 0, of: date)
    }

    static func ics2lecture(icsEvents: [ICSEvent]) -> [OneDayLecture] {
        let cal = Calendar.current
        var multiDayLectures: [OneDayLecture] = []
        let sortedICSEvents = icsEvents.sorted { $0.dtstart < $1.dtstart }
        var icsEventDictionary = [Date: [Lecture]]()

        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.setLocalizedDateFormatFromTemplate("MMMdEEEE")

        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short

        for icsEvent in sortedICSEvents {
            guard let roundedDate = roundDate(icsEvent.dtstart, calendar: cal) else {
                continue
            }
            if var lectures = icsEventDictionary[roundedDate] {
                lectures.append(
                    Lecture(
                        id: icsEvent.id,
                        name: icsEvent.summary,
                        description: icsEvent.description,
                        location: icsEvent.location.components(separatedBy: ","),
                        start: timeFormatter.string(from: icsEvent.dtstart),
                        end: timeFormatter.string(from: icsEvent.dtend)
                    )
                )
                icsEventDictionary[roundedDate] = lectures
            } else {
                icsEventDictionary[roundedDate] = [
                    Lecture(
                        id: icsEvent.id,
                        name: icsEvent.summary,
                        description: icsEvent.description,
                        location: icsEvent.location.components(separatedBy: ","),
                        start: timeFormatter.string(from: icsEvent.dtstart),
                        end: timeFormatter.string(from: icsEvent.dtend)
                    )
                ]
            }
        }

        guard let today = roundDate(Date(), calendar: cal) else {
            return []
        }
        // 今日から何日表示するか
        for i in 0..<120 {
            guard let date = Calendar.current.date(byAdding: .day, value: i, to: today) else {
                print("error")
                continue
            }
            let lectures = icsEventDictionary[date] ?? []
            multiDayLectures.append(
                OneDayLecture(
                    id: date,
                    lectures: lectures,
                    date: formatter.string(from: date)
                )
            )
        }

        return multiDayLectures
    }
}
