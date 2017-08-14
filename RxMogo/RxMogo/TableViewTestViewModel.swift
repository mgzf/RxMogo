//
//  TableViewTestViewModel.swift
//  RxMogo
//
//  Created by Harly on 2017/8/7.
//  Copyright © 2017年 Harly. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class TableViewTestViewModel
{
    let disposeBag = DisposeBag()
    
    let service = MockService()
    
    let page = Variable<Int>(0)
    
    let nextPage = PublishSubject<Void>()
    
    var serviceDriver : Observable<[Demo]>!
    
    var finalDemos = [Demo]()
    
    init() {
        
    }
    
    func initial()
    {
        serviceDriver = page.asObservable().flatMap{ self.service.provideMock(on: $0).map({ demos -> [Demo] in
            self.finalDemos.append(contentsOf: demos)
            return self.finalDemos
        }) }
        
        nextPage.map { self.page.value + 1 }.bind(to: page).disposed(by: disposeBag)
    }
    
    
}
