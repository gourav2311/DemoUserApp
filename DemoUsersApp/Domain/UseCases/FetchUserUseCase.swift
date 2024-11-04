//
//  FetchUserUseCase.swift

import SwiftUI

final public class FetchUserUseCase {
    private let repository: UserRepository
    
     init(repository: UserRepository) {
        self.repository = repository
    }
    
     func execute( completion: @escaping (Result<[UserModel], Error>) -> Void) {
        repository.fetchUser( completion: completion)
    }
}
