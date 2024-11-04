//
//  UserAPIConfiguration.swift
import Foundation

public class UserAPIConfiguration {
    private let configuration: ConfigurationProtocol
    
    init(configuration: ConfigurationProtocol) {
        self.configuration = configuration
    }
    
    func makeUserURL() -> URL? {
        let baseURL = configuration.baseURL
        let apiKey = configuration.apiKey
        
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "appid", value: apiKey)
        ]
        return components?.url
    }
}


