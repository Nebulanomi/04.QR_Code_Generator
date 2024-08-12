1. Containerization: Containerize both the front-end and API by creating Dockerfiles.
2. CI/CD: Write a CI/CD pipeline to automate the deployment of the containers once your source code is changed.
    I did it in GitHub actions.

3. Kubernetes YAML Files: Create deployment and service YAML files (Or both in one) for both the Next.js front-end and the FastAPI backend.
4. Kubernetes Setup: Set up a Kubernetes service within Azure AKS.
    Recommend adding adding tags since it creates new RGs for it.

5. Container Deployment: Deploy the front-end & API YAML files to the Kubernetes cluster.
    Did it manually by applying YAML files directly to AKS.
    I needed to create a namespace for it to work.

6. Interconnectivity: Ensure the containers are interconnected for seamless data flow.
    Gave the Node.js container the dns name of the api container.
    
7. CI/CD Implementation: Set up a CI/CD pipeline to deploy the containers and application after the source code changes.
    Did it automatically GitHub Actions and with AKS GitOps.

8. Monitoring: Set up monitoring for containers to track key metrics and insights.
    Use Azure Monitor for AKS, Prometheus or Grafana for advanced monitoring.
    Why not all :D
