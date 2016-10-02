import XCTest
import Redbird
@testable import Redscript
import Foundation

let source = "return KEYS[1]"

class RedscriptTests: XCTestCase {
    var redis: Redbird!
    var redscript: Redscript!
    
    override func setUp() {
        super.setUp()

        let config = RedbirdConfig(address: "127.0.0.1", port: 6379)
        self.redis = try! Redbird(config: config)
        self.redscript = Redscript(redis: self.redis)
    }
    
    override func tearDown() {
        _ = try! self.redis.command("FLUSH")
    }
    
    func testRegister() {
        let script = try! self.redscript.load(source: source, name: "blank")
        let scriptExists = try! self.redis.command("SCRIPT", params: ["EXISTS", script.digest]).toArray()
        let result = try! scriptExists[0].toInt()
        XCTAssertEqual(result, 1)
    }
    
    func testScriptRun() {
        let script = try! self.redscript.load(source: source, name: "blank")
        let result = try! self.redscript.run(script: script, params: [String(1), "hi"]).toString()
        XCTAssertEqual(result, "hi")
    }

    func testFlush() {
        let script = try! self.redscript.load(source: source, name: "blank")
        _ = try! self.redis.command("FLUSH")
        let result = try! self.redscript.run(script: script, params: [String(1), "hi"]).toString()
        XCTAssertEqual(result, "hi")
    }
    
}
