Hashes
=======

This OMG service provides various digest and hashing capabilities.

Usage
-----

```coffee
# Storyscript
digest = hashes digest method: "sha1" data: "hello world"
digest = hashes hmac method: "sha1" data: "hello world" secret: "my secret"
```
