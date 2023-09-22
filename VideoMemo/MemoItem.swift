//
//  MemoItem.swift
//  VideoMemo
//
//  Created by Emi M on 2023/09/17.
//

import Foundation
import RealmSwift

class MemoItem: Object {
    @Persisted var memo: String = ""
    @Persisted var imageURL: String = ""
    @Persisted var time: String = ""
}
