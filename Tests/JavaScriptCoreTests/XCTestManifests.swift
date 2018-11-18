#if !canImport(ObjectiveC)
import XCTest

extension JSValueTests {
    // DO NOT MODIFY: This is autogenerated, use: 
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__JSValueTests = [
        ("testIsBool", testIsBool),
        ("testIsNull", testIsNull),
        ("testIsNumber", testIsNumber),
        ("testIsString", testIsString),
        ("testIsUndefined", testIsUndefined),
        ("testProperty", testProperty),
        ("testToInt", testToInt),
        ("testToString", testToString),
    ]
}

extension JavaScriptCoreTests {
    // DO NOT MODIFY: This is autogenerated, use: 
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__JavaScriptCoreTests = [
        ("testArguments", testArguments),
        ("testCapture", testCapture),
        ("testClosure", testClosure),
        ("testEvaluate", testEvaluate),
        ("testException", testException),
        ("testFunction", testFunction),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(JSValueTests.__allTests__JSValueTests),
        testCase(JavaScriptCoreTests.__allTests__JavaScriptCoreTests),
    ]
}
#endif
