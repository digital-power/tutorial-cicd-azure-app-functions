# Deploying Azure Functions with Terraform and GitHub Workflows

This repository contains the source code for the article [Deploying Azure Functions with Terraform and GitHub Workflows](https://digital-power.com/en/).

In the article, we start by discussing Serverless Functions. Then we demonstrate how to use Terraform files to simplify
the process of deploying a target infrastructure, how to create a Function App in Azure, the use GitHub workflows to
manage continuous integration and deployment, and how to use branching strategies to selectively deploy code
changes to specific instances of Function Apps.

## Prerequisites

Before you begin, you'll need to have the following:

- An Azure subscription
- A GitHub account
- Terraform installed on your machine
- Azure CLI installed on your machine

## Getting Started

To get started with deploying Azure Functions using Terraform and GitHub Workflows, follow the steps outlined in the
article.

## Repository Structure

- The folder `infrastructure` contains the terraform files:
  - `main.tf`: Contains the code for deploying the Function App and related resources.
  - `variables.tf`: Contains the input variables used in the `main.tf` file.
- The folder `.github/workflows/` contains the GitHub workflows used to manage continuous integration and deployment.
- `my_first_function` and `mylib` contain the Azure App function and a modules example.

## Contributing

We welcome contributions from the community! If you find a bug or would like to suggest a new feature, please create a
GitHub issue and we'll take a look.


## About the Author

This article was written by [Oscar Mike Claure Cabrera](https://www.linkedin.com/in/oscarclaure/), a Data Engineer at 
[Digital Power](https://digital-power.com/en/). 

If you're interested in learning more about how we use other cloud and its services to build scalable, resilient
solutions for our customers, please check out our website.
