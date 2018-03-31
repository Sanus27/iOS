//
//  Comentarios.swift
//  Sanus
//
//  Created by Luis on 07/02/18.
//  Copyright © 2018 Luis. All rights reserved.
//

import Foundation

class Comments{
    
    //var id: String?
    public var comment: String?
    public var doctor: String?
    public var date: String?
    public var user: String?
    public var avatar: String?
    public var rating: String?
    
    init( comment: String?, doctor: String?, date: String?, user: String?, avatar: String?, rating: String? ) {
        self.comment = comment
        self.doctor = doctor
        self.date = date
        self.user = user
        self.avatar = avatar
        self.rating = rating
    }
    
}
