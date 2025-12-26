# Roomy

Roomy is a real-time media synchronization service that lets you watch videos or even listen to music together with your friends, no matter where they are. This is the Flutter client for Roomy.

# About the client
The project follows Clean Architecture principles and its features are organized into modules. Each module can contain two folders: `controllers` and `views`.

Controllers are responsible for business logic and state management using `signals` library, while Views build the UI and react to state changes.

# Getting Started

### Clone the repository and install its dependencies:

```sh
git clone https://github.com/kaicsm/roomy-app
cd roomy-app
flutter pub get
```

### Set up environment variables:

```sh
cp .env.example .env
```

and edit .env with your own values of each variable.

### Run

Make sure the [Roomy backend API](https://github.com/kaicsm/roomy-backend) is running and the `SERVER_DEBUG_URL` defined on your `.env` is correct.

Connect your device on your system and run the app using:
```sh
flutter run
```

# Libraries and Frameworks
- `signals` for the app state management
- `go_router` for the app route management
- `dio` for http comunication
- `get_it` for dependency injection
