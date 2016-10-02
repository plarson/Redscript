import Foundation
import Redbird

public enum RedscriptError: Error {
    case scriptLoad
    case run(String, String)
}

public class Redscript {
    let redis: Redbird
    
    public init(redis: Redbird) {
        self.redis = redis
    }
    
    public func load(source: String, name: String) throws -> Script {
        if let script = self.cache[name] {
            return script
        }
        
        let script = Script(name: name, source: source)
        let responseDigest = try self.redis.command("SCRIPT", params: ["LOAD", source]).toString()
        
        if responseDigest != script.digest {
            throw RedscriptError.scriptLoad
        }
        
        self.cache[name] = script

        return script
    }
    
    public func run(script: Script, params: [String]) throws -> RespObject {
        let params = [ script.digest ] + params
        let response = try! self.redis.command("EVALSHA", params: params)
        
        if response.respType == .Error {
            let error = try! response.toError()
            
            if error.kind == "NOSCRIPT" {
                self.cache[script.name] = nil
                try! _ = self.load(source: script.source, name: script.name)
                return try! self.run(script: script, params: params)
            } else {
                throw RedscriptError.run(error.kind ?? "Unknown", error.message ?? "")
            }
        }
        
        return response
    }
    
    var cache: [String:Script] = [:]
}
