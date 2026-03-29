//
//  MatchMarkers.swift
//  CodeBreakerGame
//
//  Created by Varshitha VRaj on 29/03/26.
//

import SwiftUI


enum Match {
    
    case nomatch
    case exact
    case inexact
    
}

struct MatchMarkers: View {
    
    // We need to target this match !, this is what we need to match
    var matches: [Match]
    
    var body: some View {
        
        HStack {
            
            VStack {
                
                matchMarker(peg: 0)
                
                matchMarker(peg: 1)
               
            }
            
            VStack {
              
                matchMarker(peg: 2)
                
                matchMarker(peg: 3)
                
            }
            
        }
        
    }
    
    
    @ViewBuilder
    func matchMarker(peg: Int) -> some View { 
        
        //MARK: we are going to have 2 variables
        // 1) Exact:- How many mathces are exact
        // 2) Found Match:- Matches other than exact match
        // By this we are checking 2 conditions (is it found and is it not found)
        
        let exactCount: Int = matches.count { $0 == .exact }
        
        let foundMatch: Int = matches.count { $0 != .nomatch }
        
        
        //The inner fill visualizes the count of .exact.
       //The outline visualizes the count of any match (.exact + .inexact).
       // Using > with zero-based peg avoids off-by-one: the first exactCount pegs fill, and the first foundMatch pegs outline.
        
        Circle()
            .fill(exactCount > peg ? Color.primary : Color.clear)
            .strokeBorder(foundMatch > peg ? Color.primary : Color.clear, lineWidth: 2).aspectRatio(1, contentMode: .fit)
    }
    
    
}


#Preview {
    MatchMarkers(matches: [.nomatch, .exact, .nomatch, .inexact ])
}
