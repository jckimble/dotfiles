#!/usr/bin/env node
var { AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_SESSION_TOKEN } = process.env
var creds={
	"Version": 1,
	"AccessKeyId": AWS_ACCESS_KEY_ID,
	"SecretAccessKey": AWS_SECRET_ACCESS_KEY,
	"SessionToken": AWS_SESSION_TOKEN
}
process.stdout.write(JSON.stringify(creds))
