//
//  ContentView.swift
//  CazinoGame
//
//  Created by Ruslan Ishmukhametov on 31.10.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var symvols = ["robot", "jake", "finn"]
    @State private var numbers = Array(repeating: 0, count: 9)
    @State private var backgrounds = Array(repeating: Color.white, count: 9)
    @State private var credits = 1000
    private var betAmount = 5
    
    var body: some View {
        
        ZStack {
            
            Rectangle()
                .foregroundColor(Color(red:200/255, green: 143/255, blue: 32/255))
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            Rectangle()
                .foregroundColor(Color(red:228/255, green: 195/255, blue: 76/255))
                .rotationEffect(Angle(degrees: 45))
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                
                Spacer()
                
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("Казино")
                        .bold()
                        .foregroundColor(.white)
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }.scaleEffect(2)
                
                Spacer()
                
                Text("Credits: " + String(credits))
                    .foregroundColor(.black)
                    .padding(.all, 10)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(20)
                
                Spacer()
                
                VStack {
                    
                    HStack {
                        
                        CardView(symvol: $symvols[numbers[0]], background: $backgrounds[0])
                        
                        CardView(symvol: $symvols[numbers[1]], background: $backgrounds[1])
                        
                        CardView(symvol: $symvols[numbers[2]], background: $backgrounds[2])
                    }
                    
                    HStack {
                        
                        CardView(symvol: $symvols[numbers[3]], background: $backgrounds[3])
                        
                        CardView(symvol: $symvols[numbers[4]], background: $backgrounds[4])
                        
                        CardView(symvol: $symvols[numbers[5]], background: $backgrounds[5])
                    }
                    
                    HStack {
                        
                        CardView(symvol: $symvols[numbers[6]], background: $backgrounds[6])
                        
                        CardView(symvol: $symvols[numbers[7]], background: $backgrounds[7])
                        
                        CardView(symvol: $symvols[numbers[8]], background: $backgrounds[8])
                    }
                    
                    
                }
                
                Spacer()
                
                //  Кнопка
                
                HStack(spacing: 20) {
                    
                    VStack {
                        Button(action: {
                            // Код для одиночного вращения
                            self.processResults()
                        }) {
                            Text("Spin")
                                .bold()
                                .foregroundColor(.white)
                                .padding(.all, 10)
                                .padding(.horizontal, 30)
                                .background(Color.pink)
                                .cornerRadius(20)
                        }
                        Text("\(betAmount) credits")
                            .padding(.top, 10)
                            .font(.footnote)
                    }
                    
                    VStack {
                        Button(action: {
                            // Код для максимального вращения
                            self.processResults(true)
                        }) {
                            Text("Max spin")
                                .bold()
                                .foregroundColor(.white)
                                .padding(.all, 10)
                                .padding(.horizontal, 30)
                                .background(Color.pink)
                                .cornerRadius(20)
                        }
                        Text("\(betAmount * 5) credits")
                            .padding(.top, 10)
                            .font(.footnote)
                    }
                }
                
                Spacer()
            }
        }
    }
    
    func processResults(_ isMax: Bool = false) {
        // Верни старндартный фон карточек
        self.backgrounds = self.backgrounds.map { _ in
            Color.white
        }
        
        if isMax {
            // Перемешай все карты
            self.numbers = self.numbers.map({ _ in
                Int.random(in: 0...symvols.count - 1)
            })
            
        } else {
            // Перемешая только средний ряд
            self.numbers[3] = Int.random(in: 0...symvols.count - 1)
            
            self.numbers[4] = Int.random(in: 0...symvols.count - 1)
            
            self.numbers[5] = Int.random(in: 0...symvols.count - 1)
            
        }
        
        // Проверка выигрыша
        porcessWin(isMax)
        
    }
    
    func porcessWin(_ isMax: Bool = false) {
        
        var matches = 0
        
        if !isMax {
            
            // Обработка для одиночного перемешивания

            if isMatch(3, 4, 5) { matches += 1 }
    
        } else {
            
            // Обработка для полного перемешивания
            
            // Первый ряд
            if isMatch(0, 1, 2) { matches += 1 }

            // Средний ряд
            if isMatch(3, 4, 5) { matches += 1 }

            // Нижний ряд
            if isMatch(6, 7, 8) { matches += 1 }

            // Диаганаль слева
            if isMatch(0, 4, 8) { matches += 1 }

            // Диаганаль справа
            if isMatch(2, 4, 6) { matches += 1 }


        }
        
        // Проверка выигрыша
        
        if matches > 0 {
            //  Как минимум 1 победа
            self.credits += matches * betAmount * 2
            
        } else if !isMax {
            // Одиночный спин с нулевыми выигрышами
            self.credits -= betAmount
            
        } else {
            // Нет выигрышей при максимальном перемешивании
            self.credits -= betAmount * 5

        }
        
    }
    
    func isMatch(_ index1: Int, _ index2: Int, _ index3: Int) -> Bool {
        
        if self.numbers[index1] == self.numbers[index2] &&
            self.numbers[index2] == self.numbers[index3] {
            
            self.backgrounds[index1] = Color.green
            self.backgrounds[index2] = Color.green
            self.backgrounds[index3] = Color.green
            
            return true
            
        }
        
        return false
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
