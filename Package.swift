// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "JavaScriptCore",
    platforms: [
        .macOS(.v12),
        .iOS(.v14),
        .tvOS(.v14)
    ],
    products: [
        .library(
            name: "SJavaScriptCore",
            targets: ["SJavaScriptCore"]),
    ],
    dependencies: [
        .package(name: "JavaScript"),
        .package(name: "Test"),
    ],
    targets: [
        .target(
            name: "CJavaScriptCore",
            dependencies: []),
        .target(
            name: "SJavaScriptCore",
            dependencies: ["CJavaScriptCore", "JavaScript"])
    ]
)

// MARK: - tests

testTarget("SJavaScriptCore") { test in
    test("JavaScript")
    test("JSValue")
}

func testTarget(_ target: String, task: ((String) -> Void) -> Void) {
    task { test in addTest(target: target, name: test) }
}

func addTest(target: String, name: String) {
    package.targets.append(
        .executableTarget(
            name: "Tests/\(target)/\(name)",
            dependencies: ["Test", "SJavaScriptCore"],
            path: "Tests/\(target)/\(name)"))
}

// MARK: - custom package source

#if canImport(ObjectiveC)
import Darwin.C
#else
import Glibc
#endif

extension Package.Dependency {
    enum Source: String {
        case local, remote, github

        static var `default`: Self { .github }

        var baseUrl: String {
            switch self {
            case .local: return "../"
            case .remote: return "https://swiftstack.io/"
            case .github: return "https://github.com/swiftstack/"
            }
        }

        func url(for name: String) -> String {
            return self == .local
                ? baseUrl + name.lowercased()
                : baseUrl + name.lowercased() + ".git"
        }
    }

    static func package(name: String) -> Package.Dependency {
        guard let pointer = getenv("SWIFTSTACK") else {
            return .package(name: name, source: .default)
        }
        guard let source = Source(rawValue: String(cString: pointer)) else {
            fatalError("Invalid source. Use local, remote or github")
        }
        return .package(name: name, source: source)
    }

    static func package(name: String, source: Source) -> Package.Dependency {
        return source == .local
            ? .package(name: name, path: source.url(for: name))
            : .package(name: name, url: source.url(for: name), .branch("dev"))
    }
}
