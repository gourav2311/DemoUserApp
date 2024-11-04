//
//  UserView.swift


import SwiftUI

struct UserView: View {
    @StateObject private var viewModel: UserViewModel
    
    init(viewModel: UserViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        NavigationView {
            VStack {
                if let data = viewModel.users {
                  
                    List {
                        ForEach(data, id: \.id) { user in
                            NavigationLink(
                                destination: UserDetailView(user: user), // Navigate to UserDetailView
                                label: {
                                    UserCardView(user: user).accessibilityIdentifier("List")
                                        .accessibilityElement()
                                }
                            )
                        }
                    }
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.black).padding(.all,10)
                } else {
                    Text(AppStringsConstant.userlistloadingtext)
                        .foregroundColor(.black).padding(.all,10)
                }
            }
           
            .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all))
            .navigationTitle(AppStringsConstant.userlistViewTitle)
        }
        .onAppear(perform: {
            viewModel.fetchUser()
        })    }
}

