//
//  DITranquillityTests_Scan.swift
//  DITranquillityTests
//
//  Created by Alexander Ivlev on 14/10/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

import XCTest
import DITranquillity

import SubProject1
import SubProject2


public class ScannedRecursiveBase: DIScanned {}

public class RecursivePart1Type { }
public class ScannedRecursivePart_1: ScannedRecursiveBase, DIPart {
	public static func load(builder: DIContainerBuilder) {
    builder.register(RecursivePart1Type.init)
	}
}

public class RecursivePart2Type { }
public class ScannedRecursivePart_2: ScannedRecursiveBase, DIPart {
	public static func load(builder: DIContainerBuilder) {
		builder.register(RecursivePart2Type.init)
	}
}

private class ScanFramework: DIScanFramework {
  override class var predicate: Predicate? { return .name({ $0.contains("Framework") }) }
}

class FrameworkWithScan1: DIFramework {
  private class ScanFramework: DIScanFramework {
    override class var predicate: Predicate? { return .name({ $0.contains("Framework") }) }
  }
  
  public static func load(builder: DIContainerBuilder) {
    builder.append(framework: ScanFramework.self)
  }
}

class FrameworkWithScan2: DIFramework {
  private class ScanPart: DIScanPart {
    override class var predicate: Predicate? { return .name({ $0.contains("Part") }) }
  }
  
  public static func load(builder: DIContainerBuilder) {
    builder.append(part: ScanPart.self)
  }
}

class FrameworkWithScan3: DIFramework {
  private class ScanPrt: DIScanPart {
    override class var predicate: Predicate? { return .name({ $0.contains("Prt") }) }
  }
  
  public static func load(builder: DIContainerBuilder) {
    builder.append(part: ScanPrt.self)
  }
}

// Tests

class DITranquillityTests_Scan: XCTestCase {
  
  func test01_ScanParts() {
    class ScanPart: DIScanPart {
      override class var predicate: Predicate? { return .name({ $0.contains("Part") }) }
    }
    
    let builder = DIContainerBuilder()
    builder.append(part: ScanPart.self)
    
    let container =  try! builder.build()
    
    let type1: Module1Type? = *container
    let type2: Module2Type? = *container
    
    XCTAssertNotNil(type1)
    XCTAssertNotNil(type2)
  }

  func test02_ScanPrts() {
    class ScanPrt: DIScanPart {
      override class var predicate: Predicate? { return .name({ $0.contains("Prt") }) }
    }
    
    let builder = DIContainerBuilder()
    builder.append(part: ScanPrt.self)
    
    let container =  try! builder.build()
    
    let type1: DuMole1Type? = *container
    let type2: DuMole2Type? = *container
    
    XCTAssertNotNil(type1)
    XCTAssertNotNil(type2)
  }

  func test03_ScanFramework() {
    class ScanFramework: DIScanFramework {
      override class var predicate: Predicate? { return .name({ $0.contains("ScannedFramework") }) }
    }

    let builder = DIContainerBuilder()
    builder.append(framework: ScanFramework.self)
    
    let container =  try! builder.build()
    
    let type1: Module1Type? = *container
    let type2: Module2Type? = *container
    
    let type3: DuMole1Type? = *container
    let type4: DuMole2Type? = *container
    
    XCTAssertNotNil(type1)
    XCTAssertNotNil(type2)
    XCTAssertNotNil(type3)
    XCTAssertNotNil(type4)
  }
  
  func test04_ScanFrameworkUseFramework1() {
    let builder = DIContainerBuilder()
    builder.append(framework: FrameworkWithScan1.self)
    
    let container =  try! builder.build()
    
    let type1: Module1Type? = *container
    let type2: Module2Type? = *container
    
    let type3: DuMole1Type? = *container
    let type4: DuMole2Type? = *container
    
    XCTAssertNotNil(type1)
    XCTAssertNotNil(type2)
    XCTAssertNotNil(type3)
    XCTAssertNotNil(type4)
  }

  func test05_ScanFrameworkUseFramework2() {
    let builder = DIContainerBuilder()
    builder.append(framework: FrameworkWithScan2.self)
    
    let container =  try! builder.build()
    
    let type1: Module1Type? = *container
    let type2: Module2Type? = *container
    
    let type3: DuMole1Type? = *container
    let type4: DuMole2Type? = *container
    
    XCTAssertNotNil(type1)
    XCTAssertNotNil(type2)
    XCTAssertNil(type3)
    XCTAssertNil(type4)
  }
//
//  func test06_ScanAssemblyUseAssembly3() {
//    let builder = DIContainerBuilder()
//    builder.register(module: ModuleWithScan3())
//    
//    let container =  try! builder.build()
//    
//    let type1: Module1Type? = *?container
//    let type2: Module2Type? = *?container
//    
//    let type3: DuMole1Type? = *?container
//    let type4: DuMole2Type? = *?container
//    
//    XCTAssertNil(type1)
//    XCTAssertNil(type2)
//    XCTAssertNotNil(type3)
//    XCTAssertNotNil(type4)
//  }
//	
//	func test07_ScanModulesInBundleSubProject1() {
//		let builder = DIContainerBuilder()
//		builder.register(component: DIScanComponent(predicateByName: { _ in true }, in: Bundle(for: ScannedModule1.self)))
//		
//		let container =  try! builder.build()
//		
//		let type1: Module1Type? = *?container
//		let type2: Module2Type? = *?container
//		
//		let type3: DuMole1Type? = *?container
//		let type4: DuMole2Type? = *?container
//		
//		XCTAssertNotNil(type1)
//		XCTAssertNotNil(type2)
//		XCTAssertNil(type3)
//		XCTAssertNil(type4)
//	}
//	
//	func test07_ScanModulesInBundleSubProject2() {
//		let builder = DIContainerBuilder()
//		builder.register(component: DIScanComponent(predicateByName: { _ in true }, in: Bundle(for: ScannedModule2.self)))
//		
//		let container =  try! builder.build()
//		
//		let type1: Module1Type? = *?container
//		let type2: Module2Type? = *?container
//		
//		let type3: DuMole1Type? = *?container
//		let type4: DuMole2Type? = *?container
//		
//		XCTAssertNil(type1)
//		XCTAssertNil(type2)
//		XCTAssertNotNil(type3)
//		XCTAssertNotNil(type4)
//	}
//
//	func test08_ScanModulesPredicateByType() {
//		let builder = DIContainerBuilder()
//		builder.register(component: DIScanComponent(predicateByType: { type in type.init() is ScannedRecursiveBase }))
//		
//		let container =  try! builder.build()
//		
//		let type1: RecursiveComponent1Type? = *?container
//		let type2: RecursiveComponent2Type? = *?container
//
//		XCTAssertNotNil(type1)
//		XCTAssertNotNil(type2)
//	}
//	
}
