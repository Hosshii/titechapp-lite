//
//  Apiclient.swift
//  TitechAppLite
//
//  Created by hoshiro ando on 2020/08/30.
//  Copyright © 2020 hoshiro ando. All rights reserved.
//

import Foundation
import Combine

struct ApiClient {
    let session: URLSession = URLSession(configuration: .default)
    func fetch (_ url: URL) -> AnyPublisher<Data, URLError> {
        session.dataTaskPublisher(for: url).map{$0.data}.eraseToAnyPublisher()
    }
}
