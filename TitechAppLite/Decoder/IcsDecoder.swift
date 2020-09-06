//
//  IcsDecoder.swift
//  TitechAppLite
//
//  Created by hoshiro ando on 2020/09/06.
//  Copyright © 2020 hoshiro ando. All rights reserved.
//

import Foundation

class IcsDecoder {
    static func icsDecoder(icsString: String)->[ICSEvent]{
        let TZOFFSET = "TZOFFSETTO"
        let BEGIN = "BEGIN:VEVENT"
        let DTSTAMP = "DTSTAMP"
        let DTEND = "DTEND"
        let DTSTART = "DTSTART"
        let LOCATION = "LOCATION"
        let DESCRIPTION = "DESCRIPTION"
        let SUMMARY = "SUMMARY"
        let UID = "UID"
        let END = "END:VEVENT"
        var flag = false
        var tzoffset = "0000"
        var result: [ICSEvent] = []
        
        var tmpdtstamp: Date?
        var tmpdtend: Date?
        var tmpdtstart: Date?
        var tmplocation: String?
        var tmpdescription: String?
        var tmpsummary: String?
        var tmpuid: String?
        
        icsString.enumerateLines{line,stop in
            if line.hasPrefix(TZOFFSET) {
                let l = line.replacingOccurrences(of: TZOFFSET + ":", with: "")
                tzoffset = l
            }
            if line.hasPrefix(BEGIN) {
                flag = true
            }
            
            if flag {
                if line.hasPrefix(DTSTAMP) {
                    let arr = line.components(separatedBy: ":")
                    if arr.count < 2 {
                        return
                    }
                    tmpdtstamp = ISO8601StringtoDateTime(dateString: arr[1], tzoffset: tzoffset)
                }
                if line.hasPrefix(DTSTART) {let arr = line.components(separatedBy: ":")
                    if arr.count < 2 {
                        return
                    }
                    tmpdtstart = ISO8601StringtoDateTime(dateString: arr[1], tzoffset: tzoffset)
                }
                if line.hasPrefix(DTEND) {
                    let arr = line.components(separatedBy: ":")
                    if arr.count < 2 {
                        return
                    }
                    tmpdtend = ISO8601StringtoDateTime(dateString: arr[1], tzoffset: tzoffset)
                }
                if line.hasPrefix(LOCATION) {
                    let l = line.replacingOccurrences(of: LOCATION + ":", with: "")
                    tmplocation = l
                }
                if line.hasPrefix(DESCRIPTION) {
                    let l = line.replacingOccurrences(of: DESCRIPTION + ":", with: "")
                    tmpdescription = l
                }
                if line.hasPrefix(SUMMARY) {
                    let l = line.replacingOccurrences(of: SUMMARY + ":", with: "")
                    tmpsummary = l
                }
                if line.hasPrefix(UID) {
                    let l = line.replacingOccurrences(of: UID + ":", with: "")
                    tmpuid = l
                }
                if line.hasPrefix(END) {
                    guard
                        let dtstamp = tmpdtstamp,
                        let dtstart = tmpdtstart,
                        let dtend = tmpdtend,
                        let uid = tmpuid
                        else {
                            return
                    }
                    result.append(
                        ICSEvent(
                            dtstamp: dtstamp,
                            dtstart: dtstart,
                            dtend: dtend,
                            location: tmplocation ?? "",
                            description: tmpdescription ?? "",
                            summary: tmpsummary ?? "",
                            id: uid
                        )
                    )
                    flag = false
                    
                }
            }
            
        }
        return result
    }

    static func ISO8601StringtoDateTime(dateString: String, tzoffset: String)->Date?{
        let fmt = ISO8601DateFormatter()
        
        var opt: ISO8601DateFormatter.Options = [.withFullDate, .withFullTime]
        opt.remove([.withDashSeparatorInDate, .withColonSeparatorInTime, .withColonSeparatorInTimeZone])
        fmt.formatOptions = opt
        return fmt.date(from: dateString + tzoffset)
    }

}
