# Photos API

API for uploading and viewing photos with EXIF information

## Status

[![Build Status](https://api.travis-ci.org/bladebhs/photos_api.svg?branch=master)](http://travis-ci.org/bladebhs/photos_api) [![Maintainability](https://api.codeclimate.com/v1/badges/b0a80783bd37237a069b/maintainability)](https://codeclimate.com/github/bladebhs/photos_api/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/b0a80783bd37237a069b/test_coverage)](https://codeclimate.com/github/bladebhs/photos_api/test_coverage)

## How to use

The simpliest way is to use [http](https://httpie.org/) command.

### Register user

```
http POST http://localhost:3000/auth/register <<<'{ "user": { "email": "test@test.com", "password": "12345678" }}'
```

### Get the token

``` bash
http POST http://localhost:3000/user_token <<<'{ "auth": { "email": "test@test.com", "password": "12345678" }}'
```

### Upload a photo

``` bash

```

### Get photos

``` bash
http GET http://localhost:3000/api/photos 'Authorization:Bearer your_jwt_token'
```