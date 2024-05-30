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
