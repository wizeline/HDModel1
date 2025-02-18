//
//  NoHighlightButtonStyle.swift
//  HD-POC
//
//  Created by Kelderth Krom on 16/02/25.
//

import SwiftUI

struct NoHighlightButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label.foregroundColor(.black)
    }
}
