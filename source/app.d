import vibe.vibe;

void main()
{
    auto settings = new HTTPServerSettings;
    settings.port = 8080;
    settings.bindAddresses = ["0.0.0.0"];
    settings.errorPageHandler = (HTTPServerRequest req,
    HTTPServerResponse res,
    HTTPServerErrorInfo error) {
        Json errorResponse = Json([
            "success": Json(false),
            "message": Json(error.message)
        ]);
        logInfo(error.debugMessage);
        res.writeJsonBody(errorResponse, error.code);
    };
    auto router = new URLRouter;
    router.registerWebInterface(new EncodeService);
    listenHTTP(settings, router);

    runApplication();
}

class EncodeService {

    private auto digest(string method, string data) {
        import std.conv : text;
        import std.digest : hexDigest;
        import std.digest.crc : CRC32, CRC64ECMA, CRC64ISO;
        import std.digest.md : MD5;
        import std.digest.murmurhash : MurmurHash3;
        import std.digest.ripemd : RIPEMD160;
        import std.digest.sha : SHA1, SHA224, SHA256, SHA384, SHA512_224, SHA512_256;
        import std.zlib : adler32;

        switch(method) {
            case "md5":
                return hexDigest!MD5(data).text;
            case "sha":
            case "sha1":
                return hexDigest!SHA1(data).text;
            case "sha224":
                return hexDigest!SHA224(data).text;
            case "sha256":
                return hexDigest!SHA256(data).text;
            case "sha384":
                return hexDigest!SHA384(data).text;
            case "sha512-224":
                return hexDigest!SHA512_224(data).text;
            case "sha512-256":
                return hexDigest!SHA512_256(data).text;
            case "crc32":
                return hexDigest!CRC32(data).text;
            case "crc64ecma":
                return hexDigest!CRC64ECMA(data).text;
            case "crc64iso":
                return hexDigest!CRC64ISO(data).text;
            case "murmurhash3-32":
                return hexDigest!(MurmurHash3!32)(data).text;
            case "murmurhash3-128":
                return hexDigest!(MurmurHash3!128)(data).text;
            case "adler32":
                return adler32(1, data).text;
            case "ripemd160":
                return hexDigest!RIPEMD160(data).text;
            default:
                enforceBadRequest(0, "Unknown method `"~method~"` selected.");
                assert(0);
        }
    }

    auto postDigest() {
        foreach (key; ["data", "method"])
            enforceBadRequest((key in request.json) !is null, "A `"~key~"` needs to be provided.");

        const data = request.json["data"].get!string;
        const method = request.json["method"].get!string;
        auto result = Json(["method": Json(method)]);
        result["digest"] = digest(method, data);
        return result;
    }

    private auto digestHmac(string method, const(ubyte)[] data, const(ubyte)[] secret) {
        import std.conv : text;
        import std.digest : hexDigest, toHexString;
        import std.digest.crc : CRC32, CRC64ECMA, CRC64ISO;
        import std.digest.hmac : hmac;
        import std.digest.md : MD5;
        import std.digest.murmurhash : MurmurHash3;
        import std.digest.ripemd : RIPEMD160;
        import std.digest.sha : SHA1, SHA224, SHA256, SHA384, SHA512_224, SHA512_256;
        import std.zlib : adler32;

        switch(method) {
            case "md5":
                return hmac!MD5(data, secret).toHexString.text;
            case "sha":
            case "sha1":
                return hmac!SHA1(data, secret).toHexString.text;
            case "sha224":
                return hmac!SHA224(data, secret).toHexString.text;
            case "sha256":
                return hmac!SHA256(data, secret).toHexString.text;
            case "sha384":
                return hmac!SHA384(data, secret).toHexString.text;
            case "sha512-224":
                return hmac!SHA512_224(data, secret).toHexString.text;
            case "sha512-256":
                return hmac!SHA512_256(data, secret).toHexString.text;
            case "murmurhash3-32":
                return hmac!(MurmurHash3!32)(data, secret).toHexString.text;
            case "murmurhash3-128":
                return hmac!(MurmurHash3!128)(data, secret).toHexString.text;
            case "ripemd160":
                return hmac!RIPEMD160(data, secret).toHexString.text;
            default:
                enforceBadRequest(0, "Unknown method `"~method~"` selected.");
                assert(0);
        }
    }


    auto postHmac() {
        foreach (key; ["data", "method", "secret"])
            enforceBadRequest((key in request.json) !is null, "A `"~key~"` needs to be provided.");

        const data = request.json["data"].get!string;
        const secret = request.json["secret"].get!string;
        const method = request.json["method"].get!string;
        auto result = Json(["method": Json(method)]);
        result["digest"] = digestHmac(method, data.representation, secret.representation);
        return result;
    }
}
