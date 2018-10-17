import Foundation

guard CommandLine.arguments.count > 1 else {
    print("Usecase: swift XCodeTemplateGenerator.swift $SOURCE_FOLDER")
    exit(0)
}

let directoryURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath, isDirectory: true)
let sourceFolder = "/" + CommandLine.arguments[1].replacingOccurrences(of: "/", with: "")
let plistURL = directoryURL.appendingPathComponent(sourceFolder).appendingPathComponent("TemplateInfo.plist")

func savePropertyList(_ plist: Any) throws {
    let plistData = try PropertyListSerialization.data(fromPropertyList: plist, format: .xml, options: 0)
    try plistData.write(to: plistURL)
}

func loadPropertyList() throws -> [String: Any] {
    let data = try Data(contentsOf: plistURL)
    guard let plist = try PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any] else {
        return [String: Any]()
    }
    return plist
}

func shouldCreatePropertyList() -> Bool {
    do {
        _ = try loadPropertyList()
        return false
    } catch {
        return true
    }
}

func createPropertyList() throws {
    var plist = [String: Any]()
    plist["Kind"] = "Xcode.Xcode3.ProjectTemplateUnitKind"
    plist["Identifier"] = "com.xcprojecttemplategen.default"
    plist["Ancestors"] = ["com.apple.dt.unit.coreDataCocoaTouchApplication"]
    plist["Concrete"] = true
    plist["Description"] = "Default Description"
    plist["SortOrder"] = 1
    setNodes(in: &plist, to: [])
    plist["Definitions"] = [:]
    plist["Template Author"] = "Nathan Tannar @nathantannar4"
    try savePropertyList(plist)
}

func setNodes(in plist: inout [String: Any], to nodes: [String]) {
    var options = [Any]()
    var units = [String: Any]()
    var files = [String: Any]()
    files["Nodes"] = nodes
    units["Swift"] = files
    options.append(["Identifier": "languageChoice", "Units": units])
    plist["Options"] = options
}

func setDefinition(in plist: inout [String: Any], key: String, to definition: [String: Any]) {
    var definitions = (plist["Definitions"] as? [String: Any]) ?? [:]
    definitions[key] = definition
    plist["Definitions"] = definitions
}

func makeDefinition(path: String, relativeFilePath: String) -> [String: Any] {
    var definition = [String: Any]()
    definition["Path"] = path
    definition["Group"] = relativeFilePath.components(separatedBy: "/").filter { return !$0.isEmpty }
    return definition
}

if shouldCreatePropertyList() {
    try! createPropertyList()
}

var plist = try! loadPropertyList()
setNodes(in: &plist, to: [])
plist["Definitions"] = [:]

let resourceKeys: [URLResourceKey] = [.isDirectoryKey, .nameKey]
let enumerator = FileManager.default.enumerator(at: directoryURL, includingPropertiesForKeys: resourceKeys, options: [.skipsHiddenFiles], errorHandler: { (url, error) -> Bool in
    fatalError("directoryEnumerator error at \(url): \(error)")
})!

var nodes = [String]()

let keySet = Set(resourceKeys)
let basePath = directoryURL.path
let extensions = [".swift", ".plist", ".storyboard", ".xib", ".strings"]
for case let fileURL as URL in enumerator {
    let resourceValues = try! fileURL.resourceValues(forKeys: keySet)
    let name = resourceValues.name!
    let pathFromBase = fileURL.path.replacingOccurrences(of: basePath, with: "")
    if resourceValues.isDirectory == false {
        if pathFromBase.hasPrefix(sourceFolder) && name != "TemplateInfo.plist" {
            if extensions.first(where: { name.hasSuffix($0) }) != nil && !name.hasPrefix("Example_") {
                let key = pathFromBase.replacingOccurrences(of: sourceFolder + "/", with: "")
                nodes.append(key)
                let relativeFilePath = pathFromBase.replacingOccurrences(of: sourceFolder, with: "").replacingOccurrences(of: name, with: "")
                let definition = makeDefinition(path: key, relativeFilePath: relativeFilePath)
                setDefinition(in: &plist, key: key, to: definition)
            } 
        } else if name == "Podfile" || name == "Cartfile" {
            let key = "../" + pathFromBase.replacingOccurrences(of: "/", with: "")
            nodes.append(key)
            let definition = ["Path": name]
            setDefinition(in: &plist, key: key, to: definition)
        }
    }
}

setNodes(in: &plist, to: nodes)
try! savePropertyList(plist)



