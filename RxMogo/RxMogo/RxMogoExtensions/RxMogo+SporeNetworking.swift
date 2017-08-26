//
//  RxMogo+SporeNetworking.swift
//  RxMogo
//
//  Created by Harly on 2017/8/26.
//  Copyright © 2017年 Harly. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


enum Result<Value> {

    case value(Value)
    case error(Error)
    
    func map<T>(_ transform: (Value) throws -> T) -> Result<T> {
        switch self {
        case .value(let object):
            do {
                let nextObject = try transform(object)
                return Result<T>.value(nextObject)
            } catch {
                return Result<T>.error(error)
            }
        case .error(let error):
            return Result<T>.error(error)
        }
    }
}

struct RxMGError
{
    var key : String?
    var message : String?
}

protocol MGRxRequestable : class
{
    
}

extension MGRxRequestable
{
    func cleanRequest<T>(requestSignal : Observable<Result<T>>) -> Observable<T>
    {
        return requestSignal.filter({ (result) -> Bool in
            switch result
            {
            case .value :
                 return true
            case .error :
                return false
            }
        }).map { (result) -> T? in
            switch result
            {
            case .value (let obj):
                return obj
                
            default:
                return nil
            }
        }.map { $0! }
    }
}

extension MGRxRequestable where Self : NeedHandleRequestError
{
    func filterError<T>(requestSignal : Observable<Result<T>> ,
                     withFlag key : String? = nil) -> Observable<T>
    {
        let filteredResult = requestSignal.do(onNext: {[weak self]result in
            
            guard let strongSelf = self else { return }
            
            switch result {
                
            case .error(let error):
                
                strongSelf.errorProvider.onNext(RxMGError(key: key, message: error.localizedDescription))

            default:
                break
            }
        })
        
        return cleanRequest(requestSignal: filteredResult)
    }
}

protocol NeedHandleRequestError
{
    var errorProvider : PublishSubject<RxMGError> { get set }
}






