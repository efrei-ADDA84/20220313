# TP DEVOPS

## TP 1 - Report

I used python for the code. The program retrieves the API_KEY, LAT and LONG env variables and uses them to send a request to the Openweather API. If the api status code returns 200 it means we have access to the API according to documentation. If not, we failed to retrieve data. The dockerfile will run the python weather.py command when executed.

### To run the docker image :
`docker run --env LAT="31.2504" --env LONG="-99.2506" --env API_KEY=**** earneau/weatherapp:latest`

### To build locally the dockerhub image :
`docker build -t weatherappimage .`

### Bonus
hadolint command returns no error nor warning when executed

## TP 2 - Report

Added a Github Actions worflow in .github/workflows. 

>- name: login to dockerhub
>        uses: docker/login-action@v1
>        with:
>          username: ${{ secrets.DOCKERHUB_USERNAME }}
>          password: ${{ secrets.DOCKERHUB_TOKEN }}

This portion of the code initiates the login to dockerhub. DOCKERHUB_USERNAME and DOCKERHUB_TOKEN are the credentials that have been registered as Github secrets and are freely accessed by the program. 

>- name: build and push of docker image
>        uses: docker/build-push-action@v2
>        with:
>          push: true
>          tags: ${{ secrets.DOCKERHUB_USERNAME }}/weatherapp:latest

These steps build and push the current docker image to the dockerhub repository.

### To run the docker image :
`docker run --network host --env API_KEY=**** weatherappimage:latest`

### Bonus

>      - name: install Hadolint
>        run: |
>          curl -sL -o /usr/local/bin/hadolint https://github.com/hadolint/hadolint/releases/latest/download/hadolint-Linux-x86_64
>          chmod +x /usr/local/bin/hadolint
>
>      - name: lint dockerfile
>        run: hadolint Dockerfile

I tried to execute the bonus part without adding the installment of Hadolint and it failed. This portion of the code makes it so that at every github push, before building and pushing the image to dockerhub we execute hadolint on our repository.

## TP 3 - Report