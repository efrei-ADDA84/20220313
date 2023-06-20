# Utilisez une image de base appropriée pour votre application
FROM python:3.9

# Définissez le répertoire de travail dans l'image
WORKDIR /app

# Copiez les fichiers de votre projet dans le répertoire de travail de l'image
COPY . /app

# Installez les dépendances nécessaires (le cas échéant)
RUN pip install --no-cache-dir -r requirements.txt

# Définissez la commande d'exécution pour votre application
CMD [ "python", "weather.py" ]