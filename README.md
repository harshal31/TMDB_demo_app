# TMDB Application

## Overview

The TMDB Application is designed to showcase movies, TV shows, person details, and their
filmographies. Drawing inspiration from the existing TMDB App, it supports Android, iOS, and web
platforms, offering a comprehensive and cross-platform experience for accessing entertainment
information.

## Getting Started

### Prerequisites

- **TMDB API Key:** Before you begin, ensure you have a valid TMDB API key to access the movie
  database. This key is crucial for fetching data and integrating it within the app.

- **Melos Dependency:** Add the Melos dependency before starting the project to manage Dart and
  Flutter projects with multiple packages effectively. For more information on getting started with
  Melos, please refer to
  the [Melos Getting Started Guide](https://melos.invertase.dev/getting-started).

- **Melos Bootstrap[Melos bs]:** After ensuring Melos is activated globally, run the following
  command melos bs inside project root terminal to bootstrap the project

### Configuration

To integrate your TMDB API key into the application, modify the `AuthInterceptor` file. Replace the
API key declaration with your actual TMDB API key as shown below:

- Find the line: `const String _token = "";`
- Replace it with: `const String _token = "Bearer <your_api_key>";`

This step ensures the application can authenticate and retrieve data from TMDB successfully.

### Dependencies

This project utilizes the following dependencies:

- `lottie: ^3.0.0`
- `logger: ^2.0.2+1`
- `intl: ^0.18.1`
- `youtube_player_iframe: ^4.0.4`
- `super_tooltip: ^2.0.7`
- `flutter_rating_bar: ^4.0.1`
- `url_launcher: ^6.2.4`
- `flutter_bloc: ^8.1.3`
- `retrofit: ^4.0.3`
- `dio: ^5.4.0`
- `hive_flutter: ^1.1.0`
- `path_provider: ^2.1.2`
- `get_it: ^7.6.7`
- `go_router: ^12.1.3`
- `json_annotation: ^4.8.1`
- `fpdart: ^1.1.0`
- `equatable: ^2.0.5`
- `responsive_framework: ^1.1.1`
- `extended_image: ^8.2.0`
- `pretty_dio_logger: ^1.3.1`
- `image_network: ^2.5.4+1`
- `infinite_scroll_pagination: ^4.0.0`

### Flutter Doctor Summary

This project was created and developed using the following Flutter version:

```
$ flutter doctor
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.16.9, on macOS 14.3 23D56 darwin-arm64, locale en-IN)
[✓] Android toolchain - develop for Android devices (Android SDK version 34.0.0)
[✓] Xcode - develop for iOS and macOS (Xcode 15.0.1)
[✓] Chrome - develop for the web
[✓] Android Studio (version 2023.1)
[✓] IntelliJ IDEA Ultimate Edition (version 2023.3.3)
[✓] VS Code (version 1.86.0)
[✓] Connected device (4 available)
[✓] Network resources
• No issues found!
```

This information is essential for ensuring compatibility and understanding the development
environment of the project.

### Platforms Supported

- Android
- iOS
- Web

By following these setup instructions, including the Melos dependency setup, integrating the listed
dependencies, and understanding the development environment through the Flutter Doctor summary,
you'll be prepared to explore a vast collection of entertainment data through the TMDB Application
on your preferred platform.
