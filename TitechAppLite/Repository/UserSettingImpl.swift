//
//  UserSettingImpl.swift
//  TitechAppLite
//
//  Created by hoshiro ando on 2020/09/29.
//  Copyright © 2020 hoshiro ando. All rights reserved.
//

import Foundation

let ocwiCalenderURLString = "ocwiCalenderURLString"

class UserSetting: UserSettingProtocol {
    static func setOcwiCalenderURL(_ ocwiCalenderUrl: URL){
        UserDefaults.standard.set(ocwiCalenderUrl.absoluteString,forKey: ocwiCalenderURLString)
    }
    
    static func getOcwiCalenderURL() -> URL?{
        guard  let url =  UserDefaults.standard.string(forKey: ocwiCalenderURLString) else {
            return nil
        }
        return URL.init(string: url)
    }
}


 
