# Prowler

[Prowler](https://github.com) is an open-source security tool for AWS, Azure, GCP, and Kubernetes. It performs security assessments, auditing, incident response, and continuous monitoring against frameworks like CIS, HIPAA, and PCI-DSS.

## Installation & Setup

Ensure you have your cloud provider credentials configured (`aws configure`, `az login`, or GCP Service Account) before running Prowler.

```bash
# Install via pip
pip install prowler

# Check installation version
prowler --version

# Run via Docker
docker run -ti --rm -v ~/.aws:/root/.aws prowlercloud/prowler:latest aws
```

## Basic Execution

Execute a full assessment across your entire cloud footprint.

```bash
# Scan all AWS resources in all regions
prowler aws

# Scan Azure environment
prowler azure

# Scan GCP environment
prowler gcp

# Scan Kubernetes cluster
prowler kubernetes
```

## Targeted Scanning

Narrow down your scan to save time and API requests.

```bash
# Scan specific regions (e.g., US East 1 and EU West 1)
prowler aws -f us-east-1 eu-west-1

# Run a specific check
prowler aws --checks s3_bucket_public_access

# Run multiple specific checks
prowler aws --checks s3_bucket_public_access iam_user_mfa_enabled_console_access

# Scan using a specific AWS CLI profile
prowler aws --profile prod-account
```

## Outputs & Formats

Prowler automatically outputs results to the `./output` directory.

```bash
# Generate specific report formats (HTML, CSV, JSON)
prowler aws -M html csv json

# Change the default output directory
prowler aws --output-directory /path/to/custom-dir

# Change the output file name prefix
prowler aws --output-filename custom_scan_report
```

## Advanced Flags & Filters

Useful options for automation and CI/CD pipelines.

```bash
# Filter findings by severity (critical, high, medium, low)
prowler aws --severity critical high

# Ignore non-zero exit codes on failures (essential for CI/CD)
prowler aws -z

# Run checks based on a specific compliance framework
prowler aws --compliance cis_1.5_aws

# List all available checks without running them
prowler aws --list-checks
```
---
**Unless otherwise indicated at the root NOTICE file, all the information submitted to this repo is protected under Creative Commons Universal 1.0 (CC0-v1.0) license and is free to consult, copy, distribute and transform with no permission nor atribution required.**

_Way to go, brain! Good luck and happy hacking!_

