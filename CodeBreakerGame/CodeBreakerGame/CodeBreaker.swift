//
//  CodeBreaker.swift
//  CodeBreakerGame
//
//  Created by Varshitha VRaj on 31/05/26.
//

import SwiftUI

typealias Peg = Color

// Serves the core logic for the game
struct CodeBreaker {
    
    var masterCode: Code = Code(kind: .master)
    var guess: Code = Code(kind: .guess)
    var attempts: [Code] = [Code]()
    var pegChoices: [Peg] = [.red, .green, .blue, .yellow]
    
}


//This Code is the array of pegs
// This Code will store the information of , that type of code this is and the code
struct Code {
    
    var kind: Code.Kind
    var pegs: [Peg] = [.green, .red, .red, .yellow]
    
    
    //code can be of different types
    enum Kind {
        // if its a master code , then the code is non-editable , and not shown to the user
        case master
        // if its a guess code it is editable
        case guess
        // only the present attempt is editable , previous ones are non editable
        case attempt
    
        case unknown
    }
    
}

