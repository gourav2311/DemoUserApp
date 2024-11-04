//
//  DemoUsersAppApp.swift
//  DemoUsersApp

import SwiftUI

@main
struct DemoUsersApp: App {
    var body: some Scene {
        WindowGroup {
            UserView(viewModel: getUserViewModel(useLocalData: false)) // Change this to true to use local data
        }
    }

    func getUserViewModel(useLocalData:Bool) -> UserViewModel {
        let apiClient = APIClient()
        let appConfiguration = AppConfiguration()
        let apiConfiguration = UserAPIConfiguration(configuration: appConfiguration)
        let remoteDataSource = RemoteUserDataSource(apiClient: apiClient, apiConfiguration: apiConfiguration)
        
        let jsonLoader = JSONLoader()
        let localDataSource = LocalUserDataSource(jsonLoader: jsonLoader, configuration: appConfiguration)

        let repository = UserRepositoryImpl(dataSource: useLocalData ? localDataSource : remoteDataSource)
        let fetchUserUseCase = FetchUserUseCase(repository: repository)
        let viewModel = UserViewModel(fetchUserUseCase: fetchUserUseCase)
        return viewModel
    }

}


