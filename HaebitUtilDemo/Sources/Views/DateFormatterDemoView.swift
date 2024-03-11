//
//  DateFormatterDemoView.swift
//  HaebitUtil
//
//  Created by Seunghun on 3/11/24.
//  Copyright © 2024 seunghun. All rights reserved.
//

import SwiftUI

struct DateFormatterDemoView: View {
    @StateObject var viewModel = DateFormatterDemoViewModel()
    var body: some View {
        VStack {
            DatePicker("", selection: $viewModel.date)
                .datePickerStyle(.graphical)
            Text(viewModel.dateResult)
            Text(viewModel.timeResult)
        }
    }
}

#Preview {
    DateFormatterDemoView()
}
