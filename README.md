# Campus News App

A Flutter starter app for college students to read campus announcements and student updates.

## Features
- Campus feed with event, academics, placements, clubs and general categories
- Search announcements
- Announcement details
- Add an announcement through a validated form
- Save/bookmark announcements
- Provider state management and SharedPreferences local persistence

## Demo data
The initial announcements are fictional sample content for demonstrating the app. They are not official notices from any real college and are not fetched from a live college portal or API. Replace them with verified campus information before presenting this as an official notice app.

## Requirements
- Flutter stable (Dart null safety)
- Android Studio with Flutter and Dart plugins
- JDK 17 / Android SDK

## Run
```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

## Build Android APK
```bash
flutter build apk --release
```
APK output: `build/app/outputs/flutter-apk/app-release.apk`

## Screens
1. Campus Feed
2. Announcement Details
3. Add Announcement
4. Saved Announcements

## Architecture
- `models/`: announcement model
- `services/`: SharedPreferences persistence
- `providers/`: ChangeNotifier application state
- `screens/`: feed, details, add form and saved list
- `widgets/`: reusable announcement card

## Team responsibilities
Update this section with each member's name and the screen/feature they implemented. Every member should make genuine commits and be able to explain their contribution.

## Before submission
- Test on a physical Android phone.
- Check empty, long-text, offline and repeated-tap behaviour.
- Replace fictional sample notices with verified data or clearly label user-created content.
- Add at least three screenshots and record known defects below.

## Defect log
| Defect | Status | Notes |
|---|---|---|
| Add defects found during testing | Open | Update after testing |
