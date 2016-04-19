# Raccoon

[![CI Status](http://img.shields.io/travis/Stefano Mondino/Raccoon.svg?style=flat)](https://travis-ci.org/Stefano Mondino/Raccoon)
[![Version](https://img.shields.io/cocoapods/v/Raccoon.svg?style=flat)](http://cocoapods.org/pods/Raccoon)
[![License](https://img.shields.io/cocoapods/l/Raccoon.svg?style=flat)](http://cocoapods.org/pods/Raccoon)
[![Platform](https://img.shields.io/cocoapods/p/Raccoon.svg?style=flat)](http://cocoapods.org/pods/Raccoon)

**Raccoon** is a Swift µframework created to help development of  Model-View-ViewModel (**MVVM**) iOS applications.

##STILL UNDER DEVELOPMENT!


##The MVVM pattern
**MVVM** (Model-View-ViewModel) is a design pattern that comes from Microsoft (!). Compared to MVC (Model-View-Controller) it lets you to write better, cleaner and, most of all, **reusable** code in your iOS projects.
There are plenty of tutorials/blog-posts/code-examples online (see the References section below for some of them), but lets review some of the key features:

* **No Controller layer**: Controller layer is gone and is "replaced" by ViewModel. In iOS applications, we can consider UIView and UIViewController as part of the View layer
* **One way ownership**: View owns ViewModel, ViewModel owns Model. View will never know that the Model layer ever existed. 
* **Data binding**: since Model doesn't hold references to any ViewModel, any state change is reported back to its owner by **observation**. Same thing happens between ViewModel and View. Observation can be made by using some cool frameworks like **ReactiveCocoa**.
* **ViewModel = state of the View**: Everything that the View is going to display should be handled and prepared by the ViewModel so that the View becomes a sort of *viewer of readymade properties*

##The iOS App common scenario

Basic structure of an iOS app never changes. You have some data to obtain, process and eventually display to the final user.
Usually you start from some kind of data that needs to be listed until you choose one of many items to display its content. It's quite easy to subdivide an app workflow in many sub-scenarios like this, maybe it's over-simplified but it's really effective.

TODO
- finish collection view with section headers/footers
- tableview
- stackview
- manage loading state
- listviewmodel/cellviewmodel -> better undestanding 

 
## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

Raccon requires iOS 8.0 or greater.
ReactiveCocoa 4 is a required dependency

## Installation

Raccoon is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Raccoon"
```

## Roadmap

## References
[https://www.objc.io/issues/13-architecture/mvvm/](https://www.objc.io/issues/13-architecture/mvvm/)

## Author

Stefano Mondino, stefano.mondino.dev@gmail.com

## License

Raccoon is available under the MIT license. See the LICENSE file for more info.


