import Foundation
import Hash

public struct Script {
    public let name: String
    public let source: String
    
    public var digest: String {
        return try! Hash.make(.sha1, self.source.bytes).hexString.lowercased()
    }
}
