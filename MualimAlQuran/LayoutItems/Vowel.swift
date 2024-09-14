import SwiftUI

struct Vowel: View {
    
    @Binding var item: LessonModel
    @Binding var lesson: ListModel
    @Binding var activeLetter: Int
    
    var body: some View {
        
        if (item.vowel1) {
            
            var vowelText: String {
                
                var vowelText = "ا"
                
                if (lesson.Number == 15) {
                    vowelText = "ٓ "
                }
                if (lesson.Number == 16 && (item.id == 2)) {
                    vowelText = "آ"
                }
                if (lesson.Number == 16 && (item.id == 5 || item.id == 6)) {
                    vowelText = "و"
                }
                
                return vowelText
            }
            
            var vowelSize: CGFloat {
                
                var vowelSize = 70.0
                if (lesson.Number == 9) {
                    vowelSize = 80
                }
                if (lesson.Number >= 12) {
                    vowelSize = 50
                }
                
                return vowelSize
            }
            
            var vowelColor: Color {
                
                var vowelColor = Color(hex: letterColor(id: 1))
                if (lesson.Number == 15) {
                    vowelColor = Color(hex: letterColor(id: 3))
                }
                if (lesson.Number == 16 && (item.id == 2 || item.id == 5 || item.id == 6)) {
                    vowelColor = Color(hex: letterColor(id: 3))
                }
                if (activeLetter == item.id) {
                    vowelColor = Color.white
                }
                
                return vowelColor
            }
            
            Text(vowelText)
            
                .font(.custom("ScheherazadeNew-Medium", size: vowelSize))
                .foregroundColor(vowelColor)
                .padding(.top, 0)
                .padding(.leading, 0)
                .offset(x: CGFloat(item.vowel1Left))
                .offset(y: CGFloat(item.vowel1Top) - 45)
        }
        
        if (item.vowel2) {
            
            var vowelText: String {
                
                var vowelText = "ى"
                if (lesson.Number == 12 && item.id == 9) {
                    vowelText = "ا"
                }
                if (lesson.Number == 13 && (item.id == 8 || item.id == 9)) {
                    vowelText = "آ"
                }
                if (lesson.Number == 15) {
                    vowelText = "ٓ "
                }
                if (lesson.Number == 16 && (item.id == 5 || item.id == 6 || item.id == 7)) {
                    vowelText = "ً"
                }
                
                return vowelText
            }
            
            var vowelSize: CGFloat {
                
                var vowelSize = 80.0
                if (lesson.Number >= 6 && (item.id == 29 || item.id == 30)) {
                    vowelSize = 40
                }
                if (lesson.Number == 9) {
                    vowelSize = 60
                }
                if (lesson.Number >= 12) {
                    vowelSize = 60
                }
                if (lesson.Number == 15) {
                    vowelSize = 100
                }
                
                return vowelSize
            }
            
            var vowelColor: Color {
                
                var vowelColor = Color(hex: letterColor(id: 1))
                if (lesson.Number == 15) {
                    vowelColor = Color(hex: letterColor(id: 3))
                }
                if (lesson.Number == 16 && (item.id == 5 || item.id == 6 || item.id == 7)) {
                    vowelColor = Color(hex: letterColor(id: 3))
                }
                if (activeLetter == item.id) {
                    vowelColor = Color.white
                }
                
                return vowelColor
            }
            
            Text(vowelText)
                .font(.custom("ScheherazadeNew-Medium", size: vowelSize))
                .foregroundColor(vowelColor)
                .padding(.top, 0)
                .padding(.leading, 0)
                .offset(x: CGFloat(item.vowel2Left))
                .offset(y: CGFloat(item.vowel2Top))
        }
        
        if (item.vowel3) {
            
            var vowelText: String {
                
                var vowelText = "و"
                if (lesson.Number == 15) {
                    vowelText = "ٓ "
                }
                
                return vowelText
            }
            
            var vowelSize: CGFloat {
                
                var vowelSize = 50.0
                if (lesson.Number == 9) {
                    vowelSize = 60
                }
                if (lesson.Number >= 12) {
                    vowelSize = 60
                }
                if (lesson.Number == 15) {
                    vowelSize = 100
                }
                
                return vowelSize
            }
            
            var vowelColor: Color {
                
                var vowelColor = Color(hex: letterColor(id: 1))
                if (lesson.Number == 15) {
                    vowelColor = Color(hex: letterColor(id: 3))
                }
                if (activeLetter == item.id) {
                    vowelColor = Color.white
                }
                
                return vowelColor
            }
            
            Text(vowelText)
            
                .font(.custom("ScheherazadeNew-Medium", size: vowelSize))
                .foregroundColor(vowelColor)
                .padding(.top, 0)
                .padding(.leading, 0)
                .offset(x: CGFloat(item.vowel3Left))
                .offset(y: CGFloat(item.vowel3Top) - 45)
        }
        
        if (item.vowel4) {
            
            var vowelText: String {
                
                var vowelText = "ٓ "
                if (lesson.Number == 15) {
                    vowelText = "ٓ "
                }
                
                return vowelText
            }
            
            var vowelSize: CGFloat {
                
                var vowelSize = 80.0
                if (lesson.Number == 15) {
                    vowelSize = 100
                }
                
                return vowelSize
            }
            
            var vowelColor: Color {
                
                var vowelColor = Color(hex: letterColor(id: 1))
                if (lesson.Number == 15) {
                    vowelColor = Color(hex: letterColor(id: 3))
                }
                if (activeLetter == item.id) {
                    vowelColor = Color.white
                }
                
                return vowelColor
            }
            
            Text(vowelText)
                .font(.custom("ScheherazadeNew-Medium", size: vowelSize))
                .foregroundColor(vowelColor)
                .padding(.top, 0)
                .padding(.leading, 0)
                .offset(x: CGFloat(item.vowel4Left))
                .offset(y: CGFloat(item.vowel4Top) - 45)
        }
        
        if (item.vowel5) {
            
            var vowelText: String {
                
                var vowelText = "ءَ"
                if (lesson.Number == 15) {
                    vowelText = "ٓ "
                }
                
                return vowelText
            }
            
            var vowelSize: CGFloat {
                
                var vowelSize = 80.0
                if (lesson.Number == 9) {
                    vowelSize = 60
                }
                if (lesson.Number >= 12) {
                    vowelSize = 60
                }
                if (lesson.Number == 15) {
                    vowelSize = 100
                }
                
                return vowelSize
            }
            
            var vowelColor: Color {
                
                var vowelColor = Color(hex: letterColor(id: 1))
                if (lesson.Number == 15) {
                    vowelColor = Color(hex: letterColor(id: 3))
                }
                
                return vowelColor
            }
            
            Text(vowelText)
                .font(.custom("ScheherazadeNew-Medium", size: vowelSize))
                .foregroundColor(vowelColor)
                .padding(.top, 0)
                .padding(.leading, 0)
                .offset(x: CGFloat(item.vowel5Left))
                .offset(y: CGFloat(item.vowel5Top) - 45)
        }
    }
}
