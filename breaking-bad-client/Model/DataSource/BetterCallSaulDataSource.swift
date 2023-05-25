//
//  BetterCallSaulDataSource.swift
//  breaking-bad-client
//
//  Created by Kacper Kędzierski on 25/05/2023.
//

import Foundation


struct BetterCallSaulDataSource: BreakingBadDataSourceProtocol {
    var productionName = "Better Call Saul"
    var baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    public static let shared = BetterCallSaulDataSource()
}
