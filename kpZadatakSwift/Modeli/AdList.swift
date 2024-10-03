//
//  AdList.swift
//  kpZadatakSwift
//
//  Created by Aleksa Dimitrijevic on 3.10.24..
//

import Foundation


class AdList: JSONSerializable, Equatable {

    //MARK: - Globals
    
    let pages: Int
    let page: Int
    let ads: [Ad]
    
    //MARK: - Init
    
    init(pages: Int, page: Int, ads: [Ad]) {
        self.pages = pages
        self.page = page
        self.ads = ads
    }
    
    //MARK: - JSONSerializable
    
    required init?(_ dictionary: NSDictionary?) {
        guard
              let dictionary = dictionary,
              let pages      = dictionary.value(forKeyPath: "pages") as? Int,
              let page       = dictionary.value(forKeyPath: "page") as? Int,
              let ads        = dictionary.value(forKeyPath: "ads") as? [NSDictionary]
        else {
            return nil
        }
        
        self.pages = pages
        self.page = page
        self.ads = ads.compactMap { Ad($0) }
    }
    
    //MARK: - Equatable
    
    static func == (lhs: AdList, rhs: AdList) -> Bool {
        return lhs.page == rhs.page
    }
    
}

