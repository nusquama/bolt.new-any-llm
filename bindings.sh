#!/bin/bash

bindings=""

# Vérifier si .env.local existe
if [ -f .env.local ]; then
  echo "Chargement des variables d'environnement depuis .env.local"
  
  # Lire le fichier .env.local et créer les bindings
  while IFS= read -r line || [ -n "$line" ]; do
    if [[ ! "$line" =~ ^# ]] && [[ -n "$line" ]]; then
      name=$(echo "$line" | cut -d '=' -f 1)
      value=$(echo "$line" | cut -d '=' -f 2-)
      value=$(echo "$value" | sed 's/^"\(.*\)"$/\1/')  # Supprimer les guillemets autour de la valeur
      bindings+="--binding ${name}=${value} "
    fi
  done < .env.local

else
  echo ".env.local non trouvé. Utilisation des variables d'environnement de Coolify."
fi

# Supprimer les espaces superflus en fin de chaîne
bindings=$(echo "$bindings" | sed 's/[[:space:]]*$//')

# Afficher les bindings pour vérification
echo "$bindings"
