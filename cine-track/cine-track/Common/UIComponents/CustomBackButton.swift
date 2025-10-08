//
//  CustomBackButton.swift
//  cine-track
//
//  Created by Laura Marson on 09/09/25.
//

import SwiftUI

struct CustomBackButton: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            HStack(spacing: 4) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.softWhite)
            }
        }
    }
}

#if DEBUG
#Preview {
    CustomBackButton()
        .background(Color.background)
}
#endif
