
# Mouse Graph App

A Flutter application that visualizes mouse click intensity and vertical movement in real-time using interactive graphs. Ideal for analyzing mouse behavior or creating engaging data visualizations.

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
  - [Click Intensity Page](#click-intensity-page)
  - [Vertical Movement Page](#vertical-movement-page)
- [Navigation](#navigation)
- [Screenshots](#screenshots)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Features

- **Real-Time Graphs**: Visualize mouse click intensity and vertical movement over time.
- **Interactive Interface**: Start, stop, and clear data tracking with intuitive controls.
- **Customizable Graphs**: Smooth curves, adjustable decay rates, and responsive design.
- **NavigationRail Menu**: Side navigation for easy access to different data visualization pages.
- **Cross-Platform**: Runs on Windows, macOS, Linux, Android (with mouse support), and iOS (limited mouse support).

## Getting Started

### Prerequisites

- **Flutter SDK**: [Install Flutter](https://flutter.dev/docs/get-started/install) on your development machine.
- **Dart SDK**: Included with Flutter.
- **Git**: [Install Git](https://git-scm.com/downloads) for cloning the repository.
- **A Mouse Device**: Bluetooth or USB mouse connected to your device.

### Installation

1. **Clone the Repository**

   ```bash
   git clone https://github.com/yourusername/mouse-graph-app.git
   ```

2. **Navigate to the Project Directory**

   ```bash
   cd mouse-graph-app
   ```

3. **Get Dependencies**

   ```bash
   flutter pub get
   ```

4. **Run the App**

   ```bash
   flutter run
   ```

   - **For a specific device** (e.g., Windows):

     ```bash
     flutter run -d windows
     ```

## Usage

### Click Intensity Page

- **Purpose**: Visualizes the intensity of mouse clicks over time with a decaying effect.
- **Controls**:
  - **Start**: Begins tracking mouse clicks and updating the graph.
  - **Stop**: Pauses the tracking without clearing existing data.
  - **Clear**: Resets the graph and clears all data points.
- **Interaction**:
  - Click within the app window to generate intensity spikes on the graph.
  - The intensity decays smoothly over time, simulating a gradient decline.

### Vertical Movement Page

- **Purpose**: Tracks and displays the vertical movement of the mouse cursor over time.
- **Controls**:
  - **Start**: Begins tracking vertical mouse movements.
  - **Stop**: Pauses tracking without clearing data.
  - **Clear**: Resets the graph and clears all data points.
- **Interaction**:
  - Move the mouse vertically within the app window to see the movement reflected on the graph.
  - The graph updates continuously, even when the mouse is stationary.

## Navigation

- **NavigationRail Menu**: Located on the left side of the app, providing easy access to different pages.
  - **Click Intensity**: Navigate to the Click Intensity visualization.
  - **Vertical Movement**: Navigate to the Vertical Movement visualization.
- **Selected Item Format**: The selected navigation item displays both an icon and a label side by side for clarity.

## Screenshots

*Add screenshots of your app here to showcase the UI and features. Place images in a `screenshots` directory and reference them in this section.*

```markdown
![Click Intensity Page](screenshots/click_intensity.png)
![Vertical Movement Page](screenshots/vertical_movement.png)
```

## Contributing

Contributions are welcome! Please follow these steps:

1. **Fork the Repository**

   Click on the 'Fork' button at the top right corner of this page.

2. **Clone Your Fork**

   ```bash
   git clone https://github.com/yourusername/mouse-graph-app.git
   ```

3. **Create a Feature Branch**

   ```bash
   git checkout -b feature/YourFeatureName
   ```

4. **Commit Your Changes**

   ```bash
   git commit -am 'Add some feature'
   ```

5. **Push to the Branch**

   ```bash
   git push origin feature/YourFeatureName
   ```

6. **Open a Pull Request**

   Go to the original repository and open a pull request to the `main` branch.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

For questions or suggestions, please contact:

- **Your Name**
- **Email**: [zafaraz26@gmail.com](mailto:zafaraz26@gmail.com)
- **GitHub**: [ZafarFaraz](https://github.com/ZafarFaraz)

---
