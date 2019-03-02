//
//  Task.swift
//  HotKeywork
//
//  Created by Ms Vi Nguyen Tuong Vi on 3/2/19.
//  Copyright © 2019 Ms Vi Nguyen Tuong Vi. All rights reserved.
//

import Foundation

public typealias ActionOnSuccess<V> = ((V) -> Void)
public typealias ActionOnError<E> = ((E) -> Void)
public typealias ActionOnFinal = (() -> Void)
public typealias ActionOnProgressChange = ((Double) -> Void)
public typealias ActionOnCancel<E> = ((E) -> Void)


public class Task<V> {
    private var result: V?
    private var error: Error?
    
    private var isSuccess: Bool {
        return result != nil
    }
    
    private var isError: Bool {
        return error != nil
    }
    
    internal var isDone: Bool {
        return self.isSuccess || self.isError
    }
    
    private var isCanceling: Bool = false
    
    internal var actionOnSuccess = [ActionOnSuccess<V>]()
    internal var actionOnError = [ActionOnError<Error>]()
    internal var actionOnFinal = [ActionOnFinal]()
    internal var actionOnProgressChange = [ActionOnProgressChange]()
    internal var actionOnCancel = [ActionOnCancel<Error>]()
    
    public init(resolver: @escaping (Task) -> ()) {
        resolver(self)
    }
    
    public init() {
        
    }
    
    @discardableResult
    public func onSuccess(action: @escaping ActionOnSuccess<V>) -> Task<V> {
        guard self.isDone else {
            self.actionOnSuccess.append(action)
            return self
        }
        
        if self.isSuccess {
            action(self.result!)
        }
        
        return self
    }
    
    @discardableResult
    public func onError(action: @escaping ActionOnError<Error>) -> Task<V> {
        guard self.isDone else {
            self.actionOnError.append(action)
            return self
        }
        
        if self.isError {
            action(self.error!)
        }
        
        return self
    }
    
    @discardableResult
    public func onFinally(action: @escaping ActionOnFinal) -> Task<V> {
        guard self.isDone else {
            self.actionOnFinal.append(action)
            return self
        }
        
        action()
        return self
    }
    
    @discardableResult
    internal func onCancel(action: @escaping ActionOnCancel<Error>) -> Task<V> {
        guard !self.isDone else {
            return self
        }
        
        self.actionOnCancel.append(action)
        return self
    }
    
    public func resolve(_ result: V) {
        if !self.isDone {
            self.result = result
            self.actionOnSuccess.forEach { (it) in
                it(self.result!)
            }
            self.markAsDone()
        }
    }
    
    public func reject(_ error: Error) {
        if !self.isDone {
            self.error = error
            self.actionOnError.forEach { (it) in
                it(self.error!)
            }
            self.markAsDone()
        }
    }
    
    private func markAsDone() {
        self.actionOnFinal.forEach { (it) in
            it()
        }
        
        self.actionOnSuccess.removeAll()
        self.actionOnError.removeAll()
        self.actionOnFinal.removeAll()
        self.actionOnProgressChange.removeAll()
        self.actionOnCancel.removeAll()
    }
}

