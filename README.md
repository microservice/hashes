# _Hashes_ OMG Microservice

[![Open Microservice Guide](https://img.shields.io/badge/OMG%20Enabled-👍-green.svg?)](https://microservice.guide)
<!-- [![Build status](https://img.shields.io/travis/microservice/hashes/master.svg?style=for-the-badge)](https://travis-ci.org/microservice/hashes) -->

This OMG service provides various digest and hashing capabilities.

## Direct usage in [Storyscript](https://storyscript.io/):

##### Digest
```coffee
digest = hashes digest method: "sha1" data: "hello world"
# {"method":"sha1","digest":"2AAE6C35C94FCFB415DBE95F408B9CE91EE846ED"}
```
##### Hmac
```coffee
digest = hashes hmac method: "sha1" data: "hello world" secret: "my secret"
# {"method":"sha1","digest":"9F60EE4B05E590A7F3FAC552BFB9D98FA46F78D9"}
```

Curious to [learn more](https://docs.storyscript.io/)?

✨🍰✨

## Usage with [OMG CLI](https://www.npmjs.com/package/omg)

##### Digest
```shell
$ omg run digest -a method:<METHOD> -a data:<DATA>
```
##### Hmac
```shell
$ omg run hmac -a method:<METHOD> -a data:<DATA> -a secret=<SECRET>
```

**Note**: The OMG CLI requires [Docker](https://docs.docker.com/install/) to be installed.

## License
[MIT License](https://github.com/omg-services/hashes/blob/master/LICENSE).
