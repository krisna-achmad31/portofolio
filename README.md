# Achmad Yukrisna · Portfolio

Personal portfolio built with **Flutter Web** — featuring my work in mobile engineering and hardware integration (BLE, RFID, POS, IoT).

🌐 **Live:** [https://krisna-achmad31.github.io/portofolio/](https://krisna-achmad31.github.io/portofolio/)

---

## Tech Stack

- **Flutter Web** (3.24+)
- **Material 3** with custom dark theme
- **Google Fonts** (Space Grotesk + Inter)
- **flutter_animate** for entrance animations
- **GitHub Actions** for CI/CD auto-deploy

---

## Run Locally

```bash
# Clone the repo
git clone https://github.com/krisna-achmad31/portofolio.git
cd portofolio

# Install dependencies
flutter pub get

# Run in browser
flutter run -d chrome

# Or build for production
flutter build web --release
```

The production build will be in `build/web/`.

---

## Deploy to GitHub Pages

### One-time setup

1. Push this code to the `main` branch of your `portofolio` repo.
2. Go to **Settings → Pages** in your GitHub repository.
3. Under "Build and deployment", set **Source** to **GitHub Actions**.
4. The site will auto-deploy on every push to `main`.

---

## License

© 2026 Achmad Yukrisna A. Personal portfolio code.
