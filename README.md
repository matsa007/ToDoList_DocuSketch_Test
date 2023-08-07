# Todo List App

![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)
![Platform](https://img.shields.io/badge/platform-iOS-lightgrey.svg)
![CocoaPods](https://img.shields.io/cocoapods/v/SnapKit.svg)

## Todo List App Screenshots

![Todo List App Screenshot](https://github.com/matsa007/ToDoList_DocuSketch_Test/blob/main/readme_screenshots/1.png)


## Description

A simple Todo List application to manage your tasks. You can add, edit, and delete tasks. This app is built using Swift language and SnapKit library for convenient UI layout.

## Features

- Add new tasks
- Edit existing tasks
- Delete tasks
- Mark task as finished
- Saving

## Requirements

- iOS 12.0+
- Xcode 12.0+


## Installation

1. Clone repository:
```
git clone https://github.com/your-username/todo-list-app.git
cd todo-list-app
```
2. CocoaPods is a dependency manager for Cocoa projects. You can install it with the following command:
```
$ sudo gem install cocoapods

```
3. To integrate SnapKit into your Xcode project using CocoaPods, specify it in your `Podfile`:
```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'SnapKit', '~> 5.0.0'
end
```
Then, run the following command:
```
$ pod install
```
4. Open `ToDoList_DocuSketch_Test.xcworkspace` file in Xcode:
```
$ open ToDoList_DocuSketch_Test.xcworkspace
```
5. Select the target device or simulator from the top-left dropdown menu.

6. Click the "Run" button or use the shortcut `Cmd + R` to build and run.

## Using SnapKit

This application utilizes SnapKit for a more convenient and declarative approach to creating layout constraints for the interface. For example, to add a view with automatic constraint creation, use the following code:
```
import SnapKit

let myView = UIView()
self.view.addSubview(myView)

myView.snp.makeConstraints { make in
    make.top.equalToSuperview().offset(20)
    make.left.equalToSuperview().offset(16)
    make.right.equalToSuperview().offset(-16)
    make.height.equalTo(50)
}
```
With SnapKit, you can define constraints easily and efficiently, making your UI layout code cleaner and more maintainable.
