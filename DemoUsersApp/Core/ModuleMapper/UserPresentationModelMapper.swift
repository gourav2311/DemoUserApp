//
//  UserPresentationModelMapper.swift
//  DemoUsersApp

import Foundation
struct UserPresentationModelMapper{
    static func toPresentation(userModel:UserModel) -> UserPresentationModel {
        return UserPresentationModel(id: userModel.id, name: userModel.name, email: userModel.email, gender: userModel.gender, isActive: userModel.isActive)
    }
}
