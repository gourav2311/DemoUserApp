//
//  User.swift

import Foundation

// MARK: - UsersModuleElement
class UsersModelDTO: Codable {
    var id: Int?
    var name, email: String?
    var gender: Gender?
    var status: Status?

    init(id: Int?, name: String?, email: String?, gender: Gender?, status: Status?) {
        self.id = id
        self.name = name
        self.email = email
        self.gender = gender
        self.status = status
    }
}

enum Gender: String, Codable {
    case female = "female"
    case male = "male"
    case unknown = "Unknown"
}

enum Status: String, Codable {
    case active = "active"
    case inactive = "inactive"
}
