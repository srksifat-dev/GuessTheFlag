//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Md. Shoibur Rahman Khan Sifat on 10/1/24.
//

import SwiftUI

struct FlagImage: View {
    var images: [String]
    var number: Int
    var body: some View {
        Image(images[number])
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

struct LargeTitle:ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.weight(.semibold))
            .foregroundColor(.white)
    }
}

extension View{
    func flagTitle()->some View{
        modifier(LargeTitle())
    }
}

struct ContentView: View {
    @State private var countries: [String] = ["Estonia","France","Germany","Ireland","Italy","Monaco","Nigeria","Poland","Spain","UK","Ukraine","US"].shuffled()
    @State private var scoreShowing: Bool = false
    @State private var alertTitle: String = ""
    @State private var correctAnswer:Int = Int.random(in: 1...2)
    @State private var questionAnswered: Double = 0
    @State private var score:Int = 0
    @State private var correct: Int = 0
    @State private var incorrect: Int = 0
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
                        .flagTitle()
                    VStack(spacing:15){
                        ForEach(0..<3){number in
                            Button{
                                flagTapped(number)
                            }label: {
                                FlagImage(images: countries, number: number)
                            }
                            
                        }
                    }
                }
                .frame(maxWidth:.infinity)
                .padding(.vertical,16)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 16))
                Spacer()
                ProgressView(value: questionAnswered, total:8.0)
                    .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                                    
                HStack{
                    Text("0")
                        .foregroundColor(.white)
                    Spacer()
                    Text("8")
                        .foregroundColor(.white)
                }
                Spacer()
            }
            .padding(.horizontal,16)
        }
        .alert("Game is over!", isPresented: $scoreShowing){
            Button("Reset",action: reset)
        }message: {
                Text("Your score is \(score) (✅ +\(correct) ⛔️ -\(incorrect))")
                
            
            
        }
        .ignoresSafeArea()
    }
    func flagTapped(_ number:Int){
            if number == correctAnswer{
                score += 1
                questionAnswered += 1
                correct += 1
                if questionAnswered == 8{
                    scoreShowing = true
                }else{
                    askQuestion()
                }
                
            }else{
                score -= 1
                questionAnswered += 1
                incorrect += 1
                if questionAnswered == 8{
                    scoreShowing = true
                }else{
                    askQuestion()
                }
                
            }
            
    }
    func askQuestion(){
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0..<3)
    }
    func reset(){
        questionAnswered = 0
        score = 0
        askQuestion()
    }
}

//#Preview {
//    ContentView()
//}
