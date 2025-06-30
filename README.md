# MatchDay-iOS

Ce dossier contient la réécriture iOS native (Swift/SwiftUI) de l'application MatchDay.

---

## 🚀 Installation rapide

1. **Cloner le dépôt**
   ```bash
   git clone https://github.com/Daruiii/MatchDay-IOS.git
   cd MatchDay-IOS
   ```
2. **Ouvrir dans Xcode**
   - Ouvre le dossier dans Xcode (`Fichier > Ouvrir...` ou double-clique sur le projet).
3. **Ajouter les couleurs personnalisées**
   - Ouvre `Assets.xcassets` dans Xcode.
   - Clique droit > `New Color Set` > renomme en `HeaderBg` puis configure la couleur.
   - Refais la même chose pour `Background`.
   - (Tu peux choisir les couleurs que tu veux, par exemple un bleu foncé pour `HeaderBg` et un gris clair pour `Background`.)
4. **Lancer l'application**
   - Sélectionne un simulateur ou ton appareil, puis clique sur ▶️ (Run).

> ⚠️ **Important** : Si tu n'ajoutes pas les couleurs `HeaderBg` et `Background`, l'app plantera au lancement !

---

## 📱 Fonctionnalités principales
- Authentification via token PandaScore
- Gestion des équipes favorites
- Affichage des prochains matchs
- Notifications locales (programmables)
- Navigation multi-écrans (Accueil, Menu, Détail équipe, Paramètres)

---

## 🗂️ Structure du projet

- `MatchDayApp.swift` : point d'entrée de l'application SwiftUI
- `Models/` : modèles de données (`Team`, `Match`, etc.)
- `Services/` : gestion API, notifications, stockage local
- `ViewModels/` : logique de chaque écran (MVVM)
- `Views/` : tous les écrans (Accueil, Menu, Paramètres, etc.)
- `Assets.xcassets/` : images et couleurs (à compléter dans Xcode)
- `Fonts/` : polices personnalisées (si besoin)
- `Resources/` : fichiers de traduction, etc. (optionnel)

---

## 🖼️ Exemple de capture d'écran

> Ajoute ici une capture d'écran de l'app (optionnel)

---

## 🤝 Contribuer

1. Fork le repo
2. Crée une branche (`git checkout -b feature/ma-feature`)
3. Commits tes modifs (`git commit -am 'Ajout de ma feature'`)
4. Push la branche (`git push origin feature/ma-feature`)
5. Ouvre une Pull Request

---

## 📝 .gitignore recommandé

Ajoute un fichier `.gitignore` à la racine avec le contenu suivant pour éviter de pousser les fichiers inutiles générés par Xcode :

```
# Xcode
build/
DerivedData/
*.xcuserstate
*.xcworkspace/xcuserdata/
*.xcworkspace/xcshareddata/WorkspaceSettings.xcsettings
*.xcworkspace/xcshareddata/WorkspaceSettings.xcsettings
*.xcuserdatad/
*.DS_Store
```

---

## ℹ️ Notes
- Le projet ne peut pas être lancé/testé sur Linux (SwiftUI et les frameworks Apple ne sont pas disponibles).
- Pour toute question ou suggestion, voir le projet React Native d'origine dans le dossier principal.

---