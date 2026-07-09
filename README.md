# 💅 NailHub

NailHub is a modern iOS application built with SwiftUI that provides a simple and elegant experience for discovering and managing nail salon services.

The project focuses on creating a clean native iOS experience using Apple's latest frameworks, with a scalable architecture, reusable SwiftUI components and a clear separation between UI, business logic and data handling.

The goal of NailHub is to demonstrate modern iOS development practices including SwiftUI, MVVM architecture, asynchronous programming and maintainable project organization.

---

# ✨ Features

* Browse available nail services
* View service categories
* Display detailed information about each service
* Clean and modern SwiftUI interface
* Reactive UI updates using SwiftUI state management
* Asynchronous data loading
* Loading and error state handling
* Reusable UI components
* Scalable MVVM architecture
* Responsive layouts for different iPhone screen sizes

---

# 🛠 Tech Stack

* **Language:** Swift
* **UI Framework:** SwiftUI
* **Architecture:** MVVM (Model-View-ViewModel)
* **Concurrency:** Swift Concurrency (`async/await`)
* **Networking:** URLSession
* **Data Parsing:** Codable
* **Dependency Management:** Swift Package Manager
* **IDE:** Xcode

---

# 📂 Project Structure

```text
NailHub/
  Models/         Data models and domain entities
  Services/       Networking, API communication and application logic
  ViewModels/     Presentation logic and state management
  Views/          Screens and SwiftUI views
                  Home, Categories, Details and reusable UI flows
  Components/     Shared and reusable SwiftUI components
  Theme/          App theme, colors and appearance helpers
  Extensions/     Swift extensions and utility helpers
  Assets.xcassets/ Application images, icons and resources

NailHub.xcodeproj/
```

The project follows a modular structure where each layer has a specific responsibility:

* **Models** contain the application's data representation.
* **Services** handle external communication and business operations.
* **ViewModels** transform data into UI-ready state.
* **Views** are responsible only for presenting information.
* **Components** contain reusable interface elements.

---

# 🏗 Architecture

NailHub follows the **MVVM (Model-View-ViewModel)** architecture pattern.

The architecture separates responsibilities into different layers:

```
        User Interaction
              |
              ▼
          SwiftUI View
              |
              ▼
          ViewModel
              |
              ▼
          Services
              |
              ▼
          Data Source
```

### Model

Responsible for representing application data and domain objects.

### View

Responsible for displaying UI and reacting to state changes.

### ViewModel

Contains presentation logic, manages state and communicates with services.

### Services

Responsible for networking, external data sources and reusable business logic.

---

# ⚙️ How It Works

The application entry point starts in:

```
NailHub/NailHubApp.swift
```

where the SwiftUI application lifecycle is initialized and the root view is configured.

The main application flow begins from:

```
NailHub/ContentView.swift
```

which manages the initial navigation structure of the application.

The user interface is organized inside:

```
NailHub/Views/
```

Each screen communicates with its corresponding ViewModel, which is responsible for preparing and managing the data displayed by the UI.

Data fetching and external communication are handled inside:

```
NailHub/Services/
```

Services encapsulate networking logic and provide clean interfaces for ViewModels.

The typical data flow is:

```
SwiftUI View
      |
      ▼
ViewModel
      |
      ▼
Service Layer
      |
      ▼
API / Local Data
      |
      ▼
Model
```

When data changes, SwiftUI automatically updates the interface through its reactive state management system.

---

# 🗂 Data Model

The application uses domain models to represent the main entities of NailHub.

Example structure:

```
Service
 ├── id
 ├── name
 ├── description
 ├── category
 ├── price
 ├── duration
 └── imageURL


Category
 ├── id
 └── name
```

Models are designed to be simple, reusable and easy to extend with additional functionality.

---

# 🚀 Running the App

## Requirements

* macOS
* Xcode 15+
* iOS 17+
* Swift 5.9+

---

## Installation

Clone the repository:

```bash
git clone https://github.com/Landnis/NailHub.git
```

Navigate into the project:

```bash
cd NailHub
```

Open the project:

```bash
open NailHub.xcodeproj
```

Build and run using:

```
⌘ + R
```

from Xcode.

---

# 📦 Dependencies

NailHub uses Swift Package Manager for dependency management.

Currently the project relies mainly on Apple's native frameworks:

* SwiftUI
* Foundation
* URLSession
* Swift Concurrency

No external dependencies are required unless specified in the project configuration.

---

# 🧪 Testing

The project structure allows easy integration of:

* Unit Tests
* ViewModel tests
* UI Tests

Future improvements can include automated testing coverage for business logic and user flows.

---

# 🔮 Future Improvements

Possible future enhancements:

* User authentication
* Appointment booking system
* Favorites and saved services
* Push notifications
* Local persistence
* Offline mode
* Reviews and ratings
* Localization support
* Unit and UI testing

---

# 📝 Notes

* Built completely with SwiftUI.
* Uses modern iOS development patterns.
* Designed with scalability and maintainability in mind.
* Uses MVVM to keep UI and business logic separated.
* Focuses on reusable components and clean code organization.
* Suitable as a portfolio project demonstrating modern iOS engineering practices.

---

# 👨‍💻 Author

Created by **Landnis**

GitHub:
https://github.com/Landnis/NailHub
