Steps​:

    ○ Containerization (Containerized both the front-end and API by creating Dockerfiles):
    
        § Created two dockerfiles, one in each app folder inside 'devops-qr-code'.
    
    ○ Registry (Created an ACR to contain the created container):
    
        § Created an ACR with terraform.
        § It outputs the admin username and password: terraform output -json
        § I copy the ACR name and the output above for later.
    
    ○ CI/CD (Wrote a GitHub actions CI/CD pipeline to automate the deployment of the containers to ACR once the source code is changed):
    
        § I add the copied ACR admin username and password to the github action secrets.
        § Added two YAML files, one for each app folder inside '.github\workflows'.
        § If an alteration is done in their respective folders (e.g dockerfile) then the YAML file kicks in.
        § The containers are then created with these alterations.
        § The YAML file then retrieves the secrets to send the dockerfiles to ACR.
    
    ○ Kubernetes YAML Files (Created deployment and service YAML files for both the Next.js front-end and the FastAPI backend):
    
        § Created them and added to their respective folders ('FastAPI-yaml' & 'Node.js-yaml').
        
    ○ Kubernetes Setup (Set up a Kubernetes service with Azure AKS):
    
        § Created an AKS with terraform.
        
    ○ Container Deployment (Deploy the front-end & API YAML files to the Kubernetes cluster):
    
        § Did it manually by applying YAML files directly in AKS throught the portal.
    
    ○ Interconnectivity (Ensure the containers are interconnected for seamless data flow):
    
        § I added to the Node.js dockerfile the DNS name of the API container.
        § I then redeploid the node.js container with this information.
    
    ○ CI/CD Implementation (Set up a CI/CD pipeline to deploy the containers and application to AKS after the source code changes):
    
        § Did it automatically with GitHub Actions and with AKS GitOps.
        § I create a namespace in AKS and in the YAML files for the containers to be deployed.
        § I had to add a managed identity on AKS with the ACRPull role to reach ACR.
        § The images are then retrieved by AKS and added to kubernetes as pods.
    
    ○ Monitoring (Set up monitoring for containers to track key metrics and insights):
    
        § Enabled Azure Monitor for AKS to get logs.
        § Then enabled Prometheus to have better visualization.
        § And then Grafana for advanced monitoring and getter GUI.

Order of execution in Github actions:

    1. Run terraform script (To create the environment in Azure).
    2. Go to the Azure portal -> the new ACR created.
    3. Copy the registry name, username and password.
    4. Add the ACR information to github secrets and kubernetes deployment YAML files.
    5. Run api and node.js YAML files.