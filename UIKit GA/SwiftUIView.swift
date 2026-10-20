//
//  SwiftUIView.swift
//  UIKit GA
//
//  Created by Raissa Parente on 20/10/26.
//

import SwiftUI

struct SwiftUIView: View {
    @State private var isGreen = false

    var body: some View {
        ZStack {
            Rectangle()
                .fill(isGreen ? Color.green : Color.white)
            Button("Color Rectangle") {
                isGreen = true
            }
        }
    }
}

#Preview {
    SwiftUIView()
}
