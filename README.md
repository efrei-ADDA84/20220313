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

>      - name: login to dockerhub
>        uses: docker/login-action@v1
>        with:
>          username: ${{ secrets.DOCKERHUB_USERNAME }}
>          password: ${{ secrets.DOCKERHUB_TOKEN }}

This portion of the code initiates the login to dockerhub. DOCKERHUB_USERNAME and DOCKERHUB_TOKEN are the credentials that have been registered as Github secrets and are freely accessed by the program. 

>      - name: build and push of docker image
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

## TP 4 - Report

> name                = "tp4-20220313"
>  location            = "francecentral"
>  resource_group_name = "ADDA84-CTP"
>  size                = "Standard_D2s_v3"
>  admin_username      = "devops"
>  network_interface_ids = [
>    azurerm_network_interface.tp4.id,
>  ]

Settings instructed to connect to the VM.

>admin_ssh_key {
>   username       = "devops"
>    public_key     = "ssh-rsa[...]
>
>  }

I had to generate a public ssh key through the terminal and stock it in the public_key variable so that I could connect using the ssh command. I encountered some problem making this work as I didnt realize I needed to use a chmod 400 to have permission on the key file.

> disable_password_authentication = true

This parameter helps prevent the platform to ask you for a password when connecting.

> Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.
> Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Terraform apply works.

> azurerm_public_ip.tp4: Destruction complete after 11s
> Destroy complete! Resources: 4 destroyed.

Terraform destroy also works.

> ssh -i ~/Users/evanarneau/.ssh/id_rsa devops@20.111.29.170 cat /etc/os-release

This command connects to the server and retrieves information about the OS installed on the server. Removing the cat command from the ssh command allows us to connect to the VM.