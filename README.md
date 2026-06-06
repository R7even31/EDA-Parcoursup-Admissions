# Adresse de notre travail:
https://github.com/R7even31/EDA-Parcoursup-Admissions
    
---

# Analyse des données Parcoursup (2025-2026)

[![R](https://img.shields.io/badge/Language-R-blue.svg)](https://www.r-project.org/)
[![Python](https://img.shields.io/badge/Language-Python-yellow.svg)](https://www.python.org/)
[![Course](https://img.shields.io/badge/UE-Analyse_de_Données_(4MA--AD)-red.svg)]()

## 📌Vue d'ensemble
Ce depot rassemble notre projet d'analyse de donnees realise avec Augustin Traissac et Corentin Brandam dans le cadre de la 4e annee d'ingenieur en mathematiques appliquees a l'INSA Toulouse.


Nous cherchons a mettre en evidence les structures latentes de l'offre de formation en France a partir de la session **Parcoursup 2025-2026**, en croisant plusieurs dimensions :

- l'attractivite des formations ;
- la selectivite et les taux d'acces ;
- la mixite sociale ;
- les profils de baccalaureat ;
- la repartition geographique.

### ❓Problematique

> Comment les facteurs de **selectivite**, de **mixite sociale** ou de **localisation geographique** structurent-ils l'offre de formation actuelle ?  
> Existe-t-il une coherence entre les filieres declarees et les classes statistiques obtenues par clustering ?

---

## 🛠️Stack du projet
Le travail repose sur une approche hybride :

- **R** pour la preparation des donnees, l'analyse descriptive et certaines analyses statistiques ;
- **Python** pour les visualisations, les analyses multivariees complementaires et les algorithmes de machine learning ;
- **Jupyter notebooks** pour documenter l'ensemble du pipeline de facon reproductible.

### 📂 Structure des fichiers & Ordre d'exécution
# Structure du depot

```text
.
├── R/                        # Scripts R 
├── Python/                        # Scripts Python
├── Slides_Presentation.pdf                 # Slides de présentation résumant le projet
└── README.md
```
# Fichier Rendu
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
| **9** | 🟨 Py | `MFA` | Analyse Factorielle Multiple et Clustering (HAC, K-Means). |
| **10** | 🟨 Py | `clustring_acp.ipynb` |Comparaison (HAC, K-Means, GMM, Spectral Clustering, DBSCAN, SBM), basé sur l'ACP |
| **11** | 🟨 Py | `clustering_acm` | Comparaison (HAC, K-Means, GMM, Spectral Clustering, DBSCAN, SBM), basé sur l'ACM |
| **12** | 🟨 Py | `clustering_mfa` | Comparaison (HAC, K-Means, GMM, Spectral Clustering, DBSCAN, SBM), basé sur l'AFM |


---

## 🔬Methodologie

### 1. Analyse exploratoire
Nous commencons par un nettoyage global de la base puis par une lecture unidimensionnelle et bidimensionnelle des variables afin d'identifier :

- les contrastes entre types de formations ;
- les liens entre attractivite, selectivite et profil social ;
- les effets de territoire et de localisation.

### 2. Analyses factorielles
Plusieurs methodes de reduction de dimension sont mobilisees selon la nature des variables :

- **ACP** pour les variables quantitatives ;
- **ACM / CA** pour les variables qualitatives ;
- **AFM / MFA** pour articuler plusieurs groupes de variables.

### 3. Clustering
Le coeur du projet consiste a comparer plusieurs approches de segmentation :

- **K-Means** ;
- **CAH / HAC** ;
- **GMM** ;
- **Spectral Clustering** ;
- **DBSCAN**.

---

## 🚀 Installation & Utilisation
1.  **Cloner le dépôt** :
    ```bash
    git clone https://github.com/votre-utilisateur/projet-parcoursup.git
    ```
2.  **Configuration R** :
    Packages R centraux :
      `FactoMineR`, `MASS`, `DT` et leurs dependances.
3.  **Configuration Python** :
    Bibliotheques principales :
       `pandas`, `numpy`, `matplotlib`, `seaborn`, `scikit-learn`, `plotly`, `prince`, `statsmodels`, `yellowbrick`, `pyreadr`, `graspologic`, `jupyter`.


*Projet réalisé dans le cadre d'une 4ème année d'école d'ingénieur en Mathématiques Appliquées à l'INSA Toulouse (4MA-AD).*





