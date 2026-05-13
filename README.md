Adresse de notre travail: git clone https://github.com/Augustrsc/An2DO_4A.git
    ``
---

# Analyse des données Parcoursup (2025-2026)

[![R](https://img.shields.io/badge/Language-R-blue.svg)](https://www.r-project.org/)
[![Python](https://img.shields.io/badge/Language-Python-yellow.svg)](https://www.python.org/)
[![Course](https://img.shields.io/badge/UE-Analyse_de_Données_(4MA--AD)-red.svg)]()

## 📌 Présentation du projet
Ce projet d'étude vise à explorer les structures latentes et les typologies des formations de l'enseignement supérieur français. En nous appuyant sur les données de la session **Parcoursup 2025-2026**, nous cherchons à modéliser les relations entre attractivité, profil social oou encore répartition géographique.

### ❓ Problématique
> Comment les facteurs de **sélectivité**, de **mixité sociale** ou encore **localisation géographique** structurent-ils l'offre de formation actuelle ? Existe-t-il une cohérence entre les filières déclarées et les classes statistiques obtenues par clustering ?

---

## 🛠️ Organisation du dépôt
Le projet utilise une approche hybride, exploitant les forces respectives de **R** (statistique descriptive et inférentielle) et de **Python** (visualisation spatiale et algorithmes de machine learning).

### 📂 Structure des fichiers & Ordre d'exécution

| Ordre | Environnement | Fichier | Description |
| :--- | :--- | :--- | :--- |
| **1** | 🟦 R | `shared_data.R` | Nettoyage global et préparation du dataset principal. |
| **2** | 🟦 R | `Analyse_Unidimensionnelle` | État des lieux descriptif des variables. |
| **3** | 🟨 Py | `analyse_bidimensionnelle` | Étude des corrélations et croisements de variables. |
| **4** | 🟦 R | `data_GPS` | Traitement spécifique des coordonnées géographiques. |
| **5** | 🟨 Py | `visu_carte` | Cartographie interactive des formations. |
| **6** | 🟦 R | `ACP` | Analyse en Composantes Principales (base pour la suite). |
| **7** | 🟦 R | `LDA` | Analyse Discriminante Linéaire. |
| **8** | 🟨 Py | `CA_MCA` | Analyse des Correspondances (Simple et Multiple). |
| **9** | 🟨 Py | `AD_MFA` | Analyse Factorielle Multiple et Clustering (HAC, K-Means). |
| **10** | 🟦 R | `clustering.ipynb` | *Note : Approche exploratoire sur ACP (moins performante, regarder plutôt le fichier clustering_acm).* |
| **11** | 🟨 Py | `GMM_Python` | Modèles de mélanges gaussiens sur ACP(moins performante, regarder plutôt le fichier clustering_acm). |
| **12** | 🟨 Py | `clustering_acm` | **Cœur du projet** : Comparaison (HAC, K-Means, GMM, Spectral, DBSCAN). |


---

## 🔬 Méthodologies Clés

### 1. Analyses Factorielles
Nous avons privilégié l'**AFM (Analyse Factorielle Multiple)** et l'**ACM (Analyse des Correspondances Multiples)** pour traiter simultanément des variables qualitatives (types de bacs, régions) et quantitatives (taux d'accès, boursiers).

### 2. Stratégies de Clustering
Une attention particulière a été portée à la comparaison des performances de segmentation :
*   **Approches Géométriques :** K-Means et Classification Ascendante Hiérarchique (CAH/HAC).
*   **Approches Densitaires & Probabilistes :** DBSCAN et GMM (Gaussian Mixture Models).
*   **Réduction de dimension :** Clustering effectué post-ACM pour stabiliser les classes.

---

## 🚀 Installation & Utilisation
1.  **Cloner le dépôt** :
    ```bash
    git clone https://github.com/votre-utilisateur/projet-parcoursup.git
    ```
2.  **Configuration R** : Assurez-vous d'avoir installé `FactoMineR` et `explor`.
3.  **Configuration Python** :
    Voici une proposition pour transformer ton brouillon en un **README.md** professionnel, structuré et visuellement agréable. J'ai réorganisé les informations pour mettre en avant la méthodologie et la complémentarité entre R et Python.


*Projet réalisé dans le cadre d'une 4ème année d'école d'ingénieur en Mathématiques Appliquées à l'INSa Toulouse (4MA-AD).*

