# VCardGenerator

A Flutter utility to generate and share vCards. This package allows you to easily create vCards with various fields such as name, organization, phone number, email, address, website, and optionally an image. It also provides a method to share the generated vCard using the `share_plus` package.

## Features

- Generate vCards with essential contact information.
- Optionally include an image in the vCard.
- Share vCards directly from your Flutter app.
- Fully customizable fields.

## Installation

Add the following dependencies to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  path_provider: ^2.0.11
  share_plus: ^6.2.0
