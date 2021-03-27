import Foundation
#if os(Linux)
    import Glibc
#else
    import Darwin.C
#endif

struct Term {
    static let CLEAR_SCREEN = "\u{001B}[2J"
    static let ALTERNATE_SCREEN = "\u{001B}[?1049h"
    static let MAIN_SCREEN = "\u{001B}[?1049l"
    static let CURSOR_HIDE = "\u{001B}[?25l"
    static let CURSOR_SHOW = "\u{001B}[?25h"
    static let RESET = "\u{001B}[0m"
    
    static let FOREGROUND_DEFAULT = "39"
    static let FOREGROUND_BLACK = "30"
    static let FOREGROUND_RED = "31"
    static let FOREGROUND_GREEN = "32"
    static let FOREGROUND_YELLOW = "33"
    static let FOREGROUND_BLUE = "34"
    static let FOREGROUND_MAGENTA = "35"
    static let FOREGROUND_CYAN = "36"
    static let FOREGROUND_LIGHT_GRAY = "37"
    static let FOREGROUND_DARK_GRAY = "90"
    static let FOREGROUND_LIGHT_RED = "91"
    static let FOREGROUND_LIGHT_GREEN = "92"
    static let FOREGROUND_LIGHT_YELLOW = "93"
    static let FOREGROUND_LIGHT_BLUE = "94"
    static let FOREGROUND_LIGHT_MAGENTA = "95"
    static let FOREGROUND_LIGHT_CYAN = "96"
    static let FOREGROUND_WHITE = "97"
    
    static let BACKGROUND_DEFAULT = "49"
    static let BACKGROUND_BLACK = "40"
    static let BACKGROUND_RED = "41"
    static let BACKGROUND_GREEN = "42"
    static let BACKGROUND_YELLOW = "43"
    static let BACKGROUND_BLUE = "44"
    static let BACKGROUND_MAGENTA = "45"
    static let BACKGROUND_CYAN = "46"
    static let BACKGROUND_LIGHT_GRAY = "47"
    static let BACKGROUND_DARK_GRAY =  "100"
    static let BACKGROUND_LIGHT_RED = "101"
    static let BACKGROUND_LIGHT_GREEN = "102"
    static let BACKGROUND_LIGHT_YELLOW = "103"
    static let BACKGROUND_LIGHT_BLUE = "104"
    static let BACKGORUND_LIGHT_MAGENTA = "105"
    static let BACKGROUND_LIGHT_CYAN = "106"
    static let BACKGROUND_WHITE = "107"
    
    static func goto(x: Int, y: Int) -> String {
        "\u{001B}[\(y);\(x)H"
    }
    
    static func print(_ value: String) {
        _print(value, terminator: "")
    }
    
    static func flush() {
        fflush(stdout)
    }
    
    static func size() throws -> Size {
        var sz = winsize()
        let success = ioctl(FileHandle.standardInput.fileDescriptor, TIOCGWINSZ, &sz)
        if success != 0 {
            throw TerminalError.GenericError("Could not get size of terminal window")
        }
        return Size(width: Int(sz.ws_col), height: Int(sz.ws_row))
    }
}

// Wrap print function so we don’t shadow it in Term struct
private func _print(_ items: String, terminator: String = "\n") {
    print(items, terminator: terminator)
}
