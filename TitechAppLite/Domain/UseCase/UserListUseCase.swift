//
//  UserListUseCase.swift
//  TitechAppLite
//
//  Created by hoshiro ando on 2020/10/18.
//  Copyright © 2020 hoshiro ando. All rights reserved.
//

import Foundation

struct LectureListUseCase {
    private let useRepository: UserSettingRepository

    init (repo: UserSettingRepository) {
        self.useRepository = repo
    }

    func getOcwCalenderURL() -> URL? {
        useRepository.getOcwiCalenderURL()
    }
}
