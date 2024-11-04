//
//  UserRepositoryImpl.swift

import Foundation

final class UserRepositoryImpl: UserRepository {
    private let dataSource: UserDataSource
    
    init(dataSource: UserDataSource) {
        self.dataSource = dataSource
    }
    
    func fetchUser(completion: @escaping (Result<[UserModel], Error>) -> Void) {
     
        dataSource.fetchUser { result in
            switch result {
            case .success(let data):
                completion(.success(data.map {UserModelMapper.toDomain(userDTO: $0)}))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        
    }
}

