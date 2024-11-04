//
//  LocalUserDataSource.swift


import Foundation

public class LocalUserDataSource:UserDataSource {
    private let jsonLoader: JSONLoaderProtocol
    private let configuration: ConfigurationProtocol
    
     init(jsonLoader: JSONLoaderProtocol, configuration: ConfigurationProtocol) {
        self.jsonLoader = jsonLoader
        self.configuration = configuration
    }
    
     func fetchUser(completion: @escaping (Result<[UsersModelDTO], Error>) -> Void) {
        let filename = configuration.localUserDataFilename
        if let data = jsonLoader.loadJSON(filename: filename) {
            do {
                let data = try JSONDecoder().decode([UsersModelDTO].self, from: data)
                print(data)
                completion(.success(data))
            } catch {
                completion(.failure(error))
            }
        } else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: AppNetworkStringsConstant.localdataloadingfailed])))
        }
    }
}



