Hashes
=======

[![Build status](https://img.shields.io/travis/microservice/hashes/master.svg?style=for-the-badge)](https://travis-ci.org/microservice/hashes)

This OMG service provides various digest and hashing capabilities.

Usage
-----

```coffee
# Storyscript
digest = hashes digest method: "sha1" data: "hello world"
# {"method":"sha1","digest":"2AAE6C35C94FCFB415DBE95F408B9CE91EE846ED"}
```

```coffee
# Storyscript
digest = hashes hmac method: "sha1" data: "hello world" secret: "my secret"
# {"method":"sha1","digest":"9F60EE4B05E590A7F3FAC552BFB9D98FA46F78D9"}
```
