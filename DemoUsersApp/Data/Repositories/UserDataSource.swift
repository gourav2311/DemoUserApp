//
//  UserDataSource.swift

import Foundation

protocol UserDataSource {
    func fetchUser(completion: @escaping (Result<[UsersModelDTO], Error>) -> Void)
}

