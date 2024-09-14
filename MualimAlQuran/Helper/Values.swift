import SwiftUI

func mainLayoutPadding(items: [ListModel]) -> CGFloat {
    
    if (UIScreen.main.bounds.size.width > 900) {
        
        return (UIScreen.main.bounds.size.width - 900) / 2
    }
    else {
        
        return listItemSpacing(items: items)
    }
}

func listItemSpacing(items: [ListModel]) -> CGFloat {
                    
    if (UIScreen.main.bounds.size.width > 600) {
        
        return 15
    }
    else {
        
        if (!items.isEmpty) {
            
            if (items[0].isTab) {
                
                return 5
            }
        }
        
        return 0
    }
}

func lessonLayoutPadding() -> CGFloat {
    
    if (UIScreen.main.bounds.size.width > 900) {
        
        return (UIScreen.main.bounds.size.width - 900) / 2
    }
    else {
        
        return 10
    }
}

func lessonLetterSize(item: LessonModel, lesson: ListModel) -> CGFloat {
    
    var fontSize = 125.0
    
    if (lesson.Number == 2) {
        fontSize = 110
    }
    
    if (lesson.Number == 3) {
        
        if (item.Letter.count > 2) {
            fontSize = 85
        }
        else if (item.Letter.count > 1) {
            fontSize = 110
        }
        
        if (item.id == 17 || item.id == 18) {
            fontSize = 70
        }
        
        if (62...64).contains(item.id) {
            fontSize = 80
        }
        
        if (65...67).contains(item.id) {
            fontSize = 70
        }
        
        if (item.id == 75) {
            fontSize = 70
        }
        
        if (98...99).contains(item.id) {
            fontSize = 70
        }
        
        if (item.id == 127) {
            fontSize = 70
        }
    }
    else if (lesson.Number == 4) {
        fontSize = 110
    }
    else if (lesson.Number == 5) {
        fontSize = 65
        
        if (item.id == 13) {
            fontSize = 60
        }
        if (item.id == 21) {
            fontSize = 60
        }
        if (item.id == 40) {
            fontSize = 60
        }
    }
    else if (lesson.Number == 6) {
        
        fontSize = 110
    }
    else if (lesson.Number == 8) {
        fontSize = 90
    }
    else if (lesson.Number >= 9) {
        fontSize = 90
    }
    
    if (lesson.Number >= 11) {
        fontSize = 60
    }
    
    if (lesson.Number == 15) {
        fontSize = 80
    }
    
    if (lesson.Number == 17) {
        fontSize = 110
    }
    
    return fontSize
}

func mainListAdaptive() -> CGFloat {

    return 300
}

func lessonListAdaptive(lesson: ListModel, screenWidth: CGFloat) -> CGFloat {

    if (lesson.Number == 7 || lesson.Number == 9 || lesson.Number == 11 || lesson.Number == 12 || lesson.Number == 13 || lesson.Number == 15 || lesson.Number == 16) {
        return 300
    }
    else if (lesson.Number == 2 || lesson.Number == 4 || lesson.Number == 17) {
                
        if (screenWidth < 600) {
            
            return (screenWidth / 2) - 10
        }
        else if (screenWidth < 900) {
            
            return (screenWidth / 4) - 10
        }
        else {
            
            return 900 / 4
        }
    }
    else {
        return 150
    }
}

func lessonListSpacedBy(lesson: ListModel) -> CGFloat {

    if (lesson.Number == 2 || lesson.Number == 4 || lesson.Number == 17) {
        return 0
    }
    else {
        return 10
    }
}

func lessonItemPaddingBottom(lesson: ListModel) -> CGFloat {

    if (lesson.Number == 2 || lesson.Number == 4 || lesson.Number == 17) {

        return 0
    }
    else {

        return 10
    }
}
