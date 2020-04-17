# Djustin

![Dart CI](https://github.com/masich/djustin/workflows/Dart%20CI/badge.svg)
[![CodeFactor](https://www.codefactor.io/repository/github/masich/djustin/badge)](https://www.codefactor.io/repository/github/masich/djustin)
[![License](https://img.shields.io/badge/License-MIT-red.svg)](LICENSE)
[![Pub](https://img.shields.io/pub/v/djustin.svg)](https://pub.dartlang.org/packages/djustin)


Djustin is a library for Dart programming language that helps to interact with 
[Justin Delivery Service](https://justin.ua/) using its [OpenAPI](https://openapi.justin.ua/). 
It works fine with Dart and Flutter applications, but it is assumed that the other platforms (such as web and server) 
will also haven't problems with Djustin.

## Features
* Fast and simple
* Only one dependency (```package:http```)
* Supports Flutter
* Provides all the functionality of the **Justin OpenAPI**

## Supported requests
Library provides an ability to receive the following information from the Justin Service:
* Branches
    * Info about all branches
    * Info about branch by number
    * Info about branches by urban area
    * Info about the nearest branches
* Tracking
    * Tracking info by the tracking number
    * Tracking history by the tracking number
* Info about branch types
* Info about all urban areas in Justin network
* Info about available services

## Getting started
First, add the following dependency to your ```pubspec.yaml```:

```yaml
dependencies:
  djustin: ^0.2.1
```

Then import the library:

```dart
import 'package:djustin/djustin.dart';
```

and just use it.

The [example](example/djustin_example.dart) of simple usage.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.