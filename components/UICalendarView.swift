//
//  File.swift
//  
//
//  Created by Daniel Ramzani on 13/05/2024.
//

import UIKit

extension UICalendarView {
    func reloadDecorationsForVisibleMonth(animated: Bool) {
        guard let visibleMonth = calendar.date(from: visibleDateComponents) else {
            return
        }
        
        var daysToReload = [DateComponents]()
        
        for day in calendar.range(of: .day, in: .month, for: visibleMonth)! {
            var components = visibleDateComponents
            components.day = day
            daysToReload.append(components)
        }
        
        reloadDecorations(forDateComponents: daysToReload, animated: animated)
    }
}
