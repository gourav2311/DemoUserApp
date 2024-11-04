//
//  AppConfiguration.swift


import Foundation

final class AppConfiguration: ConfigurationProtocol {
    
    var baseURL: String {
        return "https://gorest.co.in/public/v2/users"
    }
    
    var apiKey: String {
        return "" 
    }
    
    var localUserDataFilename: String {
        return "users_data"
    }
}

