//
//  CodeBreaker.swift
//  CodeBreakerGame
//
//  Created by Varshitha VRaj on 31/05/26.
//

import SwiftUI

extension Peg {
   static let missing = Color.clear
}

typealias Peg = Color

// Serves the core logic for the game
struct CodeBreaker {
    
    var masterCode: Code = Code(kind: .master)
    var guess: Code = Code(kind: .guess)
    var attempts: [Code] = [Code]()
    var pegChoices: [Peg] = [.red, .green, .blue, .yellow]
    
    init(pegChoices: [Peg] = [.brown, .yellow, .orange, .black]) {
        self.pegChoices = pegChoices
        masterCode.randomize(from: pegChoices)
    }
    
    
   // Take the current guess.
   // Convert it into a historical attempt.
   // Save it in the list of attempts.
    mutating func attemtGuess(){
        var attempt = guess
        attempt.kind = .attempt(guess.match(against: masterCode))
        attempts.append(attempt)
    }
    
    
   // When the user taps a peg in their guess, change that peg to the next available color
    mutating func changeGuessPeg(at index: Int){
        let existingPeg = guess.pegs[index]
        if let indexOfExistingPegInPegChoices = pegChoices.firstIndex(of: existingPeg) {
            let newPeg = pegChoices[(indexOfExistingPegInPegChoices + 1) % pegChoices.count]
            guess.pegs[index] = newPeg
        } else {
            guess.pegs[index] = pegChoices.first ?? Code.missingPeg
        }
    }
    
}


//This Code is the array of pegs
// This Code will store the information of , that type of code this is and the code
struct Code {
    
    var kind: Code.Kind
    var pegs: [Peg] = Array(repeating: Code.missingPeg, count: 4)
    
    static let missingPeg: Peg = .clear
    
    
    //code can be of different types
    enum Kind: Equatable {
        // if its a master code , then the code is non-editable , and not shown to the user
        case master
        // if its a guess code it is editable
        case guess
        // only the present attempt is editable , previous ones are non editable
        case attempt([Match])
    
        case unknown
    }
    
    mutating func randomize(from pegChoice: [Peg]){
        for index in pegChoice.indices {
            pegs[index] = pegChoice.randomElement() ?? Code.missingPeg
        }
    }
    
    var matches: [Match]? {
        switch kind {
        case .attempt(let matches):
            return matches
            
        default: return nil
            
        }
    }
    
    // Compares this code against another code and returns the match result
    func match(against otherCode: Code) -> [Match] {
        
        var pegsToMatch = otherCode.pegs
        
        let backwardsExactMatch = pegs.indices.reversed().map{ index in
            // Same color in the same position?
            if pegsToMatch.count > index,
               pegsToMatch[index] == pegs[index] {
                // Remove the matched peg so it can't be reused later
                pegsToMatch.remove(at: index)
                // Mark as an exact match
                return Match.exact
            } else {
                return .nomatch
            }
        }

        let exactMatches = Array(backwardsExactMatch.reversed())
        return pegs.indices.map{ index in
            if exactMatches[index] == .exact ,
               let matchIndex = pegsToMatch.firstIndex(of: pegs[index]){
                pegsToMatch.remove(at: matchIndex)
                return .inexact
            } else {
                return exactMatches[index]
            }
        }

    }
    
    
}

