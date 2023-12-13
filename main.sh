#!/bin/bash

# Vérification de l'argument : le chemin vers le fichier CSV doit être fourni
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 data.csv [options]"
    exit 1
fi

# Assignation du premier argument à la variable CSV_FILE
CSV_FILE=$1

# Définition des chemins des dossiers utilisés dans le script
PROG_C_DIR="./progc"   # Dossier pour le programme C et ses composants
TEMP_DIR="./temp"      # Dossier pour les fichiers temporaires
IMAGE_DIR="./images"   # Dossier pour stocker les images des graphiques
DEMO_DIR="./demo"      # Dossier pour stocker les résultats des exécutions précédentes

# Création des dossiers s'ils n'existent pas déjà
mkdir -p $PROG_C_DIR $TEMP_DIR $IMAGE_DIR $DEMO_DIR

# Vérification de l'existence de l'exécutable du programme C
# et compilation si ce n'est pas le cas
if [ ! -f "$PROG_C_DIR/mon_programme" ]; then
    echo "Compilation du programme C..."
    (cd $PROG_C_DIR && make)  # Exécute 'make' dans le dossier du programme C
    if [ ! -f "$PROG_C_DIR/mon_programme" ]; then
        echo "Erreur de compilation du programme C."
        exit 1
    fi
fi

# Traitement des options supplémentaires passées au script
shift  # Décale les arguments pour ignorer le premier (fichier CSV)
while getopts ":d1:d2:l:t:s:h" opt; do
    case $opt in
        d1)
            echo "Traitement pour les conducteurs avec le plus de trajets..."
            # Ici, insérez le code ou l'appel de script pour le traitement -d1
            ;;
        d2)
            echo "Traitement pour les conducteurs et la plus grande distance..."
            # Ici, insérez le code ou l'appel de script pour le traitement -d2
            ;;
        l)
            echo "Traitement pour les 10 trajets les plus longs..."
            # Ici, insérez le code ou l'appel de script pour le traitement -l
            ;;
        t)
            echo "Traitement pour les 10 villes les plus traversées..."
            # Ici, insérez l'appel au programme C pour le traitement -t
            ;;
        s)
            echo "Traitement pour les statistiques sur les étapes..."
            # Ici, insérez l'appel au programme C pour le traitement -s
            ;;
        h)
            # Affichage d'aide pour les options disponibles
            echo "Options disponibles : -d1 -d2 -l -t -s"
            exit 0
            ;;
        \?)
            # Gestion des options invalides
            echo "Option invalide : -$OPTARG"
            exit 1
            ;;
    esac
done

# Message indiquant la fin du script
echo "Fin du script."
