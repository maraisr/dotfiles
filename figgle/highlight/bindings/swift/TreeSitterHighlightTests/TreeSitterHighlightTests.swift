import XCTest
import SwiftTreeSitter
import TreeSitterHighlight

final class TreeSitterHighlightTests: XCTestCase {
    func testCanLoadGrammar() throws {
        let parser = Parser()
        let language = Language(language: tree_sitter_highlight())
        XCTAssertNoThrow(try parser.setLanguage(language),
                         "Error loading Highlight grammar")
    }
}
