# Steps for Containerization and Deployment

### 1. Containerization
- **Objective**: Containerize both the front-end and API applications.
  - Created two Dockerfiles, one in each application folder within `devops-qr-code`.

### 2. Azure Container Registry (ACR)
- **Objective**: Set up a registry to store the created containers.
  - Created an ACR using Terraform.
  - Outputs admin username and password using the command: 
    ```bash
    terraform output -json
    ```
  - Copied the ACR name and credentials for later use.

### 3. Continuous Integration/Continuous Deployment (CI/CD)
- **Objective**: Automate deployment of containers to ACR upon source code changes.
  - Added the copied ACR admin username and password to GitHub Action secrets.
  - Created two YAML files in the `.github/workflows` directory, one for each app folder.
  - Configured the YAML files to trigger on changes in their respective folders (e.g., Dockerfile).
  - The CI/CD pipeline builds the containers with the updates and retrieves secrets to send Dockerfiles to ACR.

### 4. Kubernetes YAML Configuration
- **Objective**: Create deployment and service YAML files for both applications.
  - Created deployment and service YAML files and added them to their respective folders: `FastAPI-yaml` and `Node.js-yaml`.

### 5. Kubernetes Setup
- **Objective**: Establish a Kubernetes service using Azure AKS.
  - Created an AKS instance using Terraform.

### 6. Container Deployment
- **Objective**: Deploy front-end and API YAML files to the Kubernetes cluster.
  - Manually applied the YAML files directly in the Azure portal.

### 7. Interconnectivity
- **Objective**: Ensure seamless data flow between containers.
  - Added the DNS name of the API container to the Node.js Dockerfile.
  - Redeployed the Node.js container with the updated configuration.

### 8. CI/CD Implementation for AKS
- **Objective**: Automate deployment of containers and applications to AKS after source code changes.
  - Implemented CI/CD using GitHub Actions and AKS GitOps.
  - Created a namespace in AKS and configured it in the YAML files for deployment.
  - Added a managed identity on AKS with the ACRPull role to access the ACR.
  - AKS retrieves the images and deploys them as pods in Kubernetes.

### 9. Monitoring
- **Objective**: Set up monitoring for containers to track key metrics and insights.
  - Enabled Azure Monitor for AKS to gather logs.
  - Implemented Prometheus for enhanced visualization.
  - Integrated Grafana for advanced monitoring and improved GUI.

# Order of Execution in GitHub Actions
1. Execute the Terraform script to create the environment in Azure.
2. Navigate to the Azure portal to verify the newly created ACR.
3. Copy the registry name, username, and password.
4. Add the ACR credentials to GitHub secrets and update Kubernetes deployment YAML files.
5. Run the API and Node.js YAML files for deployment.
