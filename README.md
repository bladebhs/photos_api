# Photos API

API for uploading and viewing photos with EXIF information

## Status

[![Build Status](https://api.travis-ci.org/bladebhs/photos_api.svg?branch=master)](http://travis-ci.org/bladebhs/photos_api) [![Maintainability](https://api.codeclimate.com/v1/badges/b0a80783bd37237a069b/maintainability)](https://codeclimate.com/github/bladebhs/photos_api/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/b0a80783bd37237a069b/test_coverage)](https://codeclimate.com/github/bladebhs/photos_api/test_coverage)

## How to use

The simpliest way is to use [http](https://httpie.org/) command.

### Register user

HTTPie:
``` bash
http POST http://localhost:3000/auth/register <<<'{ "user": { "email": "test@test.com", "password": "12345678" }}'
```

curl:
``` bash
curl -H "Content-Type: application/json" --request POST --data '{ "user": { "email": "test@test.com", "password": "12345678" }}' http://localhost:3000/auth/register
```

### Get the token

HTTPie:
``` bash
http POST http://localhost:3000/user_token <<<'{ "auth": { "email": "test@test.com", "password": "12345678" }}'
```

curl:
``` bash
curl -H "Content-Type: application/json" --request POST --data '{ "auth": { "email": "test@test.com", "password": "12345678" }}' http://localhost:3000/user_token
```

### Upload a photo

curl:
``` bash
curl -F "photo[file]=@1.jpg;type=image/jpeg" "http://localhost:3000/api/photos" -H 'Authorization:Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1NDA2NDUwMTYsInN1YiI6Mn0.Yk6A_W1deio3Kc-UdLalj3dm8A5KQU3UWeU-vZJComU'
```

### Get photos

HTTPie:
``` bash
http GET http://localhost:3000/api/photos 'Authorization:Bearer your_jwt_token'
```

curl:
``` bash
curl http://localhost:3000/api/photos -H 'Authorization:Bearer your_jwt_token'
```