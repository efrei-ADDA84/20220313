# image de base
FROM python:3.9

# répertoire de travail de l'image
WORKDIR /app

# copier les fichiers du projet dans le répertoire de travail de l'image
COPY . /app

# argument API key
ARG API_KEY

# installation des dépendances
RUN pip install --no-cache-dir -r requirements.txt

# commande d'exécution du programme
CMD [ "python", "weather.py" ]