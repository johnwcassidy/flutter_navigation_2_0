# Building A Stack Navigator with Navigation 2.0

This project demonstrates a simple stack navigator using Navigation 2.0. 

[A more detailed explanation can be found here](https://johnwcassidy.medium.com/building-a-simple-stack-navigator-with-flutter-navigation-2-0-f11b55b71520)

The key concepts that this project demonstrates:

- The RouterDelegate implementation is responsible for building the Navigation Widget with the appropriates pages in the stack. Therefore, it is responsible to maintain the state of what is currently in the stack.
- A Data Structure, `PathStack`, is a great way to preserve state while notifying the `MaterialApp.router` of changes to build.
- Providing pages of the Navigator with an interface to interact with the Stack is nicely one by using a `Provider`. I present a delegate pattern here that allows you to nicely receive all events within the RouterDelegate implementation.

## Getting Started

This project is a starting point for a Flutter application.

```
flutter run
```
