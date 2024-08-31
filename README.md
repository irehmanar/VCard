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
Usage
Basic Usage
To generate and share a vCard, use the VCardGenerator class as shown below:

dart
Copy code
import 'package:flutter/material.dart';
import 'VCardGenerator.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('VCard Generator')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            String vCardContent = await VCardGenerator.generateVCard(
              name: "John Doe",
              organization: "Example Corp.",
              workPhone: "123-456-7890",
              email: "john.doe@example.com",
              address: "123 Main St, Anytown, USA",
              website: "https://example.com",
            );

            await VCardGenerator.shareVCard(
              vCardContent: vCardContent,
              context: context,
              name: "JohnDoe",
            );
          },
          child: Text('Generate and Share VCard'),
        ),
      ),
    );
  }
}
Full Example
Here's a more comprehensive example using a form to gather vCard details from the user:

dart
Copy code
import 'package:flutter/material.dart';
import 'dart:io';
import 'VCardGenerator.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController organizationController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  File? imageFile;  // Optional: File to hold the selected image

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('VCard Generator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: fullNameController, decoration: InputDecoration(labelText: 'Full Name')),
            TextField(controller: organizationController, decoration: InputDecoration(labelText: 'Organization')),
            TextField(controller: phoneController, decoration: InputDecoration(labelText: 'Phone Number')),
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: addressController, decoration: InputDecoration(labelText: 'Address')),
            TextField(controller: websiteController, decoration: InputDecoration(labelText: 'Website')),
            ElevatedButton(
              onPressed: () async {
                String vCardContent = await VCardGenerator.generateVCard(
                  name: fullNameController.text,
                  organization: organizationController.text,
                  workPhone: phoneController.text,
                  email: emailController.text,
                  address: addressController.text,
                  website: websiteController.text,
                  imageFile: imageFile,
                );

                await VCardGenerator.shareVCard(
                  vCardContent: vCardContent,
                  context: context,
                  name: fullNameController.text,
                );
              },
              child: Text('Generate and Share VCard'),
            ),
          ],
        ),
      ),
    );
  }
}
Error Handling
The shareVCard method includes basic error handling that displays a SnackBar in case of any issues during the vCard generation or sharing process.

markdown
Copy code

### Key Adjustments:
- The language in the code blocks was corrected from `yaml` to `dart` for the code examples.
- Consistency in using backticks for class names and method names.
- Slight formatting changes for clarity and standardization.