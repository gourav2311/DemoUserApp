//
//  UserRepository.swift

import SwiftUI

protocol UserRepository {
    func fetchUser(completion: @escaping (Result<[UserModel], Error>) -> Void)
}
