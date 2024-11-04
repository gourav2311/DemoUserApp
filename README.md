# DemoUsersApp with Clean Architecture and SwiftUI

## Overview

  DemoUsersApp is an iOS application designed with Clean Architecture principles and SwiftUI modularity. This project demonstrates a scalable, maintainable, and testable architecture, leveraging dependency injection, protocol-oriented programming, and clear separation of concerns.

## Project Structure

The project is organized into distinct layers, each responsible for specific concerns:

- **App**: Entry point and application lifecycle management.
- **Presentation**: UI components and view models.
- **Domain**: Business logic and use cases.
- **Data**: Data sources and repositories.
- **Infrastructure**: Configuration, network, and utilities.


## Layer Responsibilities

### App

**DemoUsersApp.swift**: Entry point of the application, responsible for setting up the main window and initializing the dependency injection.

### Presentation

**View**: Contains SwiftUI views responsible for the UI layout and presentation.

- **UserListView.swift**: Main view displaying Users information.
- **UserRowView.swift**: Subview displaying individual user data items.

**ViewModel**: Contains view models that manage UI state and interact with the domain layer.

- **UserViewModel.swift**: View model for managing users data presentation logic.

### Domain

**Interfaces**: Defines protocols for repositories and data sources, ensuring a clear contract between layers.

- **UserDataSource.swift**: Protocol for users data sources.
- **UserRepository.swift**: Protocol for user repositories.

**UseCases**: Contains business logic and application-specific rules.

- **FetchUserUseCase.swift**: Use case for fetching users data.

**Entities**: Contains business models representing core domain objects.

- **UsersModule.swift**: Domain models for user data.

### Data

**Remote**: Contains data sources for fetching data from remote APIs.

- **RemoteUserDataSource.swift**: Implementation of users data source using remote APIs.

**Local**: Contains data sources for fetching data from local files.

- **LocalUserDataSource.swift**: Implementation of users data source using local JSON files.

**Repositories**: Coordinates between data sources and domain layer, transforming data as needed.

- **UserRepositoryImpl.swift**: Implementation of users repository.

### Infrastructure

**Network**: Manages network communication details.

- **APIClient.swift**: Handles HTTP requests and responses.
- **HTTPMethod.swift**: Enum for HTTP methods.
- **UsersAPIConfiguration.swift**: Constructs URLs for API endpoints.

**Configuration**: Manages application configurations.

- **AppConfiguration.swift**: Implementation of configuration protocol.

**Utilities**: Contains shared utilities and helpers.

- **JSONLoader.swift**: Utility for loading JSON from local files.

**Interfaces**: Defines protocols for infrastructure components.

- **JSONLoaderProtocol.swift**: Protocol for JSON loader.
- **APIClientProtocol.swift**: Protocol for API client.
- **ConfigurationProtocol.swift**: Protocol for configuration.

## Dependency Injection

The project leverages dependency injection to manage dependencies between layers. This ensures loose coupling and enhances testability. Dependencies are injected through initializers, allowing for easy substitution of implementations during testing.

