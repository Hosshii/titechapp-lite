//
//  UserSettingImpl.swift
//  TitechAppLite
//
//  Created by hoshiro ando on 2020/09/29.
//  Copyright © 2020 hoshiro ando. All rights reserved.
//

import Foundation

let ocwiCalenderURLString = "ocwiCalenderURLString"

struct UserSettingRepositoryImpl: UserSettingRepository {
    func set(ocwiCalenderUrl: URL){
        UserDefaults.standard.set(ocwiCalenderUrl.absoluteString,forKey: ocwiCalenderURLString)
    }
    
    func getOcwiCalenderURL() -> URL?{
        guard  let url =  UserDefaults.standard.string(forKey: ocwiCalenderURLString) else {
            return nil
        }
        return URL.init(string: url)
    }
}


 
