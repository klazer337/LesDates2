//
//  ViewController.swift
//  LesDates2
//
//  Created by Kevin Trebossen on 20/10/2018.
//  Copyright © 2018 KTD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Obtenir une string au format de votre choix
    @IBOutlet weak var dateStringLbl: UILabel!
    
    // Time Interval
    @IBOutlet weak var timeIntervalLbl: UILabel!
    
    // Vérifier si aujourd'hui, demain, hier, week-end,
    @IBOutlet weak var calendarLbl: UILabel!
    
    // Il y a + mois, jours, heures, minutes, ...
    @IBOutlet weak var ilyaLbl: UILabel!
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // Constantes
    let format = "EEEE dd MMMM yy - HH:mm:ss - zzzz"    // Format de la date
    let calendar = Calendar.current         // calendrier actuel

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func dateChoisie(_ sender: UIDatePicker) {
        let date = sender.date
        print(date)
        dateStringLbl.text = date.stringWithFormat(format)      // Date sous forme de String
        timeIntervalLbl.text = date.timeStamp()                 // Temps écoulé
        calendarLbl.text = date.quelJour()
        ilyaLbl.text = date.components()

    }
}

extension Date {
    // Convertir une date en String
    func convertirDate () -> String {
        let dateFormatter = DateFormatter()                     // Création du formatter de date
        dateFormatter.dateStyle = DateFormatter.Style.long      // Format de date
        dateFormatter.timeStyle = .short                       // Format de temps
        dateFormatter.locale = Locale(identifier: "fr_FR")      // Format de la langue
        return dateFormatter.string(from: self)
    }
    
    // Initialisation du format de la date
    func stringWithFormat(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "fr_FR")
        return formatter.string(from: self)
    }
    
    func timeStamp() -> String {
        let tempsEcoule = self.timeIntervalSinceNow
        return String(format: "%.2f", tempsEcoule)
    }
    
    func quelJour() -> String {
        var str = ""
        let cal = Calendar.current
        if cal.isDateInToday(self) {
            str += "Aujourd'hui "
        }
        if cal.isDateInYesterday(self) {
            str += "Hier "
        }
        if cal.isDateInTomorrow(self) {
            str += "Demain "
        }
        if cal.isDateInWeekend(self) {
            str += "Nous sommes le week-end"
        }
        return str
    }
    
    func components() -> String {
        let cal = Calendar.current
        let components = cal.dateComponents([.month, .day, .hour, .minute], from: self, to: Date())
        let month = components.month ?? 0
        let day = components.day ?? 0
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        return "Temps écoulé -> mois : \(month), jour(s) : \(day), heure(s) : \(hour), minute(s) : \(minute)"
    }
    
    
}
