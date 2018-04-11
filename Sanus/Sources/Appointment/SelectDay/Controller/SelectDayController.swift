//
//  SelectDayCitasController.swift
//  Sanus
//
//  Created by luis on 01/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import UIKit
import JTAppleCalendar

class SelectDayController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var labelMonth: UILabel!
    @IBOutlet weak var Calendar: UICollectionView!
    @IBOutlet weak var listenerNext: UIButton!
    
    private var selected:NSNumber = 0
    let Months = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre" ]
    let DaysOfMonth = [ "Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado", "Domingo" ]
    var DaysInMonths = [31,28,31,30,31,30,31,31,30,31,30,31]
    var currentMonth = String()
    var NumberOfEmptyBox = Int()
    var NextNumberOfEmptyBox = Int()
    var PreviousNumberOfEmptyBox = 0
    var Direction = 0
    var PositionIndex = 0
    var LeapYearContent = 2
    var DayCounter = 0
    var highlightdate = -1
    //var DayWeek =
    public var idDoctor: String = ""
    private let idDay = ParamsNewAppointment()
    
    
    //dias disponibles
    //var DaysOccupied:[String] = [  "27 Abril 2018"  ]
    var DaysOccupied:[String] = []
    //dias ocupados
    //var DaysAvailable:[String] = [ "11 Abril 2018", "12 Abril 2018", "13 Abril 2018" , "16 Abril 2018" , "17 Abril 2018" , "18 Abril 2018" , "19 Abril 2018" , "20 Abril 2018", "23 Abril 2018" , "24 Abril 2018" , "25 Abril 2018" , "26 Abril 2018" ]
    var DaysAvailable:[String] = []
    
    var MonthOccupied:String?
    var YearOccupied:Int?
    var DayOccupied:Int?
    var MonthAvailable:String?
    var YearAvailable:Int?
    var DayAvailable:Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listenerNext.isEnabled = false
        listenerNext.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
        currentMonth = Months[month]
        labelMonth.text = "\(currentMonth) \(year)"
        GetStartDateDayPosition()
        if weekday == 0 {
            weekday = 7
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showData()
    }
    
    func showData(){
        let params = ParamsNewAppointment()
        idDoctor = params.getDoctor()!
    }
    
    func GetStartDateDayPosition(){
        switch Direction {
        case 0:
            NumberOfEmptyBox = weekday
            DayCounter = day
            while DayCounter > 0 {
                NumberOfEmptyBox = NumberOfEmptyBox - 1
                DayCounter = DayCounter - 1
                if NumberOfEmptyBox == 0{
                    NumberOfEmptyBox = 7
                }
            }
            if NumberOfEmptyBox == 7 {
                NumberOfEmptyBox = 0
            }
            PositionIndex = NumberOfEmptyBox
        case 1...:
            NextNumberOfEmptyBox = (PositionIndex + DaysInMonths[month])%7
            PositionIndex = NextNumberOfEmptyBox
        case -1:
            PreviousNumberOfEmptyBox = ( 7 - ( DaysInMonths[month] - PositionIndex )%7 )
            if PreviousNumberOfEmptyBox == 7 {
                PreviousNumberOfEmptyBox = 0
            }
            PositionIndex = PreviousNumberOfEmptyBox
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Direction {
        case 0:
            return DaysInMonths[month] + NumberOfEmptyBox
        case 1...:
            return DaysInMonths[month] + NextNumberOfEmptyBox
        case -1:
            return DaysInMonths[month] + PreviousNumberOfEmptyBox
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Calendar", for: indexPath ) as! CalendarCell
        cell.dateLabel.backgroundColor = UIColor.clear
        cell.dateLabel.textColor = UIColor.black
        cell.dateLabel.layer.cornerRadius = 20
        cell.dateLabel.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.98, alpha:1.00)
        cell.dateLabel.layer.masksToBounds = false
        cell.dateLabel.layer.cornerRadius = 17.5
        cell.dateLabel.clipsToBounds = true
        
        if cell.isHidden {
            cell.isHidden = false
        }
        
        switch Direction {
            case 0:
                cell.dateLabel.text = "\(indexPath.row + 1 - NumberOfEmptyBox )"
            case 1:
                cell.dateLabel.text = "\(indexPath.row + 1 - NextNumberOfEmptyBox )"
            case -1:
                cell.dateLabel.text = "\(indexPath.row + 1 - PreviousNumberOfEmptyBox )"
            default:
                fatalError()
        }
        
        //OCULTAR DIAS DEL MES ANTERIOR
        if Int(cell.dateLabel.text!)! < 1 {
            cell.isHidden = true
        }
        
        //past days
//        if currentMonth <= Months[calendar.component(.month, from: date) - 1] && year <= calendar.component(.year, from: date) && indexPath.row + 1 - NumberOfEmptyBox < day{
//            cell.backgroundColor = UIColor.red
//            cell.dateLabel.textColor = UIColor.white
//        }
        
        //weekend
        switch indexPath.row {
            case 5,6,12,13,19,20,26,27,33,34:
                //if Int(cell.dateLabel.text!)! > 0 {
                    cell.dateLabel.textColor = UIColor.lightGray
                    //cell.backgroundColor = UIColor.white
                //}
//            case 1,2,3,4:
//                if Int(cell.dateLabel.text!)! > 0 {
//                    cell.dateLabel.textColor = UIColor.white
//                    cell.backgroundColor = UIColor.yellow
//                }
//            case 14,15,16,17,18:
//                //if Int(cell.dateLabel.text!)! > 0 {
//                    cell.dateLabel.textColor = UIColor.white
//                    cell.backgroundColor = UIColor.purple
//                //}
//            case 21,22,23,24,25:
//                if Int(cell.dateLabel.text!)! > 0 {
//                    cell.dateLabel.textColor = UIColor.white
//                    cell.backgroundColor = UIColor.brown
//                }
            default:
                break
        }
        
        print("")
        print("indexPath.row")
        print(indexPath.row)
        print("")
        
        //current day
        if currentMonth == Months[calendar.component(.month, from: date) - 1] && year == calendar.component(.year, from: date) && indexPath.row + 1 - NumberOfEmptyBox == day{
            cell.dateLabel.backgroundColor = UIColor.gray
            cell.dateLabel.textColor = UIColor.white
        }
        
        
        //day selected
        if highlightdate == indexPath.row {
            cell.dateLabel.backgroundColor = UIColor.init(red: 0/255, green: 142/255, blue: 255/255, alpha: 1)
            cell.dateLabel.textColor = UIColor.white
        }
        
        
        //Days occupied
        if DaysOccupied.count != 0 {
            for i in 0...DaysOccupied.count - 1 {
                let DaysOccupiedArr = DaysOccupied[i].components(separatedBy: " ")
                MonthOccupied = DaysOccupiedArr[1]
                YearOccupied = Int(DaysOccupiedArr[2])!
                DayOccupied = Int(DaysOccupiedArr[0])!

                if MonthOccupied == Months[calendar.component(.month, from: date) - 1] && YearOccupied == calendar.component(.year, from: date) && indexPath.row + 1 - NumberOfEmptyBox == DayOccupied{
                    cell.dateLabel.backgroundColor = UIColor.red
                    cell.dateLabel.textColor = UIColor.white
                }
            }
        }
        
        //Days available
        if DaysAvailable.count != 0 {
            for j in 0...DaysAvailable.count - 1 {
                let DaysAvailableArr = DaysAvailable[j].components(separatedBy: " ")
                MonthAvailable = DaysAvailableArr[1]
                YearAvailable = Int(DaysAvailableArr[2])!
                DayAvailable = Int(DaysAvailableArr[0])!

                if MonthAvailable == Months[calendar.component(.month, from: date) - 1] && YearAvailable == calendar.component(.year, from: date) && indexPath.row + 1 - NumberOfEmptyBox == DayAvailable{
                    cell.dateLabel.backgroundColor = UIColor.init(red: 0/255, green: 174/255, blue: 38/255, alpha: 1.0)
                    cell.dateLabel.textColor = UIColor.white
                }
            }
        }
        
        
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        listenerNext.backgroundColor = UIColor(red: 3/255, green: 149/255, blue: 234/255, alpha: 1.0)
        listenerNext.isEnabled = true
        let dateString:String = "\(indexPath.row - PositionIndex + 1) \(currentMonth) \(year)"
        highlightdate = indexPath.row
        let params = ParamsNewAppointment()
        params.setCalendar( date: dateString )
        params.setDay( date: indexPath.row )
        collectionView.reloadData()
        
       
        //print( DaysOfMonth[LeapYearContent] )
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        listenerNext.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
        listenerNext.isEnabled = false
    }
    
    
 
    @IBAction func nextSwipe(_ sender: UISwipeGestureRecognizer) {
        highlightdate = -1
        switch currentMonth {
        case "Diciembre":
            month = 0
            year += 1
            Direction = 1
            if LeapYearContent < 5 {
                LeapYearContent += 1
            }
            if LeapYearContent == 4 {
                DaysInMonths[1] = 29
            }
            if LeapYearContent == 5 {
                LeapYearContent = 1
                DaysInMonths[1] = 28
            }
            GetStartDateDayPosition()
            currentMonth = Months[month]
            labelMonth.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
        default:
            Direction = 1
            GetStartDateDayPosition()
            month += 1
            currentMonth = Months[month]
            labelMonth.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
        }
    }
    
   
    @IBAction func previewSwipe(_ sender: UISwipeGestureRecognizer) {
        highlightdate = -1
        switch currentMonth {
        case "Enero":
            month = 11
            year -= 1
            Direction = -1
            if LeapYearContent > 0 {
                LeapYearContent -= 1
            }
            if LeapYearContent == 0 {
                DaysInMonths[1] = 29
                LeapYearContent = 4
            } else {
                DaysInMonths[1] = 28
            }
            GetStartDateDayPosition()
            currentMonth = Months[month]
            labelMonth.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
        default:
            month -= 1
            Direction = -1
            GetStartDateDayPosition()
            currentMonth = Months[month]
            labelMonth.text = "\(currentMonth) \(year)"
            Calendar.reloadData()
        }
    }
    
   
    @IBAction func btnPreview(_ sender: UIButton) {
        let preview = parent as? PaginacionCitasController
        preview?.previewView(index: 2)
    }
    
    @IBAction func btnNext(_ sender: UIButton) {
        let next = parent as? PaginacionCitasController
        next?.nextView(index: 2)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }

}
