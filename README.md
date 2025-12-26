# Roomy

Roomy is a real-time media synchronization service that lets you watch videos or even listen music together with your friends, no matter where they are. This is the flutter client for Roomy.

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

Make sure the <a href="https://github.com/kaicsm/roomy-backend">Roomy backend API</a> is running and the `SERVER_DEBUG_URL` defined on your `.env` is correct.

Connect your device on your system and run the app using:
```sh
flutter run
```
