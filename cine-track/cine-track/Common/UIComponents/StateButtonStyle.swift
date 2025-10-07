//
//  StateButtonStyle.swift
//  cine-track
//
//  Created by Laura Marson on 09/09/25.
//

import SwiftUI

struct StateButton: View {
    
    let title: String
    @Binding var isSelected: Bool
    let action: () -> Void
    
    // Customization options
    private let selectedIcon: String = "checkmark.circle"
    private let unselectedIcon: String = "plus.circle"
    private let iconSize: CGFloat = 32.0
    private let height: CGFloat = 44.0
    
    
    init(
        title: String,
        isSelected: Binding<Bool>,
        action: @escaping () -> Void
    ) {
        self.title = title
        self._isSelected = isSelected
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: isSelected ? selectedIcon : unselectedIcon)
                    .resizable()
                    .frame(width: iconSize, height: iconSize)
                    .fontWeight(.bold)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color.clear, Color.pink],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    
                Text(title)
                    .fontWeight(.bold)
            }
            .frame(height: height)
            .foregroundColor(.white)
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background(isSelected ? Color.buttonBackground.opacity(0.5) : Color.buttonBackground)
            .cornerRadius(25)
        }
    }
}



#Preview {
    @Previewable @State var isSelected1 = false
    @Previewable @State var isSelected2 = true
    
    VStack(spacing: 20) {
        StateButton(
            title: "Assistido",
            isSelected: $isSelected1,
            action: { print("Tapped") }
        )
        
        StateButton(
            title: "Assistido",
            isSelected: $isSelected2,
            action: { print("Tapped") }
        )
    }
    .padding()
    .background(Color.background)
}
