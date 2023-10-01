//
//  Category.swift
//  VideoMemo
//
//  Created by Emi M on 2023/09/29.
//

import Foundation
import RealmSwift

class Category: Object {
    @Persisted var title: String = ""
    @Persisted var colorData: String = ""
}
