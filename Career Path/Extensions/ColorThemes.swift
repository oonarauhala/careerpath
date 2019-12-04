//
//  ColorThemes.swift
//  Career Path
//
//  Created by mikael on 04/12/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

enum Themes {
    case t0, t1, t2, t3, t4, t5, t6, t7, t8
}

import UIKit


// Color palette based on home pages background color
// -> Theme 0
extension UIColor {
    class var deepSpaceSparkle: UIColor {
        return UIColor(hex: "#476775ff") ?? UIColor.white
    }
    class var romanSilver: UIColor {
        return UIColor(hex: "#859191ff") ?? UIColor.white
    }
    class var silverChalice: UIColor {
        return UIColor(hex: "#A3ADAEff") ?? UIColor.white
    }
    class var paleTaupe: UIColor {
        return UIColor(hex: "#C99C81ff") ?? UIColor.white
    }
    class var rocketMetallic: UIColor {
        return UIColor(hex: "#8D7B71ff") ?? UIColor.white
    }
}

// -> Theme 1
extension UIColor {
    class var theme1_1: UIColor {
        return UIColor(hex: "#205072ff") ?? UIColor.white
    }
    class var theme1_2: UIColor {
        return UIColor(hex: "#329D9Cff") ?? UIColor.white
    }
    class var theme1_3: UIColor {
        return UIColor(hex: "#56C596ff") ?? UIColor.white
    }
    class var theme1_4: UIColor {
        return UIColor(hex: "#7BE495ff") ?? UIColor.white
    }
    class var theme1_5: UIColor {
        return UIColor(hex: "#cff4d2ff") ?? UIColor.white
    }
}

// -> Theme 2
extension UIColor {
    class var theme2_1: UIColor {
        return UIColor(hex: "#015C92ff") ?? UIColor.white
    }
    class var theme2_2: UIColor {
        return UIColor(hex: "#2D82B5ff") ?? UIColor.white
    }
    class var theme2_3: UIColor {
        return UIColor(hex: "#FB6602ff") ?? UIColor.white
    }
    class var theme2_4: UIColor {
        return UIColor(hex: "#88CDF6ff") ?? UIColor.white
    }
    class var theme2_5: UIColor {
        return UIColor(hex: "#BCE6ffff") ?? UIColor.white
    }
}

// -> Theme 3
extension UIColor {
    class var theme3_1: UIColor {
        return UIColor(hex: "#C73866ff") ?? UIColor.white
    }
    class var theme3_2: UIColor {
        return UIColor(hex: "#FE676Eff") ?? UIColor.white
    }
    class var theme3_3: UIColor {
        return UIColor(hex: "#FD8F52ff") ?? UIColor.white
    }
    class var theme3_4: UIColor {
        return UIColor(hex: "#FFBD71ff") ?? UIColor.white
    }
    class var theme3_5: UIColor {
        return UIColor(hex: "#FFDCA2ff") ?? UIColor.white
    }
}

// -> Theme 4
extension UIColor {
    class var theme4_1: UIColor {
        return UIColor(hex: "#524582ff") ?? UIColor.white
    }
    class var theme4_2: UIColor {
        return UIColor(hex: "#367BC3ff") ?? UIColor.white
    }
    class var theme4_3: UIColor {
        return UIColor(hex: "#38BFA7ff") ?? UIColor.white
    }
    class var theme4_4: UIColor {
        return UIColor(hex: "#8FE1A2ff") ?? UIColor.white
    }
    class var theme4_5: UIColor {
        return UIColor.black
    }
}

// -> Theme 5   Mr. Gee App
// https://color.adobe.com/search?q=education&fbclid=IwAR3Xlg-ItswENt-4_autavLxcrRC6VPZUKGVyufHF3EpY-SDVfslp2QhMlM

extension UIColor {
    class var theme5_1: UIColor {
        return UIColor(hex: "#D90467ff") ?? UIColor.white
    }
    class var theme5_2: UIColor {
        return UIColor(hex: "#3730F2ff") ?? UIColor.white
    }
    class var theme5_3: UIColor {
        return UIColor(hex: "#312BD9ff") ?? UIColor.white
    }
    class var theme5_4: UIColor {
        return UIColor(hex: "#35BDF2ff") ?? UIColor.white
    }
    class var theme5_5: UIColor {
        return UIColor(hex: "#F2A20Cff") ?? UIColor.white
    }
}
// Theme 6
// https://color.adobe.com/search?q=knowledge&fbclid=IwAR2b4OcZdZYlMQsSspfcH3TDLoKLI7ky9Kjr9nJrp6VBAnNzcQ26akV45vQ
extension UIColor {
    class var theme6_1: UIColor {
        return UIColor(hex: "#5D7370ff") ?? UIColor.white
    }
    class var theme6_2: UIColor {
        return UIColor(hex: "#7FA6A1ff") ?? UIColor.white
    }
    class var theme6_3: UIColor {
        return UIColor(hex: "#B8D9B8ff") ?? UIColor.white
    }
    class var theme6_4: UIColor {
        return UIColor(hex: "#D6EDBDff") ?? UIColor.white
    }
    class var theme6_5: UIColor {
        return UIColor(hex: "#FFF5BCff") ?? UIColor.white
    }
}

// Theme 7
//https://color.adobe.com/search?q=career
extension UIColor {
    class var theme7_1: UIColor {
        return UIColor(hex: "#101726ff") ?? UIColor.white
    }
    class var theme7_2: UIColor {
        return UIColor(hex: "#1E2D40ff") ?? UIColor.white
    }
    class var theme7_3: UIColor {
        return UIColor(hex: "#434D59ff") ?? UIColor.white
    }
    class var theme7_4: UIColor {
        return UIColor(hex: "#747F8Cff") ?? UIColor.white
    }
    class var theme7_5: UIColor {
        return UIColor(hex: "#EBF0F2ff") ?? UIColor.white
    }
}

// Theme 8
// https://stock.adobe.com/fi//89225064/
extension UIColor {
    class var theme8_1: UIColor {
        return UIColor(hex: "#011826ff") ?? UIColor.white
    }
    class var theme8_2: UIColor {
        return UIColor(hex: "#88B0BFff") ?? UIColor.white
    }
    class var theme8_3: UIColor {
        return UIColor(hex: "#BFD1D9ff") ?? UIColor.white
    }
    class var theme8_4: UIColor {
        return UIColor(hex: "#025E73ff") ?? UIColor.white
    }
    class var theme8_5: UIColor {
        return UIColor(hex: "#026873ff") ?? UIColor.white
    }
}

extension UIColor {
    
    class func sortingButtons(theme: Themes) -> UIColor{
        switch theme {
        case .t0:
            return UIColor.silverChalice
        case .t1:
            return UIColor.theme1_1
        case .t2:
            return UIColor.theme2_1
        case .t3:
            return UIColor.theme3_1
        case .t4:
            return UIColor.theme4_1
        case .t5:
            return UIColor.theme5_2
        case .t6:
            return UIColor.theme6_1
        case .t7:
            return UIColor.theme7_4
        case .t8:
            return UIColor.theme8_3
        }
    }
    class func sortingButtonsTitle(theme: Themes) -> UIColor{
        switch theme {
        case .t0:
            return UIColor.deepSpaceSparkle
        case .t1:
            return UIColor.theme1_5
        case .t2:
            return UIColor.theme2_5
        case .t3:
            return UIColor.theme3_4
        case .t4:
            return UIColor.theme4_4
        case .t5:
            return UIColor.white
        case .t6:
            return UIColor.theme6_3
        case .t7:
            return UIColor.theme7_5
        case .t8:
            return UIColor.theme8_4
        }
    }
    class func careerListHeaderTitle(theme: Themes) -> UIColor{
        switch theme {
        case .t0:
            return UIColor.white
        case .t1:
            return UIColor.theme1_1
        case .t2:
            return UIColor.theme2_1
        case .t3:
            return UIColor.theme3_1
        case .t4:
            return UIColor.theme4_2
        case .t5:
            return UIColor.black
        case .t6:
            return UIColor.theme6_2
        case .t7:
            return UIColor.theme7_5
        case .t8:
            return UIColor.theme8_3
        }
    }
    class func careerCellNameText(theme: Themes) -> UIColor{
        switch theme {
        case .t0:
            return UIColor.deepSpaceSparkle
        case .t1:
            return UIColor.theme1_5
        case .t2:
            return UIColor.theme2_3
        case .t3:
            return UIColor.theme3_1
        case .t4:
            return UIColor.theme4_1
        case .t5:
            return UIColor.black
        case .t6:
            return UIColor.theme6_1
        case .t7:
            return UIColor.theme7_2
        case .t8:
            return UIColor.theme8_1
        }
    }
    class func careerCellDegreeText(theme: Themes) -> UIColor{
        switch theme {
        case .t0:
            return UIColor.deepSpaceSparkle
        case .t1:
            return UIColor.theme1_5
        case .t2:
            return UIColor.theme2_5
        case .t3:
            return UIColor.theme3_1
        case .t4:
            return UIColor.theme4_4
        case .t5:
            return UIColor.theme5_4
        case .t6:
            return UIColor.theme6_2
        case .t7:
            return UIColor.theme7_3
        case .t8:
            return UIColor.theme8_4
        }
    }
    class func careerCellSalaryText(theme: Themes) -> UIColor{
        switch theme {
        case .t0:
            return UIColor.paleTaupe
        case .t1:
            return UIColor.theme1_4
        case .t2:
            return UIColor.theme2_4
        case .t3:
            return UIColor.theme3_3
        case .t4:
            return UIColor.theme4_4
        case .t5:
            return UIColor.theme5_5
        case .t6:
            return UIColor.theme6_2
        case .t7:
            return UIColor.theme7_3
        case .t8:
            return UIColor.theme8_4
        }
    }
    class func careerCellBackground(theme: Themes) -> UIColor{
        switch theme {
        case .t0:
            return UIColor.white
        case .t1:
            return UIColor.theme1_1
        case .t2:
            return UIColor.theme2_1
        case .t3:
            return UIColor.white
        case .t4:
            return UIColor.theme4_2
        case .t5:
            return UIColor.white
        case .t6:
            return UIColor.white
        case .t7:
            return UIColor.theme7_5
        case .t8:
            return UIColor.theme8_3
        }
    }
    class func careerListView(theme: Themes) -> UIColor {
        switch theme {
        case .t0:
            return UIColor.deepSpaceSparkle
        case .t1:
            return UIColor.theme1_1
        case .t2:
            return UIColor.theme2_1
        case .t3:
            return UIColor.theme3_1
        case .t4:
            return UIColor.theme4_1
        case .t5:
            return UIColor.theme5_2
        case .t6:
            return UIColor.theme6_1
        case .t7:
            return UIColor.theme7_4
        case .t8:
            return UIColor.theme8_1
        }
    }
    class func navigationBar(theme: Themes) -> UIColor {
        switch theme {
        case .t0:
            return UIColor.deepSpaceSparkle
        case .t1:
            return careerListView(theme: theme)
        case .t2:
            return careerListView(theme: theme)
        case .t3:
            return careerListView(theme: theme)
        case .t4:
            return careerListView(theme: theme)
        case .t5:
            return careerListView(theme: theme)
        case .t6:
            return careerListView(theme: theme)
        case .t7:
            return careerListView(theme: theme)
        case .t8:
            return careerListView(theme: theme)
        }
    }
    class func careerListBackground(theme: Themes) -> UIColor {
        switch theme {
        case .t0:
            return UIColor.deepSpaceSparkle
        case .t1:
            return UIColor.white
        case .t2:
            return UIColor.white
        case .t3:
            return UIColor.white
        case .t4:
            return UIColor.white
        case .t5:
            return UIColor.white
        case .t6:
            return UIColor.white
        case .t7:
            return UIColor.theme7_3
        case .t8:
            return UIColor.theme8_4
        }
    }
    class func careerListHeaderBackground(theme: Themes) -> UIColor {
        switch theme {
        case .t0:
            return UIColor.careerListBackground(theme: theme)
        case .t1:
            return UIColor.careerListBackground(theme: theme)
        case .t2:
            return UIColor.careerListBackground(theme: theme)
        case .t3:
            return UIColor.careerListBackground(theme: theme)
        case .t4:
            return UIColor.careerListBackground(theme: theme)
        case .t5:
            return UIColor.careerListBackground(theme: theme)
        case .t6:
            return UIColor.careerListBackground(theme: theme)
        case .t7:
            return UIColor.careerListBackground(theme: theme)
        case .t8:
            return UIColor.careerListBackground(theme: theme)
        }
    }
}

// Color extension for hex rbg to UIColor
// source: https://www.hackingwithswift.com/example-code/uicolor/how-to-convert-a-hex-color-to-a-uicolor

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        return nil
    }
}

extension UIColor {
    class func createRBG(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) -> UIColor {
        let color = UIColor(displayP3Red: r/255, green: g/255, blue: b/255, alpha: a)
        return color
    }
}
