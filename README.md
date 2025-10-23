# xedemo

## About

Demo Project for xe property listing

## How to Run

- Pull latest commit from `main` branch
- Open .xcodeproj file
- Build & Run

## Additional Info - Patterns & Methods Used

- SwiftUI for building the UI
- MVVM pattern followed for some additional business Logic apart from View's states.
- Followed Clean Architecture very basics, splitting the App's structure into Presentation, Domain(Service) and Network Layers.
- Swift Concurrency (Async/Await)
- SwiftData is used for local persistence
- Implemented a few basic unit tests using mock DI
 
 ## Libraries/Frameworks added through SPM

- Alamofire Libary (Network)
- SwiftLint (Code Style Linter)
- Swinject (Dependency Nnjection Framework)

## Trade-offs

- Code would need polishing in a real app
- Potential errors from networking or decoding are not handled due to the demo’s purpose
- Could add some more detailed Unit Tests with different logic
- Used boilerplate and unoptimized code for SwiftData & DI Containers etc

## Contact

- Email: sgiatrakis[at]gmail.com
- Linkedin: linkedin.com/in/giatrakis
- Phone: (+30)6983460512
