//
//  ButtonRefreshController.swift
//  RxMogo
//
//  Created by Harly on 2017/8/16.
//  Copyright © 2017年 Harly. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import MJRefresh

class ButtonRefreshController: UIViewController {
    
    // MARK: - Xib items
    @IBOutlet weak var refreshBtn: UIBarButtonItem!

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private items
    fileprivate let disposeBag = DisposeBag()
    
    fileprivate let dataRefresher = PublishSubject<Void>()
    
    let viewModel = TableViewTestViewModel()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.initial()
        
        configRx()
        
        /// 初始刷新呐
        dataRefresher.onNext(())
        
    }
}

extension ButtonRefreshController : NeedHandlErrorOnView
{
    fileprivate func configRx()
    {
        viewModel
            .errorProvider
            .bind(to: errorViewProvider(on: self.tableView))
            .disposed(by: self.disposeBag)
        
        dataRefresher.asLoadingAnimated(mapTo: viewModel.serviceDriver,
                                        onView: tableView)
            .bind(to: self.tableView.rx.items(cellIdentifier: "Cell")) {
                (index, demo: Demo, cell) in
                cell.textLabel?.text = demo.name
            }
            .disposed(by: self.disposeBag)
        
        
        
        
        refreshBtn.rx.tap
            .bind(to : dataRefresher)
            .disposed(by: disposeBag)
    }
}
