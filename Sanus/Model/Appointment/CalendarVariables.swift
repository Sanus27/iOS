//
//  CalendarVariables.swift
//  Sanus
//
//  Created by luis on 14/03/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import Foundation


let date = Date()
let calendar = Calendar.current

var day = calendar.component( .day, from: date )
var weekday = calendar.component( .weekday, from: date ) - 1
var month = calendar.component( .month, from: date ) - 1
var year = calendar.component( .year, from: date )

