# App Feedback

> API to capture feedback and save in mongodb

## Requirements

- Terraform => v0.14.9

## Diagram

![Alt text](/images/diagram.jpg?raw=true "Optional Title")

## Create Environment

### Config environment variables

Fist you need s3 bucket to store terraform tfstate file, and will used by variable AWS_BUCKET_TFSTATE.
Set these variables and aws credentials to the creation of the environment.

Example

```sh
export AWS_ACCESS_KEY_ID=AKI****************
export AWS_SECRET_ACCESS_KEY=qIEm********************************
export AWS_DEFAULT_REGION=us-east-2
export AWS_BUCKET_TFSTATE=feedback-tfstate-example
```

### Run terraform init

Using Makefile run:

```sh
make init
```

### Run terraform apply and docker-compose up

Using Makefile run:

```sh
make create
```

### More commands in Makefile

You can use the _make help_ command for more options about Makefile

| Command                   | Description                                           | 
| --------------------------| ------------------------------------------------------|  
| init                      | Execute terraform init                                |
| create                    | Execute terraform apply and docker-compose up         |
| up                        | Execute docker-compose up                             |
| down                      | Execute docker-compose down                           |
| destroy                   | Exexute docker-compose down and terraform destroy     |
| test                      | Execute test request to API                           |

