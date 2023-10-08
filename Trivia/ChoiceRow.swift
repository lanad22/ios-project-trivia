//
//  ChoiceRow.swift
//  Trivia
//
//  Created by Lana Do on 10/7/23.
//

import Foundation
import SwiftUI

struct ChoiceRow: View {
    @EnvironmentObject var trivia: TriviaViewController
    var choice: Choice
    @State private var isSelected = false

    // Custom colors
    var green = Color(hue: 0.437, saturation: 0.711, brightness: 0.711)
    var red = Color(red: 0.71, green: 0.094, blue: 0.1)
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "circle.fill")
                .font(.caption)
            
            Text(choice.text)
                .bold()
            
            if isSelected {
                Spacer()
                
                Image(systemName: choice.isCorrect ? "checkmark.circle.fill" : "x.circle.fill")
                    .foregroundColor(choice.isCorrect ? green : red)
            }
        }
        .padding()
        .frame(maxWidth: 300, alignment: .leading)
        .foregroundColor(trivia.choiceSelected ? (isSelected ? Color("AccentColor") : .gray) : Color("AccentColor"))
        .background(.white)
        .cornerRadius(10)
        .shadow(color: isSelected ? choice.isCorrect ? green : red : .gray, radius: 5, x: 0.5, y: 0.5)
        .onTapGesture {
            if !trivia.choiceSelected {
                isSelected = true
                trivia.selectChoice(choice: choice)

            }
        }
    }
}

struct AnswerRow_Previews: PreviewProvider {
    static var previews: some View {
       ChoiceRow(choice: Choice(text: "Single", isCorrect:  false))
            .environmentObject(TriviaViewController())
    }
}
