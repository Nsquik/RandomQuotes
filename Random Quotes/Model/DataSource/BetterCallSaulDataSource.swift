//
//  BetterCallSaulDataSource.swift
//  Random Quotes
//
//  Created by Kacper Kędzierski on 25/05/2023.
//

import Foundation


struct BetterCallSaulDataSource: BreakingBadDataSourceProtocol {
    let series: Series = Series.betterCallSaul
    let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api")!
    
    public static let shared = BetterCallSaulDataSource()
}
