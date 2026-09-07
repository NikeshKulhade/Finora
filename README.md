# Finora

Cross-platform personal finance application built with Flutter and Dart for Android, iOS, and Windows.

## Supabase setup

1. In the Supabase dashboard, open **SQL Editor** and run `supabase/migrations/001_finora_mvp.sql`.
2. Copy the project URL from **Project Settings > API**.
3. Copy the publishable key, or the legacy `anon` public key, from the same page.
4. Run the app with public configuration values:

```powershell
flutter run --dart-define=SUPABASE_URL=https://YOUR_PROJECT.supabase.co --dart-define=SUPABASE_ANON_KEY=YOUR_PUBLIC_KEY
```

The same defines work for Windows, Android, and iOS. The application stays in local demo mode when these values are omitted.

Never place a database password or Supabase `service_role` key in the Flutter application.

## Checks

```powershell
flutter analyze
flutter test
```

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
