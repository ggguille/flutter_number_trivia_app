# Number Trivia APP

### Flutter TDD Clean Architecture Course - ResoCoder

Flutter App to learn about the framework using clean architecture and TDD

[Course Link](https://resocoder.com/category/tutorials/flutter/tdd-clean-architecture/)

#### Dependencies
- [**Equatable**](https://pub.dev/packages/equatable), Simplify Equality Comparisons
    > equatable: ^1.2.3
- [**Dartz**](https://pub.dev/packages/dartz), Functional programming in Dart
    > dartz: ^0.9.1
- [**Data Connection Checker**](https://pub.dev/packages/data_connection_checker), A pure Dart utility library that checks for an internet connection
    > data_connection_checker: ^0.3.4
- [**Shared preferences plugin**](https://pub.dev/packages/shared_preferences), Wraps platform-specific persistent storage for simple data (NSUserDefaults on iOS and macOS, SharedPreferences on Android, etc.).
    > shared_preferences: ^0.5.8
- [**Connectivity**](https://pub.dev/packages/connectivity), This plugin allows Flutter apps to discover network connectivity and configure themselves accordingly. It can distinguish between cellular vs WiFi connection.
    > connectivity: ^0.4.9
- [**HTTP**](https://pub.dev/packages/http), A composable, Future-based library for making HTTP requests.
    > http: ^0.12.2
- [**BLoC**](https://pub.dev/packages/flutter_bloc), Widgets that make it easy to integrate blocs and cubits into Flutter
    > flutter_bloc: ^6.0.1

#### Dev Dependencies
- [**Mockito**](https://pub.dev/packages/mockito), Mock library for Dart inspired by Mockito.
    > mockito: ^4.1.1
- [**BLoC Test**](https://pub.dev/packages/bloc_test), A Dart package that makes testing blocs and cubits easy
    > bloc_test: ^7.0.0


##### Numbers API [Link](http://numbersapi.com/#42)
>  *NUMBERS API*, An API for interesting facts about numbers

Example of use: *http://numbersapi.com/42?json*

__response.json__
```json
{
    "text": "42 is the answer to the Ultimate Question of Life, the Universe, and Everything.",
    "number": 42,
    "found": true,
    "type": "trivia"
}
```
__not_found.json__
```json
{
    "text": "123456 is an unremarkable number.",
    "number": 123456,
    "found": false,
    "type": "trivia"
}
```


