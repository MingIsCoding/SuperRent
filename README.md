# SuperRent
An iOS application for rental information posting &amp; searching written in Swift.

Made with ❤️.

We used [Carthage](https://github.com/Carthage/Carthage) (a simple, decentralized dependency manager for Cocoa) to manage dependencies for this project.

##### Dependency libraries

+ [Eureka](https://github.com/xmartlabs/Eureka): a library to create dynamic table-view forms from a [DSL] specification in Swift.
+ [Notie](https://github.com/thii/Notie): in-app notification in Swift, with customizable buttons and input text field.
+ [Parse](https://github.com/ParsePlatform/Parse-SDK-iOS-OSX): a library that gives you access to the powerful Parse cloud platform from your iOS or OS X app.
+ [LocationPicker](https://github.com/JeromeTan1997/LocationPicker): a library for ready-to-use and fully customizable location picker.
+ [Linear Progress Bar](https://github.com/PhilippeBoisney/LinearProgressBar): a simple Linear Progress Bar for IOS (Swift 2.0), inspired by Material Design.

##### Instructions

To run this project, Carthage should be first installed using [Homebrew](http://brew.sh/). In terminal:

```ogdl
brew install Carthage
```

Then locate to the project directory, issue:

```
carthage update
```

This will fetch dependencies into a (project_path)/Carthage/Checkouts folder and build each one. Built .framework files can be found in (project_path)/Carthage/Build/iOS/ folder.

Note that LocationPicker library can only be compiled for an actualy iOS device and not emulators.
