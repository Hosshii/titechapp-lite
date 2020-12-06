//
//  ValidURL.swift
//  TitechAppLite
//
//  Created by hoshiro ando on 2020/09/27.
//  Copyright © 2020 hoshiro ando. All rights reserved.
//

import Foundation

enum ValidURL {
    static func verifyUrl (urlString: String) -> Bool {
        if let url = URL(string: urlString), let scheme = url.scheme, scheme == "https" {
            return true
        } else {
            return false
        }
    }
}
