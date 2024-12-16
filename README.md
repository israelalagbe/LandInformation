# Land Information

A mobile application for managing land information (land sales listings),
built with Dart and the Flutter framework.

## Features

- Browse a list of land/property listings pulled from a REST API
- View the full details of a listing
- Admin area (username/password) for adding new listings, including
  image upload

## Project structure

| Path | Purpose |
| --- | --- |
| `lib/main.dart` | App entry point |
| `lib/property/property.dart` | `Property` model with JSON serialization |
| `lib/property/property-service.dart` | REST client for listings and file upload |
| `lib/property/property-list.dart` | Home screen listing all properties |
| `lib/property/property-details.dart` | Single-listing detail screen |
| `lib/property/property-item.dart` | List row widget |
| `lib/property/add-property.dart` | Admin form for creating a listing |
| `lib/property/property-admin-login.dart` | Admin login and shared dialog helpers |

## Getting started

```bash
flutter pub get
flutter run
```

## Requirements

- Flutter SDK (Dart `>=2.1.0`)
