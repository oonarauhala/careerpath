//
//  MenuItemTests.swift
//  Career PathTests
//
//  Created by iosdev on 09/12/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

//
//  MenuItemTests.swift
//  Career PathTests
//
//  Created by iosdev on 09/12/2019.
//  Copyright © 2019 Team Awesome. All rights reserved.
//

import XCTest
@testable import Career_Path

class MenuItemsTest: XCTestCase {
    
    //MARK: MenuItem Class Tests
    
    // Confirm that the MenuItem initializer returns a MenuItem object when passed valid parameters.
    func testMenuItemsInitializationSucceeds() {
        
        // Empty Menu_item string
        let emptyStringMenu = Item.init(name_item: "", icon: nil)
        XCTAssertNil(emptyStringMenu)
    
    }
    
}

