# TMDB Application

## Overview

The TMDB Application is designed to showcase movies, TV shows, person details, and their
filmographies, drawing inspiration from the existing TMDB App. It supports Android, iOS, and web
platforms, providing a comprehensive and cross-platform experience for viewing entertainment
information.

## Getting Started

### Prerequisites

- **TMDB API Key:** Before you begin, ensure you have a valid TMDB API key to access the movie
  database. This key is crucial for fetching data and integrating it within the app.
- **Melos Dependency:** It's important to add the Melos dependency before starting the project.
  Melos is a tool that helps manage Dart and Flutter projects with multiple packages. For more
  information on getting started with Melos, please refer to the following
  site: [Melos Getting Started Guide](https://melos.invertase.dev/getting-started).

### Configuration

To integrate your TMDB API key into the application, you need to modify the `AuthInterceptor` file.
Locate the API key declaration and replace the placeholder with your actual TMDB API key as
demonstrated below:

- Find the line: `const String _token = "";`
- Replace it with: `const String _token = "<your_api_key>";`

This step is crucial for the application to authenticate and retrieve data from TMDB successfully.

### Dependencies

This project utilizes the following dependencies:

- `lottie: ^3.0.0`
- `logger: ^2.0.2+1`
- `intl: ^0.18.1`
- `youtube_player_iframe: ^4.0.4`
- `google_fonts: ^6.1.0`
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

### Platforms Supported

- Android
- iOS
- Web

By following these setup instructions, you'll be ready to explore a vast collection of entertainment
data through the TMDB Application on your preferred platform.
