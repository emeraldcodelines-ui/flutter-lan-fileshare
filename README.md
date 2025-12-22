# Flutter LAN File Share

A simple, cross-platform Flutter Windows application for sharing files over Wi‑Fi/LAN using the [lan_web_server](https://pub.dev/packages/lan_web_server) package.

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Flutter](https://img.shields.io/badge/flutter-3.19+-blue.svg)

## ✨ Features

- **One‑click LAN server** – Start a local file‑sharing server with a single button.
- **Built‑in web UI** – Upload, download, delete, and browse files/folders via a modern web interface.
- **Folder picker** – Choose any directory on your Windows machine to share.
- **QR code & direct link** – Quickly access the server from other devices.
- **Real‑time status** – See the server’s IP address, port, and running state.
- **Cross‑platform ready** – Built with Flutter, the core logic can be extended to macOS, Linux, Android, and iOS.

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 3.19 or higher)
- [Git](https://git-scm.com/)
- A Windows machine (or any platform with Flutter desktop support)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/emeraldcodelines-ui/flutter-lan-fileshare.git
   cd flutter-lan-fileshare
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run -d windows
   ```

   *(Replace `windows` with your target platform if needed.)*

## 📦 Project Structure

```
flutter-lan-fileshare/
├── lib/
│   ├── main.dart          # App entry point
│   └── pages/
│       └── web_server_page.dart  # Main UI with server controls
├── pubspec.yaml           # Dependencies & metadata
├── README.md              # This file
└── .gitignore             # Git ignore rules
```

## 🖥️ Usage

1. Launch the app.
2. Click **“Choose Folder”** to select a directory you want to share.
3. Press **“Start Server”** – the app will display your local IP and port (e.g., `http://192.168.1.10:8080`).
4. Open the link in any browser on the same network, or scan the QR code with your phone.
5. Use the web interface to upload, download, or delete files.
6. Tap **“Stop Server”** when you’re done.

## 🔧 Building for Release

To create a standalone Windows executable:

```bash
flutter build windows
```

The output will be in `build/windows/runner/Release/`.

## 🤝 Contributing

Contributions are welcome! If you have ideas for improvements, new features, or bug fixes:

1. Fork the repository.
2. Create a feature branch (`git checkout -b feature/amazing-idea`).
3. Commit your changes (`git commit -m 'Add some amazing idea'`).
4. Push to the branch (`git push origin feature/amazing-idea`).
5. Open a Pull Request.

## 📄 License

This project is licensed under the MIT License – see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgements

- [lan_web_server](https://pub.dev/packages/lan_web_server) – The excellent LAN file‑sharing package that powers this app.
- [Flutter](https://flutter.dev) – For making cross‑platform desktop development a breeze.

---

*If you enjoy this project, give it a ⭐ on GitHub!*