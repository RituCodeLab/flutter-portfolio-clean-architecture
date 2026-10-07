# Flutter Portfolio — Clean Architecture + BLoC

A reusable Flutter portfolio template for developer portfolios. The project separates portfolio data, domain contracts, application state, presentation and theme/design tokens.

## Package

```text
flutter_portfolio_clean_architecture
```

## Architecture

```text
lib/
├── core/
│   ├── config/
│   ├── theme/
│   └── widgets/
├── data/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── presentation/
│   ├── bloc/
│   ├── pages/
│   └── widgets/
└── main.dart
```

## Data flow

```text
PortfolioPage → PortfolioBloc → GetPortfolio → PortfolioRepository → PortfolioRepositoryImpl → PortfolioModel → Domain Entities
```

The UI does not know whether portfolio data comes from local data, JSON, an API, Firebase, a CMS or another source.

## Make it your own

Replace the profile, skills, experience, projects and contact data in the data/domain side of the project. Do not put personal portfolio content directly into presentation widgets.

### Theme

Keep colors, typography and reusable visual tokens in `lib/core/theme/`. Rebrand the template from the centralized theme rather than scattering raw colors through widgets.

### CV

Place the CV at `assets/cv/your_cv.pdf`, register it in `pubspec.yaml`, and use `PortfolioConfig.cvAssetPath` instead of duplicating the path.

### Navigation

The page owns section scrolling. Navigation widgets expose callbacks such as `onHome`, `onSkills`, `onExperience`, `onProject` and `onContactUs`.

### BLoC

BLoC owns application state and user-driven state changes. Keep layout, colors, typography and personal content outside BLoC.

## Responsive design

The template targets mobile, tablet and desktop. Prefer `LayoutBuilder`, `ConstrainedBox`, `Expanded`, `Flexible` and `Wrap` over fixed viewport assumptions.

## Add a new section

Follow the same separation:

```text
domain/     entity
data/       model + repository implementation
presentation/widget
```

Add a BLoC only when the section actually needs application state.

## Run

```bash
flutter pub get
flutter run -d chrome
```

## Analyze and build

```bash
flutter analyze
flutter build web --release
```

The release output is `build/web/`.

## Publishing checklist

- [ ] Replace profile data
- [ ] Replace skills
- [ ] Replace experience
- [ ] Replace projects
- [ ] Replace contact information
- [ ] Add CV
- [ ] Update theme
- [ ] Update favicon and browser metadata
- [ ] Test mobile/tablet/desktop
- [ ] Test navigation and external links
- [ ] Test CV download
- [ ] Run `flutter analyze`
- [ ] Build release web version

## Design principle

```text
Portfolio content → Data / Domain
Application state → BLoC
Presentation → Widgets / Pages
Visual tokens → Theme
```

This keeps the reusable portfolio UI separate from the information belonging to one developer.

## License

Add your preferred license before distributing the template publicly.
