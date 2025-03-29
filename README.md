# Cloud Resume Challenge

![Azure](https://img.shields.io/badge/Azure-Storage-blue)
![GitHub Actions](https://img.shields.io/badge/GitHub-Actions-blue)

## Description

This project is a template for deploying a personal resume website using Azure Storage and CDN, with continuous deployment handled by GitHub Actions. Changes to the website are automatically pushed to the Azure Storage account, and the CDN is purged without manual intervention.

Learn more about the Cloud Resume Challenge at [cloudresumechallenge.dev](https://cloudresumechallenge.dev).

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Deployment](#deployment)
- [Infrastructure Deployment](#infrastructure-deployment)

## Features

- **Azure Storage**: Host your resume as a static website.
- **Azure CDN**: Distribute your content globally with low latency.
- **Continuous Deployment**: Automatically deploy updates using GitHub Actions.
- **Responsive Design**: Mobile-friendly and modern web design.
- **Custom Fonts and Icons**: Integration with Font Awesome and Fontello.

## Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/alexdavis10/CloudResume.git
    cd CloudResume
    ```

2. Set up your Azure Storage account and CDN following the instructions on the [Azure documentation](https://docs.microsoft.com/en-us/azure/storage/).

3. Configure your GitHub Actions workflow with your Azure credentials. Update the `.github/workflows/main.yml` file with your Azure storage account details.

## Usage

- Modify `index.html` and the CSS files under the `css/` directory to customize your resume content and design.
- Add or replace image assets in the `images/` directory.

## Deployment

This project uses GitHub Actions for continuous deployment. On every commit to the `main` branch, the workflow defined in `.github/workflows/main.yml` will:

1. Build the project.
2. Deploy the contents to the Azure Storage account.
3. Purge the Azure CDN to ensure the latest content is served.

To manually trigger a deployment, you can run the following command:
```bash
git commit -am "Update resume"
git push origin main
```

## Infrastructure Deployment

To deploy the necessary infrastructure using the Bicep script, follow these steps:

1. Ensure you have the Azure CLI installed and logged in.

2. Navigate to the `infrastructure` directory:
    ```bash
    cd infrastructure
    ```

3. Run the Bicep script to create the resources:
    ```bash
    az deployment group create --resource-group <your-resource-group> --template-file main.bicep --parameters storageAccountName=<your-storage-account-name> cdnProfileName=<your-cdn-profile-name> cdnEndpointName=<your-cdn-endpoint-name> cdnEndpointOriginHostHeader=<your-storage-account-name>.z13.web.core.windows.net
    ```

Replace `<your-resource-group>`, `<your-storage-account-name>`, `<your-cdn-profile-name>`, and `<your-cdn-endpoint-name>` with your desired values.
