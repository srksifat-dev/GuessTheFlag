//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Md. Shoibur Rahman Khan Sifat on 10/1/24.
//

import SwiftUI

struct ContentView: View {
    @State private var countries: [String] = ["Estonia","France","Germany","Ireland","Italy","Monaco","Nigeria","Poland","Spain","UK","Ukraine","US"].shuffled()
    @State private var scoreShowing: Bool = false
    @State private var alertTitle: String = ""
    @State private var correctAnswer:Int = Int.random(in: 1...2)
    @State private var score:Int = 0
    var body: some View {
        ZStack{
            LinearGradient(colors: [.blue, .black], startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack {
                Spacer()
                Text("Guess The Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                Spacer()
                VStack{
                    Text("Tap for the flag of")
                        .font(.headline.weight(.semibold))
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .font(.largeTitle.weight(.semibold))
                        .foregroundColor(.white)
                    VStack(spacing:15){
                        ForEach(0..<3){number in
                            Button{
                                flagTapped(number)
                            }label: {
                                Image(countries[number])
                                    .clipShape(.capsule)
                                    .shadow(radius: 5)
                            }
                            
                        }
                    }
                }
                .frame(maxWidth:.infinity)
                .padding(.vertical,16)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 16))
                Spacer()
                Text("Score: \(score)")
                    .font(.title.weight(.semibold))
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.horizontal,16)
        }
        .alert(alertTitle, isPresented: $scoreShowing){
            Button("Continue",action: askQuestion)
        }message: {
            Text("Your score is \(score)")
        }
        .ignoresSafeArea()
    }
    func flagTapped(_ number:Int){
        if number == correctAnswer{
            alertTitle = "Correct!"
            score += 1
        }else{
            alertTitle = "Wrong!"
            score -= 1
        }
        scoreShowing = true
    }
    func askQuestion(){
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0..<3)
    }
}

#Preview {
    ContentView()
}
