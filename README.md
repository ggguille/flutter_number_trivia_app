# Number Trivia APP

### Flutter TDD Clean Architecture Course - ResoCoder

Flutter App to learn about the framework using clean architecture and TDD

[Course Link](https://resocoder.com/category/tutorials/flutter/tdd-clean-architecture/)

#### Dependencies
- [**Equatable**](https://pub.dev/packages/equatable), Simplify Equality Comparisons
    > equatable: ^1.2.3

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


