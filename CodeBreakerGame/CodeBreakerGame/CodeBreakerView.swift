//
//  CodeBreakerView.swift
//  CodeBreakerGame
//
//  Created by Varshitha VRaj on 29/03/26.
//

import SwiftUI
 
struct CodeBreakerView: View {

    let game = CodeBreaker()
    
    var body: some View {
        
        VStack {
            view(for: game.masterCode)
            view(for: game.guess)
        }
        .padding()
    }
    
    func view(for code: Code) -> some View {
        HStack {
            ForEach(code.pegs.indices, id: \.self)  { index in
                RoundedRectangle(cornerRadius: 10)
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundStyle(code.pegs[index])
            }
        }
        
    }
    
}


#Preview {
    CodeBreakerView()
}
