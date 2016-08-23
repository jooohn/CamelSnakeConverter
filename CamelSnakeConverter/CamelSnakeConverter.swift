import Foundation

extension String {
    func toCamel(lower:Bool=true) -> String {
        let camel = capitalizedString.stringByReplacingOccurrencesOfString("(\\w{0,1})_", withString: "$1", options: .RegularExpressionSearch, range: nil)
        return lower ? camel.stringByReplacingCharactersInRange(camel.startIndex...camel.startIndex, withString: substringToIndex(self.startIndex.advancedBy(1)).lowercaseString) : camel
    }
    
    func toSnake() -> String? {
        let upperCased = stringByReplacingCharactersInRange(startIndex...startIndex, withString: substringToIndex(startIndex.advancedBy(1)).uppercaseString)
        guard let regex = try? NSRegularExpression(pattern: "[A-Z][a-z,\\d]+", options: []) else { return nil }
        let matches = regex.matchesInString(upperCased, options: [], range: NSRange(location: 0, length: upperCased.characters.count))
        
        return matches.flatMap { (match) -> [String] in
            return (0 ..< match.numberOfRanges).flatMap({ (i) -> String? in
                let range = match.rangeAtIndex(i)
                guard range.location != NSNotFound else { return nil }
                let matchString = (upperCased as NSString).substringWithRange(range)
                guard matchString.isEmpty == false else { return nil }
                return matchString.lowercaseString
            })
        }.joinWithSeparator("_")
    }
}