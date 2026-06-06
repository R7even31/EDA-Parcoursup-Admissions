###Fichier Nettoyage Données

suppressPackageStartupMessages(library(tidyverse))

`%||%` <- function(x, y) {
  if (is.null(x) || length(x) == 0) y else x
}

find_project_root <- function(start = getwd()) {
  current <- normalizePath(start, winslash = "/", mustWork = TRUE)

  repeat {
    if (file.exists(file.path(current, "renv.lock"))) {
      return(current)
    }

    parent <- dirname(current)
    if (identical(parent, current)) {
      stop("Impossible de trouver la racine du projet (fichier renv.lock introuvable).")
    }

    current <- parent
  }
}

project_path <- function(...) {
  file.path(find_project_root(), ...)
}

build_analysis_data <- function(csv_path = project_path("data", "raw", "Parcoursup.csv")) {
  data <- read.csv(
    csv_path,
    sep = ";",
    header = TRUE,
    stringsAsFactors = TRUE,
    check.names = TRUE
  )

  cols_to_drop <- c(
    "Session",
    "Code.UAI.de.l.établissement",
    "Code.départemental.de.l.établissement",
    "Département.de.l.établissement",
    "Coordonnées.GPS.de.la.formation",
    "Commune.de.l.établissement",
    "Filière.de.formation.détaillée",
    "Filière.de.formation.détaillée.bis",
    "Filière.de.formation.très.détaillée",
    "Dont.effectif.des.candidats.ayant.postulé.en.internat",
    "Effectif.total.des.candidats.classés.par.l.établissement.en.phase.principale",
    "Effectif.des.candidats.classés.par.l.établissement.en.phase.complémentaire",
    "Effectif.des.candidats.classés.par.l.établissement.en.internat..CPGE.",
    "Effectif.des.candidats.classés.par.l.établissement.hors.internat..CPGE.",
    "Concours.communs.et.banque.d.épreuves",
    "cod_aff_form",
    "Lien.de.la.formation.sur.la.plateforme.Parcoursup",
    "etablissement_id_paysage",
    "composante_id_paysage"
  )

  num_cols <- c(
    "Capacité.de.l.établissement.par.formation",
    "Effectif.total.des.candidats.en.phase.principale",
    "Effectif.total.des.candidats.en.phase.complémentaire",
    "Effectif.des.admis.en.phase.principale",
    "Effectif.des.admis.en.phase.complémentaire",
    "Effectif.total.des.candidats.ayant.accepté.la.proposition.de.l.établissement..admis.",
    "Dont.effectif.des.candidates.admises",
    "Effectif.des.admis.néo.bacheliers",
    "Dont.effectif.des.admis.néo.bacheliers.sans.mention.au.bac",
    "Dont.effectif.des.admis.néo.bacheliers.avec.mention.Assez.Bien.au.bac",
    "Dont.effectif.des.admis.néo.bacheliers.avec.mention.Bien.au.bac",
    "Dont.effectif.des.admis.néo.bacheliers.avec.mention.Très.Bien.au.bac",
    "Dont.effectif.des.admis.néo.bacheliers.avec.mention.Très.Bien.avec.félicitations.au.bac"
  )

  data <- data %>%
    select(-any_of(cols_to_drop)) %>%
    mutate(across(any_of(num_cols), ~ suppressWarnings(as.numeric(.x)))) %>%
    mutate(
      Effectif.total.candidats.2phases = coalesce(Effectif.total.des.candidats.en.phase.principale, 0) +
        coalesce(Effectif.total.des.candidats.en.phase.complémentaire, 0),
      Effectif.total.admis.2phases = coalesce(Effectif.des.admis.en.phase.principale, 0) +
        coalesce(Effectif.des.admis.en.phase.complémentaire, 0),
      pct_filles_admises = if_else(
        Effectif.total.des.candidats.ayant.accepté.la.proposition.de.l.établissement..admis. > 0,
        Dont.effectif.des.candidates.admises /
          Effectif.total.des.candidats.ayant.accepté.la.proposition.de.l.établissement..admis.,
        NA_real_
      ),
      pct_garcons_admis = if_else(!is.na(pct_filles_admises), 1 - pct_filles_admises, NA_real_),
      part_mention_ab = if_else(
        Effectif.des.admis.néo.bacheliers > 0,
        Dont.effectif.des.admis.néo.bacheliers.avec.mention.Assez.Bien.au.bac /
          Effectif.des.admis.néo.bacheliers,
        NA_real_
      ),
      part_mention_b = if_else(
        Effectif.des.admis.néo.bacheliers > 0,
        Dont.effectif.des.admis.néo.bacheliers.avec.mention.Bien.au.bac /
          Effectif.des.admis.néo.bacheliers,
        NA_real_
      ),
      part_mention_tb = if_else(
        Effectif.des.admis.néo.bacheliers > 0,
        Dont.effectif.des.admis.néo.bacheliers.avec.mention.Très.Bien.au.bac /
          Effectif.des.admis.néo.bacheliers,
        NA_real_
      ),
      part_mention_tb_fel = if_else(
        Effectif.des.admis.néo.bacheliers > 0,
        Dont.effectif.des.admis.néo.bacheliers.avec.mention.Très.Bien.avec.félicitations.au.bac /
          Effectif.des.admis.néo.bacheliers,
        NA_real_
      )
    ) %>%
    rename(
      Statut.Etablissement = "Statut.de.l.établissement.de.la.filière.de.formation..public..privé.."
    ) %>%
    mutate(
      Statut.Etablissement = case_when(
        grepl("^Public", Statut.Etablissement) ~ "Public",
        grepl("^Privé", Statut.Etablissement) ~ "Privé",
        TRUE ~ Statut.Etablissement
      ),
      Statut.Etablissement = as.factor(Statut.Etablissement)
    ) %>%
    mutate(
      total_candidats = Effectif.des.candidats.néo.bacheliers.généraux.en.phase.principale +
        Effectif.des.candidats.néo.bacheliers.technologiques.en.phase.principale +
        Effectif.des.candidats.néo.bacheliers.professionnels.en.phase.principale,
      total_boursiers_candidats =
        Dont.effectif.des.candidats.boursiers.néo.bacheliers.généraux.en.phase.principale +
        Dont.effectif.des.candidats.boursiers.néo.bacheliers.technologiques.en.phase.principale +
        Dont.effectif.des.candidats.boursiers.néo.bacheliers.professionnels.en.phase.principale,
      Pourcentage.boursiers.candidats = (total_boursiers_candidats / total_candidats) * 100,
      Pourcentage.boursiers.admis =
        (Dont.effectif.des.admis.boursiers.néo.bacheliers / Effectif.des.admis.néo.bacheliers) * 100
    ) %>%
    select(-total_candidats, -total_boursiers_candidats) %>%
    mutate(
      taux_acces_num = suppressWarnings(as.numeric(gsub(",", ".", gsub("%", "", Taux.d.accès)))) / 100
    )

  data_features_core <- data %>%
    mutate(
      pression_candidature = if_else(
        Capacité.de.l.établissement.par.formation > 0,
        Effectif.total.candidats.2phases / Capacité.de.l.établissement.par.formation,
        NA_real_
      ),
      taux_admission = if_else(
        Effectif.total.candidats.2phases > 0,
        Effectif.total.admis.2phases / Effectif.total.candidats.2phases,
        NA_real_
      ),
      taux_remplissage = if_else(
        Capacité.de.l.établissement.par.formation > 0,
        Effectif.total.admis.2phases / Capacité.de.l.établissement.par.formation,
        NA_real_
      ),
      part_mention_haute = part_mention_tb + part_mention_tb_fel,
      score_mention = 1 * coalesce(part_mention_ab, 0) +
        2 * coalesce(part_mention_b, 0) +
        3 * coalesce(part_mention_tb, 0) +
        4 * coalesce(part_mention_tb_fel, 0),
      log_candidats = log1p(Effectif.total.candidats.2phases),
      log_admis = log1p(Effectif.total.admis.2phases),
      log_capacite = log1p(Capacité.de.l.établissement.par.formation),
      pression_q = ntile(pression_candidature, 4),
      taux_acces_q = ntile(taux_acces_num, 4)
    ) %>%
    select(
      Établissement,
      Statut.Etablissement,
      Filière.de.formation,
      Filière.de.formation.très.agrégée,
      Région.de.l.établissement,
      Académie.de.l.établissement,
      Sélectivité,
      Capacité.de.l.établissement.par.formation,
      Effectif.total.admis.2phases,
      Effectif.total.candidats.2phases,
      Pourcentage.boursiers.candidats,
      Pourcentage.boursiers.admis,
      pct_filles_admises,
      pct_garcons_admis,
      pression_candidature,
      taux_admission,
      taux_remplissage,
      taux_acces_num,
      part_mention_ab,
      part_mention_b,
      part_mention_tb,
      part_mention_tb_fel,
      part_mention_haute,
      score_mention,
      X..d.admis.néo.bacheliers.issus.de.la.même.académie..Paris.Créteil.Versailles.réunies.,
      X..d.admis.néo.bacheliers.généraux,
      X..d.admis.néo.bacheliers.technologiques,
      X..d.admis.néo.bacheliers.professionnels,
      log_candidats,
      log_admis,
      log_capacite
    ) %>%
    mutate(
      across(where(is.numeric), ~ ifelse(is.na(.), median(., na.rm = TRUE), .))
    )

  data_features_core
}

save_analysis_data <- function(
  output_path = project_path("data", "processed", "data_features_core.rds")
) {
  dir.create(dirname(output_path), recursive = TRUE, showWarnings = FALSE)
  data_features_core <- build_analysis_data()
  saveRDS(data_features_core, output_path)
  invisible(output_path)
}

load_analysis_data <- function(
  input_path = project_path("data", "processed", "data_features_core.rds"),
  rebuild = FALSE
) {
  if (rebuild || !file.exists(input_path)) {
    save_analysis_data(input_path)
  }

  readRDS(input_path)
}
