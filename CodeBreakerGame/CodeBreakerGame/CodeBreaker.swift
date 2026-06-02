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
            guess.pegs[index] = pegChoices.first ?? Code.missing
        }
    }
    
}


//This Code is the array of pegs
// This Code will store the information of , that type of code this is and the code
struct Code {
    
    var kind: Code.Kind
    var pegs: [Peg] = Array(repeating: Code.missing, count: 4)
    
    static let missing: Peg = .clear
    
    
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
            pegs[index] = pegChoice.randomElement() ?? Code.missing
        }
    }
    
    var matches: [Match] {
        switch kind {
        case .attempt(let matches):
            return matches
            
        default: return []
            
        }
    }
    
    // Compares this code against another code and returns the match result
    func match(against otherCode: Code) -> [Match] {

        // Start by assuming every peg is a non-match
        var results: [Match] = Array(repeating: .nomatch, count: pegs.count)

        // Create a working copy of the other code's pegs.
        // We'll remove matched pegs as we find them to avoid counting them twice.
        var pegsToMatch = otherCode.pegs

        // PASS 1: Find all exact matches
        // Iterate backwards because we're removing elements from pegsToMatch.
        for index in pegs.indices.reversed() {

            // Same color in the same position?
            if pegsToMatch.count > index,
               pegsToMatch[index] == pegs[index] {

                // Mark as an exact match
                results[index] = .exact

                // Remove the matched peg so it can't be reused later
                pegsToMatch.remove(at: index)
            }
        }

        // PASS 2: Find inexact matches
        // (correct color, wrong position)
        for index in pegs.indices {

            // Skip pegs already marked as exact
            if results[index] != .exact {

                // Does this peg exist somewhere in the remaining unmatched pegs?
                if let matchIndex = pegsToMatch.firstIndex(of: pegs[index]) {

                    // Mark as an inexact match
                    results[index] = .inexact

                    // Remove it so it can't match another peg later
                    pegsToMatch.remove(at: matchIndex)
                }
            }
        }

        // Return the completed match results
        return results
    }
    
    
}

