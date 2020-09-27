//
//  ValidURL.swift
//  TitechAppLite
//
//  Created by hoshiro ando on 2020/09/27.
//  Copyright © 2020 hoshiro ando. All rights reserved.
//

import Foundation
import UIKit

class ValidURL {
    static func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
}
