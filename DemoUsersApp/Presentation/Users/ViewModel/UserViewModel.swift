//
//  UserViewModel.swift


import Foundation
import Combine

public class UserViewModel: ObservableObject {
    private let fetchUserUseCase: FetchUserUseCase
    @Published var users: [UserPresentationModel]?
    @Published var errorMessage: String?
    
    public init(fetchUserUseCase: FetchUserUseCase) {
        self.fetchUserUseCase = fetchUserUseCase
    }
    
    public func fetchUser() {
        fetchUserUseCase.execute() { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.users = data.map{UserPresentationModelMapper.toPresentation(userModel:  $0)}
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
