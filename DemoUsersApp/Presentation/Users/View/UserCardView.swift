//
//  UserCardView.swift

import SwiftUI

struct UserCardView: View {
    let user: UserPresentationModel
    
    var body: some View {
        HStack {
            // Circular avatar placeholder
            Circle()
                .fill(Color.blue.opacity(0.7))
                .frame(width: 60, height: 60)
                .overlay(
                    Text(user.name.prefix(1)) // Show first letter of the name
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                )
            
            VStack(alignment: .leading, spacing: 8) {
                Text(user.name)
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)
            }
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 3)
        )
    }
}

