extension RedscriptTests {
    static var allTests : [(String, (RedscriptTests) -> () throws -> Void)] {
        return [
            ("testRegister", testRegister),
            ("testScriptRun", testScriptRun),
            ("testFlush", testFlush)
        ]
    }
}
