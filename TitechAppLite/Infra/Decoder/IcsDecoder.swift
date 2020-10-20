//
//  IcsDecoder.swift
//  TitechAppLite
//
//  Created by hoshiro ando on 2020/09/06.
//  Copyright © 2020 hoshiro ando. All rights reserved.
//

import Foundation

class IcsDecoder {
    static let iso8601fmt: ISO8601DateFormatter = {
        let fmt = ISO8601DateFormatter()
        var opt: ISO8601DateFormatter.Options = [.withFullDate, .withFullTime]
        opt.remove([.withDashSeparatorInDate, .withColonSeparatorInTime, .withColonSeparatorInTimeZone])
        fmt.formatOptions = opt
        return fmt
    }()
    
    static let TZOFFSET = "TZOFFSETTO"
    static let BEGIN = "BEGIN:VEVENT"
    static let DTSTAMP = "DTSTAMP"
    static let DTEND = "DTEND"
    static let DTSTART = "DTSTART"
    static let LOCATION = "LOCATION"
    static let DESCRIPTION = "DESCRIPTION"
    static let SUMMARY = "SUMMARY"
    static let UID = "UID"
    static let END = "END:VEVENT"

    static func icsDecoder(icsString: String) -> [ICSEvent] {
        var beginFlag = false
        var tzoffset = "0000"
        var result: [ICSEvent] = []
        
        var tmpdtstamp: Date?
        var tmpdtend: Date?
        var tmpdtstart: Date?
        var tmplocation: String?
        var tmpdescription: String?
        var tmpsummary: String?
        var tmpuid: String?
        
        icsString.enumerateLines{ line, stop in
            if line.hasPrefix(TZOFFSET) {
                let l = line.replacingOccurrences(of: TZOFFSET + ":", with: "")
                tzoffset = l
            }
            if line.hasPrefix(BEGIN) {
                beginFlag = true
            }
            
            if beginFlag {
                if line.hasPrefix(DTSTAMP) {
                    let arr = line.components(separatedBy: ":")
                    if arr.count < 2 {
                        return
                    }
                    tmpdtstamp = iso8601fmt.date(from: arr[1] + tzoffset)
                } else if line.hasPrefix(DTSTART) {
                    let arr = line.components(separatedBy: ":")
                    if arr.count < 2 {
                        return
                    }
                    tmpdtstart = iso8601fmt.date(from: arr[1] + tzoffset)
                } else if line.hasPrefix(DTEND) {
                    let arr = line.components(separatedBy: ":")
                    if arr.count < 2 {
                        return
                    }
                    tmpdtend = iso8601fmt.date(from: arr[1] + tzoffset)
                } else if line.hasPrefix(LOCATION) {
                    let l = line.replacingOccurrences(of: LOCATION + ":", with: "")
                    tmplocation = l
                }else if line.hasPrefix(DESCRIPTION) {
                    let l = line.replacingOccurrences(of: DESCRIPTION + ":", with: "")
                    tmpdescription = l
                } else if line.hasPrefix(SUMMARY) {
                    let l = line.replacingOccurrences(of: SUMMARY + ":", with: "")
                    tmpsummary = l
                }else if line.hasPrefix(UID) {
                    let l = line.replacingOccurrences(of: UID + ":", with: "")
                    tmpuid = l
                }else if line.hasPrefix(END) {
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
                    beginFlag = false
                    
                }
            }
            
        }
        return result
    }
}
