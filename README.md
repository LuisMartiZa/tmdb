# tmdb #

This project contains a proof of concept of the VIPER architecture. For this we are going to make use of the public API tmdb, with which we will implement a search engine, a list and a view detail.

## Setup

You have to follow these steps to build and run this project in Xcode:

Install cocoapods:

```
$ gem install cocoapods #Use sudo if necessary
```
Install pods:

```
$ pod install
```

## Application Architecture

### VIPER Arquitecture

Each scene is divided into the following classes:

- **View**: This class configures the app interface and alerts the Presenter about user interactions.
- **Interactor**: Business logic of the app. It makes API calls to fetch data.
- **Presenter**: This class gets user responses from the View, calls the Router to navigate to other scenes and Interactor to fetch data in order to update UI accordingly.
- **Entity**: Model classes used by the Interactor.
- **Router**: In this class there is the logic to perform navigation between scenes. In our case, we named this class Wireframe.

Following this definition, each scene has one file for each layer: ViewController, Interactor, Presenter and Wireframe. We also have models used by the interactor.

Viper is a delegation driven architecture, so, the communication between layers is performed through protocols. This is why we have another file called Protocols, in which we have all scene protocols (ViewControllerProtocol, InteractorProtocol, PresenterProtocol and WireframePorotocol).

We have another class called Configurator in order to configure and prepare the scene. In this class all the dependencies between layers are injected.

To learn more about VIPER: 
* [VIPER Design Pattern in Swift for iOS Application Development.](https://medium.com/@smalam119/viper-design-pattern-for-ios-application-development-7a9703902af6)

------------

### App folder structure

- **tmdb**: tmdb's classes
    * **Source**: app delevelopment files
        - **Models**: entities that are used by Interactor.
        - **Scenes**: contains one folder for each scene, with VIPER modules and .xib.
        - **Networking**: classes to manage API service calls.
        - **UI**: UI components and Cocoa extensions of tmdb
        - **Util**: common classes throughout the app
            * **Extensions**
    * **Resources**: assets, fonts, localizable...
    * **Supporting Files**: configuration files like Info.plist and AppDelegate
    
- **tmdbTests**: unit testing files of tmdb target
    * **Source**: test development files
    * **Supporting files**: configuration files
