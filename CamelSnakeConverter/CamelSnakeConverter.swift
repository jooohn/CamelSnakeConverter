import Foundation

public extension String {
    public func toCamel(_ lower:Bool=true) -> String {
        let camel = capitalized.replacingOccurrences(of: "(\\w{0,1})_", with: "$1", options: .regularExpression, range: nil)
        return lower ? camel.replacingCharacters(in: camel.startIndex..<camel.index(camel.startIndex, offsetBy: 1), with: substring(to: self.characters.index(self.startIndex, offsetBy: 1)).lowercased()) : camel
    }
    
    public func toSnake() -> String? {
        let upperCased = replacingCharacters(in: startIndex..<index(startIndex, offsetBy: 1), with: substring(to: characters.index(startIndex, offsetBy: 1)).uppercased())
        guard let regex = try? NSRegularExpression(pattern: "[A-Z][a-z,\\d]+", options: []) else { return nil }
        let matches = regex.matches(in: upperCased, options: [], range: NSRange(location: 0, length: upperCased.characters.count))
        
        return matches.flatMap { (match) -> [String] in
            return (0 ..< match.numberOfRanges).flatMap({ (i) -> String? in
                let range = match.rangeAt(i)
                guard range.location != NSNotFound else { return nil }
                let matchString = (upperCased as NSString).substring(with: range)
                guard matchString.isEmpty == false else { return nil }
                return matchString.lowercased()
            })
            }.joined(separator: "_")
    }
}
