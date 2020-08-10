# AWS Lambda template in Go

## Setup
```bash
# install dependencies
$ go mod vendor

# compile linux binary
$ make build-linux

# create a deployment package by packaging the executable in a ZIP file. 
$ make zip

# use AWS CLI to create a function
$ make create-function

# get logs for an invocation
$ make logs

# clean output
$ make clean
```

## Resources
* [Building Lambda functions with Go](https://docs.aws.amazon.com/lambda/latest/dg/lambda-golang.html)
