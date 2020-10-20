//
//  UserSettingViewModel.swift
//  TitechAppLite
//
//  Created by hoshiro ando on 2020/10/18.
//  Copyright © 2020 hoshiro ando. All rights reserved.
//

import Foundation

class UserSettingViewModel: ObservableObject {
    @Published var ocwiCalenderURL: String = ""
    private let userSettingUseCase: UserSettingUseCase
    
    init(userSettingUseCase: UserSettingUseCase) {
        self.userSettingUseCase = userSettingUseCase
    }
    
    func save(){
        guard let url = URL(string: ocwiCalenderURL) else{
            return
        }
        userSettingUseCase.set(ocwiCalenderUrl: url)
    }
    
    func appear() {
        guard let url = userSettingUseCase.getOcwCalenderURL() else {
            return
        }
        ocwiCalenderURL = url.absoluteString
    }
}
