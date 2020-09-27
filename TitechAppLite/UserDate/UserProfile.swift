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
    @Published var ocwURL: String {
        didSet {
            UserDefaults.standard.set(ocwURL, forKey: "ocwURL")
        }
    }
    
    /// 初期化処理
    init() {
        self.ocwURL = UserDefaults.standard.string(forKey: "ocwURL") ?? ""
    }
}
 
