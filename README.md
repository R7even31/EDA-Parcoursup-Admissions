Analyse des données Parcoursup (2025-2026)


Ce projet s'inscrit dans le cadre de l'unité d'enseignement Analyse de Données (4MA-AD). L'objectif est d'étudier les structures latentes et les typologies de formations dans l'enseignement supérieur français à partir des données Parcoursup. 

Problématique: Comment les facteurs de sélectivité, de mixité sociale et de localisation géographique structurent-ils l'offre de formation actuelle ? Existe-t-il une cohérence entre les filières déclarées et les classes statistiques obtenues par clustering ?


Organisation du dépôt:

Le projet est divisé en deux environnements pour tirer profit des meilleures bibliothèques de chaque langage.

Dans le fichier Rendu (et ordre exécution des fichiers en (.)):
    -un fichier R avec:
            -shared_data.R (nettoyage des données) (1)
            -Analyse Unidimensionnelle (2)
            -data_GPS (nettoyage des données spécifiquement pour exploiter les données GPS) (4)
            -ACP (qu'on réutilise ensuite) (6)
            -LDA (7)
            -clustering.ipynb(K-Means et HAC simple directement sur ACP, beaucoup moins efficace que sur du MFA ou MCA)(fichier pas très utile, plutôt regarder celui en python sur lequel on a travaillé beaucoup plus) (10)


    -un fichier Python avec:
            -analyse bidimensionnelle (3)
            -visu_carte (5)
            -CA_MCA (8)
            -AD_MFA (avec du clustering dans partie 2, HAC, K-Means) (9)
            -clustering_acm (ACM puis: HAC, K-Means,GMM,spectral clustering,DBSCAN...) (11)
            -GMM_Python (idem que clustering en R, regarder plutôt le fihcier clustering ACM qui est plus complet et compare les méthodes) (12)


Attendus Oral: 

1. Une soutenance orale par groupe de 3 à 4 étudiant·es.
— Chaque membre du groupe doit être capable de répondre aux questions sur l’ensemble du projet.
2. Un dépôt Git contenant l’ensemble des codes nécessaires à la reproduction des analyses et des figures.
— Unfichier README décrivant l’organisation du dépôt est attendu.
— Lareproductibilité des résultats sera évaluée.
— Tout membre du groupe doit être en mesure d’expliquer l’ensemble des codes fournis.


Groupe: Romain Deleris, Corentin Brandam, Augustin Traissac, 2026
