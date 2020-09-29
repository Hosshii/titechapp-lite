//
//  UserProfile.swift
//  TitechAppLite
//
//  Created by hoshiro ando on 2020/09/27.
//  Copyright © 2020 hoshiro ando. All rights reserved.
//

import Foundation

class UserProfile: ObservableObject {
    /// ユーザ名
    @Published var ocwiCalenderURL: String {
        didSet {
            UserDefaults.standard.set(ocwiCalenderURL, forKey: "ocwiCalenderURL")
        }
    }
    
    /// 初期化処理
    init() {
        self.ocwiCalenderURL = UserDefaults.standard.string(forKey: "ocwiCalenderURL") ?? ""
    }
}
 
