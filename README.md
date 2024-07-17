# Sila IAC
Landing Zone Deployment

1. Clone the repository from Azure Cloud Shell (bash). git clone https://github.com/francisnazareth/Sila-IAC
2. Create the bicep parameter file by filling values in https://francisnazareth.github.io/landingzone/
3. Change to the hub directory (cd Sila-IAC/prod-hub)
4. In the cloned Replace the main.bicepparam contents in the hub folder with the generated contents from HTML page.
5. Run the bicep script using the command: `az deployment sub create  --location qatarcentral --template-file main.bicep --parameters main.bicepparam`
