//
//  ViewController.swift
//  Bemi
//
//  Created by student5 on 2/9/19.
//  Copyright © 2019 Hannah Leland. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // data objects
    
    // enum for fun
    enum UnitSystem {
        case Imperial
        case Metric
    }
    
//    enum Gender {
//        case Male
//        case Female
//    }
    
    var heightUnit = UnitSystem.Metric
    var weightUnit = UnitSystem.Metric
    var height = 0.0
    var weight = 0.0
//    var gender = Gender.Female
    var BMI = 0.0
    
    var measurementSystem = UnitSystem.Imperial
    
    
    
    // ui outlets
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        let gradient = CAGradientLayer(start: .centerLeft, end: .topRight, colors: [UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.5) as! CGColor, UIColor.white.cgColor], type: .axial)
        gradient.frame = heightTextField.bounds
        
        // add the gradient to the ui object
        heightTextField.layer.addSublayer(gradient)
        
    }
    
    
    // switch between imperial and metric unit systems for height and weight separately
    @IBAction func unitSwitched(_ sender: UISegmentedControl) {
        
        if sender.tag == 0 { // height
            if sender.selectedSegmentIndex == 0 { // meter
                // TODO: add ui changes to display separate boxes for feet and inches
                heightUnit = UnitSystem.Metric
                print(heightUnit)
                
            } else { // foot and inch
                heightUnit = UnitSystem.Imperial
                print(heightUnit)
            }
            
        } else { // weight
            if sender.selectedSegmentIndex == 0 { // kilo
                weightUnit = UnitSystem.Metric
                print(weightUnit)
                
            } else { // pound
                weightUnit = UnitSystem.Imperial
                print(weightUnit)
            }
        }
        
    } // end func unitSwitched
    
    
    // tell me how fat i am
    @IBAction func calculatePressed(_ sender: Any) {
        height = Double(heightTextField.text!)!
        weight = Double(weightTextField.text!)!
        let measure = unitsOfMeasure()
        
        // BMI = kg/m^2
        if heightUnit == .Metric {
            if weightUnit == .Metric { // weight is metric
                BMI = weight / (height * height)
            } else { // weight is imperial
                BMI = (weight / (measure.inchesToMeters(inches: height) * measure.inchesToMeters(inches: height)))
            }
        } else { // height is imperial
            if weightUnit == .Imperial { // weight is imperial
                BMI = (measure.poundsToKilos(pounds: weight) / (measure.inchesToMeters(inches: height) * measure.inchesToMeters(inches: height)))
            } else { // weight is metric
                BMI = (weight / (measure.inchesToMeters(inches: height) * measure.inchesToMeters(inches: height)))
            }
        }
        
    } // end calculatePressed
    
    
    
} // end class ViewController

// functions for converting units of measurement
class unitsOfMeasure {
    
    init() {}
    
    func metersToFeet(meters : Double) -> Double {
        return meters / 3.2808399
    }
    
    func feetToMeters(feet : Double) -> Double {
        return feet * 3.2808399
    }
    
    func feetAndInchesToInches(feet : Double, inches : Double) -> Double {
        return ((feet * 12) + inches)
    }
    
    func inchesToFeetAndInches(inches : Double) -> Array<Double> {
        let inchesMinusFeet = inches.truncatingRemainder(dividingBy: 12)
        let feet = (inches - inchesMinusFeet) / 12
        return [feet, inchesMinusFeet]
    }
    
    func inchesToMeters(inches: Double) -> Double {
        return ((inches / 12) * 3.2808399)
    }
    
    func kilosToPounds(kilos : Double) -> Double {
        return kilos * 2.20462262
    }
    
    func poundsToKilos(pounds : Double) -> Double {
        return pounds / 2.20462262
    }
} // end class unitOfMeasure


extension CAGradientLayer {
    
    enum Point {
        case topLeft
        case centerLeft
        case bottomLeft
        case topCenter
        case center
        case bottomCenter
        case topRight
        case centerRight
        case bottomRight
        
        var point: CGPoint {
            switch self {
            case .topLeft:
                return CGPoint(x: 0, y: 0)
            case .centerLeft:
                return CGPoint(x: 0, y: 0.5)
            case .bottomLeft:
                return CGPoint(x: 0, y: 1.0)
            case .topCenter:
                return CGPoint(x: 0.5, y: 0)
            case .center:
                return CGPoint(x: 0.5, y: 0.5)
            case .bottomCenter:
                return CGPoint(x: 0.5, y: 1.0)
            case .topRight:
                return CGPoint(x: 1.0, y: 0.0)
            case .centerRight:
                return CGPoint(x: 1.0, y: 0.5)
            case .bottomRight:
                return CGPoint(x: 1.0, y: 1.0)
            }
        }
    }
    
    convenience init(start: Point, end: Point, colors: [CGColor], type: CAGradientLayerType) {
        self.init()
        self.startPoint = start.point
        self.endPoint = end.point
        self.colors = colors
        self.locations = (0..<colors.count).map(NSNumber.init)
        self.type = type
    }
} // end extension CAGradientLayer



extension UIView {
    func makeVertical() {
        transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
    }
} // end extension UIView
