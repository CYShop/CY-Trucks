#!/bin/bash

# Chemin du fichier CSV d'entrée
input_file=""

# Options disponibles
while getopts ":i:d1:d2:l:t:s:h" opt; do
  case $opt in
    i) input_file="$OPTARG" ;;
    d1) option="d1" ;;
    d2) option="d2" ;;
    l) option="l" ;;
    t) option="t" ;;
    s) option="s" ;;
    h) option="h" ;;
    \?) echo "Option invalide: -$OPTARG" >&2 ;;
  esac
done

# Vérification de la présence du fichier d'entrée
if [ -z "$input_file" ] || [ ! -f "$input_file" ]; then
  echo "Erreur: Fichier d'entrée invalide."
  exit 1
fi

# Vérification de la présence de l'exécutable C
if [ ! -f "progc/your_c_program" ]; then
  echo "Compilation du programme C en cours..."
  (cd progc && make)  # Ne fonctionnera pas directement dans un script, mais vous devez le faire manuellement.
  if [ $? -ne 0 ]; then
    echo "Erreur: La compilation a échoué."
    exit 1
  fi
fi

# Vérification des dossiers temp et images
mkdir -p temp images

# Nettoyage du dossier temp
rm -rf temp/*
mkdir -p temp

# Enregistrement du temps de début
start_time=$(date +%s)

# Appel du programme C avec l'option spécifiée
progc/your_c_program "$input_file" "$option"

# Calcul de la durée du traitement
end_time=$(date +%s)
duration=$((end_time - start_time))
echo "Durée du traitement: $duration secondes."

# Génération du graphique avec GnuPlot (exemple pour l'option d1)
gnuplot << EOF
set terminal png
set output "images/d1_graph.png"
set style data histograms
plot 'temp/d1_data.txt' using 2:xticlabels(1) title 'Nombre de trajets'
EOF