# Random Quotes App


https://github.com/Nsquik/RandomQuotes/assets/46610139/f5c432c8-44ff-478f-94c6-3eed29d29d4d

It was meant to be named `Breaking Bad Quotes`, but changed during the process 😄

## Introduction

Random Quotes is my first encounter with Swift and SwiftUI, as I decided to self-learn the Apple's ecosystem. The main focus of Random Quotes App is to fetch and display random quotes from various APIs, providing users with an interactive interface to browse and save their favorite quotes.

Throughout the development of Random Quotes, I had the opportunity to immerse myself in the Swift programming language and dive into the world of SwiftUI. Great experience so far!


For TV Series that will serve as quotes mine I picked my three beloved ones:

- Game of Thrones
- Breaking Bad
- Better Call Saul


## APIs used

- Game of Thrones Quotes: https://api.gameofthronesquotes.xyz/v1/
- Game of Thrones Characters: https://thronesapi.com/api/v2/
- Breaking Bad: https://breaking-bad-api-six.vercel.app/api
- Better Call Saul: https://breaking-bad-api-six.vercel.app/api

Thank you, whoever created those APIs 🖤

## Technologies Used

Random Quotes utilizes the following technologies and frameworks:

- SwiftUI: 
A modern UI framework that simplifies the development of user interfaces across Apple devices.

- Swift: 
The programming language that drives the application. Random Quotes served as my introduction to Swift, and I quickly fell in love with its safety, expressiveness, and powerful features throughout the development process.

- Core Data:
 A framework provided by Apple for data persistence in iOS applications. Core Data was instrumental in implementing the functionality to save and retrieve favorite quotes effortlessly. 
Wasn't super intuitive to develop to be honest.

## Architectural Patterns Used:

The main theme is `Model-View` Pattern. Following this guide: https://developer.apple.com/forums/thread/699003 I decided that it will be my best bet.

In my understaing model is not just a plain Data objects, that don't have any methods on them. Model is a set of CONCRETE rules that the UI app just takes.
That makes `Model` enough for `ViewModel` to not be necessary in my case :)
So it splits:
- Model: Everything that contains business logic. Data models, fetching data, computing data, persisting data, exposing data, mapping data. Model should be independant of UI layer.
- View: Everything UI related that user can see/ touch. Draws business logic from MODEL layer. Can combine business logic into View logic. Can contain own UI logic.

I found MVVM to be extravagance in my case, as it's relatively small app.

## Features

Random Quotes offers the following features:

- Fetching random quotes from various APIs.
- Saving & removing favorite quotes for future reference.
- Providing a dedicated screen to view and manage saved quotes.


## Future Improvements

While Random Quotes has been an incredible learning experience, there are several areas I would focus on improving if I were to continue its development in a real-world scenario:

- Enhance error handling and provide meaningful error messages to enhance the user experience.
- Rearrange the user interface, it was not my goal while working on this project.
- Optimize performance by implementing caching mechanisms to minimize network requests.
- ADD TESTS 🧪
