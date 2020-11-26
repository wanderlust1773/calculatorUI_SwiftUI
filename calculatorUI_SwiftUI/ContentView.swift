//
//  ContentView.swift
//  calculator_SwiftUI
//
//
//
import SwiftUI

enum CalculatorButton:String{
    
    case zero, one, two, three, four, five, six, seven, eight, nine
    case equals, plus, minus, multifly, divide
    case decimal
    case ac, plusMinus, percent
    
    var title:String{
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .divide: return "/"
        case .plus: return "+"
        case .minus: return "-"
        case .multifly: return "X"
        case .plusMinus: return "+/-"
        case .percent: return "%"
        case .equals: return "="
        case .decimal: return "."

        default:
            return "AC"
        }
    }
    
    var backgroundColor: Color{
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            return Color(.darkGray)
        case .ac, .plusMinus, .percent:
            return Color(.lightGray)
        default:
            return Color.orange
        }
    }
}

//Env object
class GlobalEnviromnet: ObservableObject{
    
    @Published var display = ""
    
    func receiveInput(calculatorButton: CalculatorButton){
        self.display = calculatorButton.title
    }
}


struct ContentView: View {
    
    @EnvironmentObject var env: GlobalEnviromnet
    
    let buttons:[[CalculatorButton]] = [
        [.ac, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multifly],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equals]

    ]
    
    var body: some View {
        
        ZStack(alignment: .bottom){ //alignment로 내용물 바닥에 붙이기
            Color.black.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)//모서리 무시 유무
            
            VStack(spacing: 12){ //버튼 간격
                
                HStack{
                    Spacer()//결과창 우측정렬
                    Text(env.display).foregroundColor(.white)
                        .font(.system(size: 64))
                }.padding()
                
                 
                ForEach(buttons, id:\.self) { row in
                    HStack(spacing:12){
                        ForEach(row, id:\.self) { button in
                            CalculatorButtonView(button: button)
                            
                        }
                    }
                }
            }.padding(.bottom)
        }
    }
    
    
}

struct CalculatorButtonView:View {
    
    var button: CalculatorButton
    
    @EnvironmentObject var env: GlobalEnviromnet
    
    var body: some View{
        Button(action:{
            
            self.env.receiveInput(calculatorButton: button)
        })  {
        
            Text(button.title)
            .font(.system(size: 32))
            .frame(width:self.butttonWidth(button: button), height:(UIScreen.main.bounds.width - 5 * 12) / 4)
            .foregroundColor(.white) // 버튼 텍스트컬러
            .background(button.backgroundColor) // 버튼 배경 컬러
                .cornerRadius(self
                .butttonWidth(button: button)) // 버튼 동그랗게
                
        }
    }
    
    private func butttonWidth(button: CalculatorButton) -> CGFloat{
        
        if button == .zero{
           return (UIScreen.main.bounds.width - 3 * 12) / 4 * 2 //zero button 크기
        }
        return (UIScreen.main.bounds.width - 5 * 12) / 4
        //기기 가로 기준 버튼 사이즈 맞추기
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalEnviromnet())
    }
}
