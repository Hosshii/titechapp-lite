//
//  UserSettingProtocol.swift
//  TitechAppLite
//
//  Created by hoshiro ando on 2020/09/29.
//  Copyright © 2020 hoshiro ando. All rights reserved.
//

import Foundation

protocol UserSettingRepository {
    func set(ocwiCalenderUrl: URL)
    func getOcwiCalenderURL() -> URL?
}
