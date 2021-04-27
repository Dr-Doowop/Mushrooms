//
//  MeineViewController.swift
//  Mushrooms
//
//  Created by Rene Walliczek on 09.04.21.
//  Copyright © 2021 Rene Walliczek. All rights reserved.
//

import UIKit
import CoreLocation
import MobileCoreServices

enum MyType: Int {
    case Label = 1
    case TextField = 2
    case TextView = 3
    case ImageView = 4
    case Button = 5
}

class MeineViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    @IBOutlet weak var svMeinePilze: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    
     var pilzView: UIView!
     var pilzScrollView: UIScrollView!
     var txtName: UITextField!
     var pilzImageView: UIImageView!
     var tvDescription: UITextView!
     var btnBeenden: UIButton!
     var txtDate: UITextField!
     var txtLatitude: UITextField!
     var txtLongitude: UITextField!
     var dictMeinePilze: NSMutableDictionary = NSMutableDictionary()
     var datePickerView = UIDatePicker()
    
     func createPilzDataView(_ nummer: Int) -> UIView {
         pilzView = UIView(frame: self.view.frame)
         pilzScrollView = UIScrollView(frame: self.view.frame)
         pilzScrollView.tag = nummer
         pilzView.addSubview(pilzScrollView)
         pilzView.backgroundColor = UIColor(#colorLiteral(red: 0.2232393622, green: 0.2619241476, blue: 0, alpha: 1))
         // Variablen zur Positionierung
         var leftRectangle: CGRect = pilzScrollView.frame
         var rightRectangle: CGRect = pilzScrollView.frame
         let distanceVertical: CGFloat = 100.0
         let distanceHorizontal: CGFloat = 30.0
         let elementHeight: CGFloat = 30.0
         let leftTag: Int = 100
         pilzScrollView.frame.origin.y += distanceVertical + elementHeight
         // BackButton
         let backButton = UIButton(type: .custom)
         //backButton.frame.size.height = elementHeight
         backButton.setTitle("Fertig", for: .normal)
         backButton.backgroundColor = UIColor(#colorLiteral(red: 0.7924067378, green: 0.8124600053, blue: 0, alpha: 1))
         backButton.setTitleColor(.black, for: .normal)
         backButton.addTarget(self, action: #selector(MeineViewController.removePilzDataView), for: .touchDown)
         leftRectangle.origin.x += distanceHorizontal
         leftRectangle.origin.y += distanceVertical
         leftRectangle.size.width -= distanceHorizontal * 2.0
         leftRectangle.size.height = elementHeight
         backButton.frame = leftRectangle
         backButton.layer.cornerRadius = 12.0
         pilzView.addSubview(backButton)
         // Ein Label erstellen
         let lblName: UILabel = createObject(typ: .Label, text: "Name:", frame: leftRectangle, tag: leftTag) as! UILabel
         pilzScrollView.addSubview(lblName)
         // Ein Eingabefeld erstellen
         rightRectangle = leftRectangle
         txtName = createObject(typ: .TextField, text: "Name", frame: rightRectangle, tag: 1) as? UITextField
         pilzScrollView.addSubview(txtName)
         // Das Label Foto erstellen
         let lblFoto: UILabel = createObject(typ: .Label, text: "Foto:", frame: leftRectangle, tag: leftTag) as! UILabel
         pilzScrollView.addSubview(lblFoto)
         // Eine ImageView erstellen
         pilzImageView = createObject(typ: .ImageView, text: "Name", frame: rightRectangle, tag: 2, nummer: nummer) as? UIImageView
         pilzScrollView.addSubview(pilzImageView)
         // Das Label Beschreibung erstellen
         let lblDescription = createObject(typ: .Label, text: "Beschreibung:", frame: leftRectangle, tag: leftTag) as! UILabel
         pilzScrollView.addSubview(lblDescription)
         // Den Button Beenden erstellen
         btnBeenden = createObject(typ: .Button, text: "Beenden", frame: leftRectangle, tag: 101) as? UIButton
         btnBeenden.backgroundColor = UIColor(#colorLiteral(red: 0.7924067378, green: 0.8124600053, blue: 0, alpha: 1))
         btnBeenden.isHidden = true
         btnBeenden.layer.cornerRadius = 12.0
         btnBeenden.addTarget(self, action: #selector(MeineViewController.btnBeendenDown), for: .touchDown)
         pilzScrollView.addSubview(btnBeenden)
         // Die TextView für die Beschreibung erstellen
         tvDescription = createObject(typ: .TextView, text: "Mein absoluter Lieblingspilz!", frame: rightRectangle, tag: 3) as? UITextView
         pilzScrollView.addSubview(tvDescription)
         // Das Label Datum erstellen
         let lblDatum: UILabel = createObject(typ: .Label, text: "Datum:", frame: leftRectangle, tag: leftTag) as! UILabel
         pilzScrollView.addSubview(lblDatum)
         // Das Eingabefeld für das Datum erstellen
         txtDate = createObject(typ: .TextField, text: "10.10.2018", frame: rightRectangle, tag: 4) as? UITextField
        datePickerView.datePickerMode = .date
        datePickerView.preferredDatePickerStyle = .wheels
        datePickerView.backgroundColor = UIColor(#colorLiteral(red: 0.913490653, green: 0.8691215515, blue: 0.7960733771, alpha: 1))
        txtDate.inputView = datePickerView
        // Target zum DatePicker hinzufügen
        datePickerView.addTarget(self, action: #selector(handleDatePicker(_:)), for: .valueChanged)
         pilzScrollView.addSubview(txtDate)
         // Das Label Fundort erstellen
         let lblLocality: UILabel = createObject(typ: .Label, text: "Fundort:", frame: leftRectangle, tag: leftTag) as! UILabel
         pilzScrollView.addSubview(lblLocality)
         // Das Label Breitengrad erstellen
         let lblLatitude: UILabel = createObject(typ: .Label, text: "Breitengrad:", frame: leftRectangle, tag: leftTag) as! UILabel
         pilzScrollView.addSubview(lblLatitude)
         // Das Eingabefeld für den Breitengrad erstellen
         txtLatitude = createObject(typ: .TextField, text: "52.4257049", frame: rightRectangle, tag: 5) as? UITextField
         pilzScrollView.addSubview(txtLatitude)
         // Das Label Längengrad erstellen
         let lblLongitude: UILabel = createObject(typ: .Label, text: "Längengrad:", frame: leftRectangle, tag: leftTag) as! UILabel
         pilzScrollView.addSubview(lblLongitude)
         // Das Eingabefeld für den Längengrad erstellen
         txtLongitude = createObject(typ: .TextField, text: "12.8827227", frame: rightRectangle, tag: 6) as? UITextField
         pilzScrollView.addSubview(txtLongitude)

         return pilzView
     }
    
    // MARK: - Datepicker
    
    @objc func handleDatePicker(_ uiDatePickerView: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM yyyy"
        dateFormatter.locale = Locale(identifier: "de_DE")
        let dateAsString = dateFormatter.string(from: uiDatePickerView.date)
        
        if dateAsString.isEmpty {
            return
        }else {
              txtDate.text = dateAsString
        }
    }
     
     func createObject(typ: MyType, text: String, frame: CGRect, tag: Int, nummer: Int = 0) -> (Any){
         var myObj: Any!
         switch typ {
         case .Label:
             let myLabel = UILabel(frame: frame)
             myLabel.textColor = UIColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
             myLabel.text = text
             myLabel.tag = tag
             myObj = myLabel
         case .TextField:
             let myTextField = UITextField(frame: frame)
             //myTextField.text = text
             myTextField.backgroundColor = UIColor(#colorLiteral(red: 0.913490653, green: 0.8691215515, blue: 0.7960733771, alpha: 1))
             myTextField.layer.cornerRadius = 8.0
             myTextField.layer.borderWidth = 1
             myTextField.layer.borderColor = UIColor.yellow.cgColor
             myTextField.tag = tag
             myTextField.text = dictLesen(forTag: tag)
             myTextField.delegate = self
             myObj = myTextField
         case .TextView:
             let myTextView = UITextView(frame: frame)
             //myTextView.text = text
             myTextView.backgroundColor = UIColor(#colorLiteral(red: 0.913490653, green: 0.8691215515, blue: 0.7960733771, alpha: 1))
             myTextView.delegate = self
             myTextView.layer.cornerRadius = 8.0
             myTextView.layer.borderWidth = 1
             myTextView.layer.borderColor = UIColor.yellow.cgColor
             myTextView.tag = tag
             myTextView.text = dictLesen(forTag: myTextView.tag)
             myObj = myTextView
         case .ImageView:
             let myImageView = UIImageView(frame: frame)
             myImageView.clipsToBounds = true
             myImageView.contentMode = .scaleAspectFill
             myImageView.layer.cornerRadius = 12.0
             myImageView.layer.borderWidth = 1
             myImageView.layer.borderColor = UIColor.yellow.cgColor
           
             let imgName: String = dictLesen(forTag: tag)
             var imgURL: URL! = URL(fileURLWithPath: NSHomeDirectory())
             imgURL.appendPathComponent("Documents")
             imgURL.appendPathComponent(imgName)
             print(imgURL!)
             if (imgURL == nil){
                 myImageView.image = UIImage(named: "Pilz_lieblinge\(nummer).jpg")
                 NSLog("Foto nicht gefunden!")
             }else{
                 let imgData: Data!
                 do{
                     imgData = try Data(contentsOf: imgURL)
                     myImageView.image = UIImage(data: imgData)
                 }catch{
                     NSLog("Nicht geladen\(imgURL.absoluteString)")
                 }
             }
             myImageView.tag = tag
             myObj = myImageView
         case .Button:
             let myButton = UIButton(frame: frame)
             myButton.layer.cornerRadius = 8.0
             myButton.backgroundColor = UIColor(#colorLiteral(red: 0.7924067378, green: 0.8124600053, blue: 0, alpha: 1))
             myButton.setTitle(text, for: .normal)
             myButton.tag = tag
             myObj = myButton
         }
        return myObj!
     }
     
     func layoutObjects(size: CGSize){
         if self.view.subviews.count > 1 {
             let backButton: UIButton = pilzView.subviews.last! as! UIButton
             NSLog("breite: %f und %f", size.width, pilzScrollView.frame.size.width)
             pilzView.frame.size = size
             pilzScrollView.frame.size = size
             var leftRectangle: CGRect = pilzScrollView.frame
             var rightRectangle: CGRect = pilzScrollView.frame
             let distanceVertical: CGFloat = 50.0
             let distanceHorizontal: CGFloat = 30.0
             let elementHeight: CGFloat = 30.0
             backButton.frame.size.width = size.width - distanceHorizontal * 2
             rightRectangle = CGRect(x: 0, y: 0, width: 0, height: 0)
             for subView in pilzScrollView.subviews {
                 if subView.tag == 100 { //linke Seite
                     leftRectangle.size.height = elementHeight
                     leftRectangle.origin.x = distanceHorizontal
                     leftRectangle.origin.y = rightRectangle.origin.y  + rightRectangle.size.height + distanceVertical
                     leftRectangle.size.width = (size.width - distanceHorizontal * 2) / 2.8
                     subView.frame = leftRectangle
                     rightRectangle.origin.y = leftRectangle.origin.y
                 }else{ //rechte Seite
                     if subView == btnBeenden {
                         subView.frame = leftRectangle
                     }else{
                         rightRectangle = subView.frame
                         rightRectangle.size.width = (size.width - distanceHorizontal * 2) / 2.8 * 1.8
                         rightRectangle.origin.y = leftRectangle.origin.y
                         rightRectangle.origin.x = leftRectangle.origin.x + leftRectangle.width
                         if (subView == pilzImageView) || (subView == tvDescription){
                             rightRectangle.size.height = rightRectangle.size.width
                         }
                         subView.frame = rightRectangle
                     }
                 }
             }
             pilzScrollView.contentSize.height = rightRectangle.origin.y + 170
         }
     }
     
     override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
         NSLog("gedreht")
         self.layoutObjects(size: size)
     }
     
     func textFieldDidBeginEditing(_ textField: UITextField) {
         NSLog("Geht los")
         pilzScrollView.contentSize.height *= 2
         pilzScrollView.setContentOffset(CGPoint(x: 0.0, y: textField.frame.origin.y - 20), animated: true)
     }
     
     func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
         pilzScrollView.contentSize.height *= 2
         pilzScrollView.setContentOffset(CGPoint(x: 0.0, y: textView.frame.origin.y - 20), animated: true)
         btnBeenden.isHidden = false
         return true
     }
     
     @IBAction func btnBeendenDown(){
         tvDescription.resignFirstResponder()
         pilzScrollView.contentSize.height = txtLongitude.frame.origin.y + 160
         btnBeenden.isHidden = true
         
         let nummer = pilzScrollView.tag
         let dictMeinPilz = dictMeinePilze.value(forKey: "meine") as! NSDictionary
         let dictPilz = dictMeinPilz.value(forKey: "\(nummer)") as! NSDictionary
         dictPilz.setValue(tvDescription.text, forKey: "\(tvDescription.tag)")
         dictSpeichern()
     }
     
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         textField.resignFirstResponder()
         pilzScrollView.contentSize.height = txtLongitude.frame.origin.y + 160
         let nummer = pilzScrollView.tag
         let dictPilze = dictMeinePilze.value(forKey: "meine") as! NSDictionary
         let dictAktuellerPilz = dictPilze.value(forKey: "\(nummer)" ) as! NSDictionary
         dictAktuellerPilz.setValue(textField.text, forKey: "\(textField.tag)")
         dictSpeichern()
         return false
     }
     
     @IBAction func removePilzDataView(){
         pilzView.removeFromSuperview()
     }
    
    @IBAction func imgLongPress(_ sender: UILongPressGestureRecognizer) { NSLog("Lang gedrückt")
               switch sender.state {
                    case .began:
                        let imageView: UIImageView = sender.view as! UIImageView
                        NSLog("Lang gedrückt %i, %i", imageView.tag, view.subviews.count)
                        let createdView: UIView = createPilzDataView(imageView.tag)
                        self.view.addSubview(createdView)
                        self.layoutObjects(size: self.view.frame.size)
                    default:
                        return
                    }
    }
    
  override func viewDidLoad() {
        super.viewDidLoad()
        svMeinePilze.contentSize.width = 2240.0
        svMeinePilze.contentSize.height = 320.0
        let fileManager = FileManager.default
        var myURL = URL(fileURLWithPath: NSHomeDirectory())
        myURL.appendPathComponent("Documents/MeinePilze.plist")
        do{
            _ = try Data(contentsOf: myURL)
            dictMeinePilze = NSMutableDictionary(contentsOf: myURL)!
        }catch{
            let myOldURL = Bundle.main.url(forResource: "MeinePilze", withExtension: "plist")
            do{
                try fileManager.copyItem(at: myOldURL!, to: myURL)
                NSLog("verschoben nach: \(String(describing: myURL.absoluteString))")
                print(myURL)
            }catch{
                NSLog("Datei existiert schon!")
            }
            dictMeinePilze = NSMutableDictionary(contentsOf: myURL)!
            let dictMeine = dictMeinePilze.value(forKey: "meine") as! NSMutableDictionary
            do{
                for nr in 1...7{
                    let dictPilz = dictMeine.value(forKey: "\(nr)") as! NSDictionary
                    let img = UIImage(named: "Pilz_lieblinge\(nr).png")
                    let data: Data = img!.jpegData(compressionQuality: 1.0)!
                    var newURL = URL(fileURLWithPath: NSHomeDirectory())
                    newURL.appendPathComponent("Documents/Pilz_lieblinge\(nr).jpg")
                    try data.write(to: newURL)
                    dictPilz.setValue("Pilz_lieblinge\(nr).jpg", forKey: "2")
                    dictSpeichern()
                }
            }catch{
                NSLog("Foto nicht gespeichert")
            }
        }
        NSLog("Dict geladen %@", dictMeinePilze)
    }
    
    func dictSpeichern(){
        var dictURL = URL(fileURLWithPath: NSHomeDirectory())
        dictURL.appendPathComponent("Documents/MeinePilze.plist")
        do{
            try dictMeinePilze.write(to: dictURL)
            print(dictURL)
        }catch{
            NSLog("Dictionary nicht gespeichert")
        }
    }
    
    func dictLesen(forTag: Int) -> String{
        var strText = "Keine Daten"
        if dictMeinePilze.count > 0{
            let meineDictionary = dictMeinePilze.value(forKey: "meine") as! NSDictionary
            let nummer = pilzScrollView.tag
            let pilzDictionary = meineDictionary.value(forKey: String("\(nummer)")) as! NSDictionary
            strText = pilzDictionary.value(forKey: String("\(forTag)")) as! String
        }
        return strText
    }
    
    func dictLesen(nummer: Int ,forTag: Int) -> String{
        var strText = "Keine Daten"
        if dictMeinePilze.count > 0 {
            let meineDictionary =
                dictMeinePilze.value(forKey: "meine") as! NSDictionary
            let pilzDictionary =
                meineDictionary.value(forKey: String("\(nummer)")) as! NSDictionary
            strText =
                pilzDictionary.value(forKey: String("\(forTag)")) as! String
        }
        return strText
    }
    
    

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let naviController = segue.destination as! MeinNavigationController
        let mapViewController = naviController.topViewController as! MapViewController
        let pilzContentOffset = Int(svMeinePilze.contentOffset.x)
        var nummer = 1
        for imgView in contentView.subviews{
            if Int(imgView.frame.origin.x) == pilzContentOffset {
                nummer = imgView.tag
                break
            }
        }
        let pilzName = dictLesen(nummer: nummer, forTag: 1)
        let pilzBeschreibung = dictLesen(nummer: nummer, forTag: 3)
        let pilzLatitude = dictLesen(nummer: nummer, forTag: 5)
        let pilzLongitude = dictLesen(nummer: nummer, forTag: 6)
        let pilzLocation = CLLocation(latitude: Double(pilzLatitude) ?? 0.0, longitude: Double(pilzLongitude) ?? 0.0)
        let meineAnnotation = MeinePilzAnnotation(withLocation: pilzLocation.coordinate, title: pilzName , subtitle: pilzBeschreibung)
        mapViewController.pilzAnnotation  = meineAnnotation
    }

}
