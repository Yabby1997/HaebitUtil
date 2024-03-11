//
//  DateFormatterDemoViewModel.swift
//  HaebitUtil
//
//  Created by Seunghun on 3/11/24.
//  Copyright © 2024 seunghun. All rights reserved.
//

import Foundation
import HaebitUtil

final class DateFormatterDemoViewModel: ObservableObject {
    private let formatter = HaebitDateFormatter()
    @Published var date = Date()
    @Published var dateResult: String = ""
    @Published var timeResult: String = ""
    
    init() {
        bind()
    }
    
    private func bind() {
        $date
            .compactMap { [weak self] date in
                self?.formatter.formatDate(from: date, with: Locale.current)
            }
            .assign(to: &$dateResult)
        
        $date
            .compactMap { [weak self] date in
                self?.formatter.formatTime(from: date, with: Locale.current)
            }
            .assign(to: &$timeResult)
    }
}
