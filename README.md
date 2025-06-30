# MatchDay-iOS

Ce dossier contient la réécriture iOS native (Swift/SwiftUI) de l'application MatchDay.

## Structure proposée

- `MatchDayApp.swift` : point d'entrée de l'application SwiftUI
- `Assets.xcassets/` : images et icônes
- `Fonts/` : polices personnalisées
- `Models/` : modèles de données (Team, Match, etc.)
- `Services/` : gestion API, notifications, stockage
- `ViewModels/` : logique de chaque écran (MVVM)
- `Views/` : tous les écrans (Accueil, Menu, Paramètres, etc.)
- `Resources/` : fichiers de traduction, etc.

## Fonctionnalités à venir
- Authentification via token PandaScore
- Gestion des équipes favorites
- Affichage des prochains matchs
- Notifications locales
- Navigation multi-écrans

---

**⚠️ À FAIRE dans Xcode :**
- Ajouter les couleurs personnalisées `HeaderBg` et `Background` dans le dossier `Assets.xcassets` (sinon l'app plantera au lancement).
- Pour cela, clique droit sur `Assets.xcassets` > New Color Set > renomme en `HeaderBg` puis configure la couleur, idem pour `Background`.

Pour toute question ou suggestion, voir le projet React Native d'origine dans le dossier principal. 