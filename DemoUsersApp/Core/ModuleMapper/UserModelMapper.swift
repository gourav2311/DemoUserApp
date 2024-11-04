//
//  UserModuleMapper.swift
//  DemoUsersApp


import Foundation

struct UserModelMapper{
      // Converts UserDTO to User (Domain Layer)
    static func toDomain(userDTO:UsersModelDTO) -> UserModel {
        return UserModel(id: userDTO.id ?? 0, name: userDTO.name ?? "", email: userDTO.email ?? "", gender: userDTO.gender?.rawValue.capitalized ?? "Unknown", isActive: userDTO.status == .active)
    }
}
