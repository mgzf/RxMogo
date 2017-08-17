//
//  ViewModel.swift
//  RxMogo
//
//  Created by Harly on 2017/7/28.
//  Copyright © 2017年 Harly. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class ViewModel
{
    let disposeBag = DisposeBag()
    
    
    //Button Action
    let confirmAction = PublishSubject<Void>()
    
    //Label Display
    let displayBindableNum = Variable<Int>(2)
    
    //TextField Binding
    let searchText = Variable<String?>("")
    
    init() {
        confirmAction.subscribe(onNext: { (event) in
            print("button tapped")
            
            self.displayBindableNum.value = self.displayBindableNum.value + 1
            
            self.searchText.value = "reset"
            
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
        
        searchText.asObservable().subscribe(onNext: { (string) in
//            print(string)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
    
}
