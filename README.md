# TP DEVOPS

## TP 1 - Report

I used python for the code. The program retrieves the API_KEY, LAT and LONG env variables and uses them to send a request to the Openweather API. If the api status code returns 200 it means we have access to the API according to documentation. If not, we failed to retrieve data. The dockerfile will run the python weather.py command when executed.

### To run the docker image :
docker run --env LAT="31.2504" --env LONG="-99.2506" --env API_KEY=a92db6e671e7db68c51262cacb84ed0d earneau/weatherapp:latest

### To build locally the dockerhub image :
docker build -t weatherappimage .

### Bonus
hadolint command returns no error nor warning when executed

## TP 2 - Report

### to run the docker image
docker run --network host --env API_KEY=a92db6e671e7db68c51262cacb84ed0d weatherappimage:latest

## TP 3 - Report