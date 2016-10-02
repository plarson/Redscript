# Redscript

Redis script manager for ["Redbird"](https://github.com/vapor/redbird).

> Easily load scripts into Redis' script cache 

Redscript caches the sha1 digest in a cache allowing it to invoke the script on Redis using the hash instead of eval'ing it each time.

Redscript also guards against script flushes on Redis. If the Redis script cache is flushed or the script disappears for whatever reason, Redscript will automatically detect this and re-load the script into Redis before executing.

Based on ["Scripty"](https://github.com/TheDeveloper/scripty)

# Installation

## Swift Package Manager

```swift
.Package(url: "https://github.com/plarson/redscript", majorVersion: 0, minor: 1)
```

:gift_heart: Contributing
------------
Please create an issue with a description of your problem or open a pull request with a fix.

:v: License
-------
MIT

:alien: Author
------
Phil Larson - http://dizm.com
