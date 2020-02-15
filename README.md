# ByteLike.de Infra

![Terraform Apply](https://github.com/dontpanic42/bytelike-de-infra/workflows/Terraform%20Apply/badge.svg)

## Description

Infrastructure Scripts for ByteLike.de, a small static website hosted using AWS S3 and CloudFront

## How to use

Scripts are automatically validated and checked when creating a pull request or push to master.

Push to master automatically applies all changes.

To manually roll out, use:

```bash
# Initialization
$ terraform init

# Plan
$ terraform plan --out myplan

# Apply
$ terraform apply myplan
```
