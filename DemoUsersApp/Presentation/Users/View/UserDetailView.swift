//
//  UserDetailView.swift
//  DemoUsersApp



import SwiftUI
struct UserDetailView: View {
    let user: UserPresentationModel // Pass the user to the detail view

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
             
                // Detail Card with Name
                DetailCard(title: AppStringsConstant.userDetailName, value: user.name, icon: "person.fill")
                
                // Detail Card with Gender
                DetailCard(title: AppStringsConstant.userDetailGender, value: user.gender, icon: "g.circle.fill")
                
                // Detail Card with ID
                DetailCard(title: AppStringsConstant.userDetailID, value: "\(String(describing: user.id))", icon: "number.circle.fill")
                
                // Detail Card with Email
                DetailCard(title: AppStringsConstant.userDetailEmail, value: user.email , icon: "envelope.fill")
                
                // Detail Card with Active Status
                               DetailCardWithStatus(
                                   title: AppStringsConstant.userDetailStatus,
                                   value: user.isActive ? AppStringsConstant.userDetailStatusActive : AppStringsConstant.userDetailStatusInactive,
                                   icon: "power.circle.fill",
                                   isActive: user.isActive
                               )
                Spacer()
            }
            .padding()
        }
        .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
        .navigationTitle(AppStringsConstant.userlDetailsViewTitle)
    }
}

struct DetailCard: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .font(.system(size: 40))
                .padding()
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                    .foregroundColor(.primary)
            }
            Spacer()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 3))
    }
}

struct DetailCardWithStatus: View {
    let title: String
    let value: String
    let icon: String
    let isActive: Bool
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(isActive ? .green : .red)
                .font(.system(size: 40))
                .padding()
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.secondary)
                HStack {
                    Text(value)
                        .font(.system(size: 20, weight: .medium, design: .rounded))
                        .foregroundColor(.primary)
                    Circle()
                        .fill(isActive ? Color.green : Color.red)
                        .frame(width: 14, height: 14) // Small dot indicator for ON/OFF status
                }
            }
            Spacer()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white)
                        .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 3))
    }
}
