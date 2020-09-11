.PHONY: vendor build-linux zip create-func

EXE=app
ZIP_FILE=app.zip
FUNC_NAME ?= my-function
IAM ?= 123456789012
ROLE_NAME ?= lambda_basic_execution
ROLE_ARN ?= arn:aws:iam::$(IAM):role/$(ROLE_NAME)

dep:
	@go get && go mod vendor

build-linux:
	@GO111MODULE=on GOOS=linux go build -mod=vendor -o $(EXE)

clean:
	@rm -f $(EXE) $(ZIP_FILE)

zip:
	@zip $(ZIP_FILE) $(EXE)

create-func: build-linux zip
	@aws lambda create-function \
	--function-name $(FUNC_NAME) \
	--runtime go1.x \
	--zip-file fileb://$(ZIP_FILE) \
	--handler $(EXE) \
	--role $(ROLE_ARN)

logs:
	@aws lambda invoke \
	--function-name $(FUNC_NAME) \
	out \
	--log-type Tail \
	--query 'LogResult' \
	--output text \
	| base64 -d
