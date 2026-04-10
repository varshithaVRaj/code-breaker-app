//
//  CodeBreaker.swift
//  CodeBreakerGame
//

import SwiftUI

typealias Peg = Color

public struct CodeBreaker {
    
    var masterCode: Code = Code(kind: .master)
    var guess: Code = Code(kind: .guess)
    var attempts: [Code] = [Code]()
    var pegChoices: [Peg] = [.red, .green, .blue, .yellow]
    
}

struct Code {
    
    var kind: kind //Waht type of code is this
    var pegs: [Peg] = [.green, .red, .red, .yellow] // each peg 
    
    enum kind {
        case master
        case guess
        case attempt
        case unKnown
    }
    
    
}
