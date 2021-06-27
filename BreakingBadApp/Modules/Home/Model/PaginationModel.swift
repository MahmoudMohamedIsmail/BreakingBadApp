//
//  PaginationModel.swift
//  BreakingBadApp
//
//  Created by Mahmoud Ismail on 6/26/21.
//

import Foundation

class Pagination {
    
    var pageNumber = 0
    var numberOfItemPerPage = 20
    var isFeatching = false
    var noMorePages = false
    
    func reset() {
        self.pageNumber = 0
        self.isFeatching = false
        self.noMorePages = false
    }
}
