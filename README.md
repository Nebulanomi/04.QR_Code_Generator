1. Containerization: Containerize both the front-end and API by creating Dockerfiles.
    Created two dockerfiles, one in each app folder inside 'devops-qr-code'.

2. Registry: Create a registry to contain the created containers.
    Created an ACR with terraform.

2. CI/CD: Write a CI/CD pipeline to automate the deployment of the containers to ACR once your source code is changed.
    I did it in GitHub actions.
    Added two YAML files, one for each app folder inside '.github\workflows'.
    If an alteration is done in their respective folders then the YAML file kicks in.
    The dockerfile containers are then created with these alterations and sent to the ACR.
    The YAML file has the credentials to the ACR.

3. Kubernetes YAML Files: Create deployment and service YAML files for both the Next.js front-end and the FastAPI backend.
    Created them and added to their respective folders ('FastAPI-yaml' & 'Node.js-yaml').
 
4. Kubernetes Setup: Set up a Kubernetes service within Azure AKS.
    Did it with terraform.
    
5. Container Deployment: Deploy the front-end & API YAML files to the Kubernetes cluster.
    Did it manually by applying YAML files directly to AKS.

6. Interconnectivity: Ensure the containers are interconnected for seamless data flow.
    I gave the Node.js container the DNS name of the api container.
    I then redeploid the node.js container with this information.

7. CI/CD Implementation: Set up a CI/CD pipeline to deploy the containers and application to AKS after the source code changes.
    Did it automatically with GitHub Actions and with AKS GitOps.
    I needed to create a namespace in AKS and in the YAML files for it to work.
    I had to add a managed identity on AKS with the ACRPull role to reach ACR.

8. Monitoring: Set up monitoring for containers to track key metrics and insights.
    Use Azure Monitor for AKS, Prometheus or Grafana for advanced monitoring.
    Enabled Azure Monitor for AKS in the portal.

9. Extra: Make it all work with terraform, az cli & git :D