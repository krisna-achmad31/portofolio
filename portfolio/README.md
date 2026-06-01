# Achmad Yukrisna · Portfolio

Personal portfolio built with **Flutter Web** — featuring my work in mobile engineering and hardware integration (BLE, RFID, POS, IoT).

🌐 **Live:** [https://achmadyukrisna.github.io/portfolio](https://achmadyukrisna.github.io/portfolio) *(after deployment)*

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
git clone https://github.com/achmadyukrisna/portfolio.git
cd portfolio

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

1. **Create a new GitHub repo** named `portfolio` (or whatever you prefer — see note below)
2. Push this code to the `main` branch
3. Go to **Settings → Pages**
4. Under "Build and deployment", set **Source** to **GitHub Actions**
5. Push any commit to `main` → GitHub Actions will auto-deploy

### Important: base-href configuration

In `.github/workflows/deploy.yml`, line 28:
```yaml
run: flutter build web --release --base-href "/portfolio/"
```

The `/portfolio/` part **must match your repo name**.

- If your repo is `achmadyukrisna/portfolio` → use `/portfolio/`
- If your repo is `achmadyukrisna/my-site` → use `/my-site/`
- If your repo is `achmadyukrisna/achmadyukrisna.github.io` (root user site) → use `/`

### Custom domain (optional, ~$10/year)

1. Buy domain from Namecheap / Cloudflare (e.g. `krisna.dev`)
2. In repo settings → Pages → Custom domain → enter your domain
3. Add CNAME record at your registrar pointing to `achmadyukrisna.github.io`
4. Update `--base-href "/"` in deploy.yml (root for custom domain)

---

## Customization Quick Reference

| What to change | Where |
|----------------|-------|
| Personal name, headline, bio | `lib/home_page.dart` → `_HeroSection`, `_AboutSection` |
| Projects list | `lib/data.dart` → `kProjects` |
| Skills | `lib/data.dart` → `kSkills` |
| Color scheme | `lib/theme.dart` → `AppTheme` |
| Contact info | `lib/home_page.dart` → `_ContactSection` |

---

## Project Structure

```
portfolio/
├── lib/
│   ├── main.dart          # App entry
│   ├── theme.dart         # Colors, typography
│   ├── data.dart          # Projects & skills data
│   └── home_page.dart     # Main page with all sections
├── web/
│   └── index.html         # Web entry point
├── .github/workflows/
│   └── deploy.yml         # Auto-deploy CI/CD
└── pubspec.yaml
```

---

## Sections

1. **Hero** — name, headline, status badge, key stats
2. **About** — mission + Engineering Edge (ITS background)
3. **Featured Work** — 3 hardware-integration projects (RFID, IoT Stadium, NoTo Labs)
4. **More Work** — 9 other shipped projects across industries
5. **Tech Stack** — skill categories (Mobile, Hardware, Architecture, etc.)
6. **Contact** — email, WhatsApp, LinkedIn

---

## License

© 2026 Achmad Yukrisna A. Personal portfolio code — free to reference, do not reuse content without permission.
