//
//  main.swift
//  ascii85
//
//  Created by Jonas Gessner on 13.06.21.
//  Copyright © 2021 Jonas Gessner. All rights reserved.
//

import Foundation
import ArgumentParser
import Base85

func fail(with message: String) -> Never {
    print(message)
    exit(1)
}

struct Base: ParsableCommand {
    static var configuration = CommandConfiguration(abstract: "ASCII85 encoding")
    
    @Flag(name: .shortAndLong, help: "Decode")
    var decode = false
    
    @Flag(name: .shortAndLong, help: "No newline (only applies to encoding)")
    var noNewline = false
    
    mutating func run() throws {
        guard isatty(FileHandle.standardInput.fileDescriptor) == 0, let data = try FileHandle.standardInput.readToEnd() else {
            fail(with: "No input provided")
        }
        
        if decode {
            guard let str = String(data: data, encoding: .ascii) else {
                fail(with: "Could not read input. Not ASCII?")
            }
            guard let decoded = Data(base85Encoded: str) else {
                fail(with: "Failed to decode")
            }
            FileHandle.standardOutput.write(decoded)
        }
        else {
            if noNewline {
                print(data.base85EncodedString(), terminator: "")
            }
            else {
                print(data.base85EncodedString())
            }
        }
    }
}

Base.main()
