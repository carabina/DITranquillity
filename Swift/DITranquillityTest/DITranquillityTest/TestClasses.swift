//
//  TestClasses.swift
//  DITranquillityTest
//
//  Created by Alexander Ivlev on 21/06/16.
//  Copyright © 2016 Alexander Ivlev. All rights reserved.
//

import DITranquillity

protocol ServiceProtocol {
  func foo()
}

class FooService: ServiceProtocol {
  func foo() {
    print("foo")
  }
}

class BarService: ServiceProtocol {
  func foo() {
    print("bar")
  }
}

protocol LoggerProtocol {
  func log(msg: String)
}

class Logger: LoggerProtocol {
  func log(msg: String) {
    print("log: \(msg)")
  }
}

class Logger2: LoggerProtocol {
  func log(msg: String) {
    print("log2: \(msg)")
  }
}


class Inject {
  private let service: ServiceProtocol
  private let logger: LoggerProtocol
  
  init(service: ServiceProtocol, logger: LoggerProtocol, test: Int) {
    self.service = service
    self.logger = logger
  }
  
  var description: String {
    return "<Inject: \(unsafeAddressOf(self)) service:\(unsafeAddressOf(service as! AnyObject)) logger:\(unsafeAddressOf(logger as! AnyObject)) >"
  }
}

class InjectMany {
  private let loggers: [LoggerProtocol]
  
  init(loggers: [LoggerProtocol]) {
    self.loggers = loggers
  }
}

class Module : DIModuleProtocol {
  init(useBarService: Bool) {
    self.useBarService = useBarService
  }
  
  func load(builder: DIContainerBuilder) {
    builder.register(Int).asSelf().instanceSingle().initializer {_ in 10}
    
    builder.register(ServiceProtocol)
      .asSelf()
      .instancePerDependency()
      .initializer { _ in
        if self.useBarService {
          return BarService()
        }
        return FooService()
    }
    
    try! builder.register(Logger)
      .asType(LoggerProtocol)
      .instanceSingle()
      .asDefault()
      .initializer { _ in Logger() }
    
    try! builder.register(Logger2)
      .asType(LoggerProtocol)
      .instanceSingle()
      //.asDefault()
      .initializer { _ in Logger2() }
    
    builder.register(Inject)
      .asSelf()
      .instancePerDependency()
      .initializer { (scope) in Inject(service: *!scope, logger: *!scope, test: *!scope) }
    
    builder.register(InjectMany)
      .asSelf()
      .instancePerDependency()
      .initializer { (scope) in InjectMany(loggers: **!scope) }
  }
  
  private let useBarService: Bool
}