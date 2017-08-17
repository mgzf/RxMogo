//
//  RxMogo+MGProgressRefresher.swift
//  RxMogo
//
//  Created by Harly on 2017/8/17.
//  Copyright © 2017年 Harly. All rights reserved.
//

import UIKit
import MGProgressHUD
import RxCocoa
import RxSwift

//MARK : - Refresh Subject for MGProgress
extension PublishSubject
{
    /// loading convertation
    ///
    /// - Parameters:
    ///   - observableDataSource: Response DataSource
    ///   - startAnimation: Start
    ///   - endAnimation: End
    /// - Returns: Response
    func asLoadingAnimated<DataSouce>(
        mapTo observableDataSource : Observable<DataSouce>,
        onView  view : UIView)
        -> Observable<DataSouce>
    {
        return asLoadingAnimated(mapTo: observableDataSource, startWithAnimation: {
            
            MGProgressHUD.showProgressLoadingView(view, message: nil)
            
        }) { 
            MGProgressHUD.hiddenAllhubToView(view, animated: true)
        }
    }
}
