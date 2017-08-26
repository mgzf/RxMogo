//
//  RxMogo+LoadingErrorProvider.swift
//  RxMogo
//
//  Created by Harly on 2017/8/26.
//  Copyright © 2017年 Harly. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import MGProgressHUD

protocol NeedHandlErrorOnView
{
    
}

extension NeedHandlErrorOnView
{
    func errorViewProvider(on view : UIView) -> PublishSubject<RxMGError>
    {
        let errorSb = PublishSubject<RxMGError>()
        errorSb.subscribe(onNext: { (error) in
            MGProgressHUD.hiddenAllhubToView(view, animated: true)
            MGProgressHUD.showTextAndHiddenView(error.message)
        })
        return errorSb
    }
}
