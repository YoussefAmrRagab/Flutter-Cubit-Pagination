<h2>🚀 Flutter Rick and Morty Characters App</h2>

<div align="center">
  
https://github.com/user-attachments/assets/580d2018-544f-4f81-94db-f771bdc711fa

</div>

This Flutter app uses the <a href="https://rickandmortyapi.com/">Rick and Morty API</a> to display and search for character information with pagination and state management using Cubit.

<h2>📂 Project Structure</h2>

    lib
    ├── config
    │   ├── app_colors.dart
    │   ├── app_router.dart
    │   ├── app_strings.dart
    │   └── app_styles.dart
    ├── data
    │   ├── data_sources
    │   │   └── api.dart
    │   ├── models
    │   │   └── character.dart
    │   └── repositories
    │       └── character_repo.dart
    ├── presentation
    │   ├── cubits
    │   │   ├── characters_cubit.dart
    │   │   ├── characters_state.dart
    │   │   └── searching_cubit.dart
    │   ├── screens
    │   │   ├── characters_screen.dart
    │   │   └── details_screen.dart
    │   └── widgets
    │       └── character_item.dart
    └── main.dart

<h3>🌟 Features</h3>

- Fetch characters from the <a href="https://rickandmortyapi.com/">Rick and Morty API</a>.
- Paginated list of characters.
- Search for characters by name.
- View character details.
- State management with Cubit.
- Check internet connectivity using `flutter_offline`.
