# Dental Clinic Management System - Activity 8
Dental Clinic starter for Activity 8. Confirm the planned features match your approved Activity 6 flow.

## Summary
This starter demonstrates Home/Login navigation and reusable UI components.
Community problem: manual appointment scheduling and scattered patient records. Intended users: patients, dentists and clinic staff.

## Stack
Implemented source: Flutter Web/Dart UI. Planned: REST API and PostgreSQL.
No API calls, database connection, or real authentication are implemented.

## Prepare this source package (first time only)
The package contains custom source, not SDK-generated platform files.
1. Outside this extracted folder, run `flutter create semester_project`.
2. Copy this package's lib folder into the newly generated semester_project,
   replacing lib/main.dart and merging the folders.
3. Copy this README.md. Keep the generated pubspec.yaml, web/, and .gitignore.
4. Remove the generated test/widget_test.dart (it tests the old counter screen).
5. Update lib/constants/app_constants.dart with the approved title.

## Run the initialized project
Open the generated project root (the folder containing pubspec.yaml).
```sh
flutter pub get
flutter analyze
flutter run -d chrome
```

## Reproduce after GitHub upload
```sh
git clone YOUR_ACTUAL_REPOSITORY_URL
cd semester_project
flutter pub get
flutter run -d chrome
```
If the cloned folder has another name, cd into that actual folder.

## First checkpoint - complete after running and pushing
Date: [actual date]
Commit: [output of git rev-parse HEAD]
Repository: [actual repository URL]
Flutter version: [output of flutter --version]

## Folder responsibilities
main.dart starts the app; app.dart configures theme/navigation.
screens holds pages; widgets holds reusable controls; routes holds route names;
constants holds shared display text. services and models are reserved for future
API clients and data models; .gitkeep preserves these empty folders in Git.
