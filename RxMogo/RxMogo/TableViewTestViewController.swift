//
//  TableViewTestViewController.swift
//  RxMogo
//
//  Created by Harly on 2017/8/7.
//  Copyright © 2017年 Harly. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import MJRefresh

class TableViewTestViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = TableViewTestViewModel()
    
    @IBOutlet weak var driverButton: UIButton!

    @IBOutlet weak var functionButton: UIButton!
    
    var tableViewRefresher = PublishSubject<Void>()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.initial()
        
        configRxs()
        // Do any additional setup after loading the view.
    }
}

extension TableViewTestViewController
{
    fileprivate func configRxs()
    {
//        driverButton
//            .rx.tap
//            .flatMap { self.viewModel.serviceDriver }
//            .bind(to: tableView.rx.items(cellIdentifier: "Cell")) {
//                (index, demo: Demo, cell) in
//                cell.textLabel?.text = demo.name
//            }
//            .disposed(by: disposeBag)
        

        tableViewRefresher
            .flatMap { self.viewModel.serviceDriver }
            .do(onNext: { (_) in
                self.tableView.mj_footer.endRefreshing()
                self.tableView.mj_header.endRefreshing()
            }, onError: nil, onCompleted: nil, onSubscribe: nil, onSubscribed: nil, onDispose: nil)
            .bind(to: self.tableView.rx.items(cellIdentifier: "Cell")) {
                (index, demo: Demo, cell) in
                cell.textLabel?.text = demo.name
            }
            .disposed(by: self.disposeBag)
        
        tableView.rx
            .pullUpRefreshing
            .bind(to: self.viewModel.nextPage)
            .disposed(by: disposeBag)
        
        self.viewModel.nextPage
            .bind(to: tableViewRefresher)
            .disposed(by: disposeBag)
        

        tableView.rx.pullDownRefreshing
            .bind(to: tableViewRefresher)
            .disposed(by: self.disposeBag)
        
//            .flatMap { self.viewModel.serviceDriver }
//            .do(onNext: { (_) in
//                self.tableView.mj_header.endRefreshing()
//            }, onError: nil, onCompleted: nil, onSubscribe: nil, onSubscribed: nil, onDispose: nil)
//            .bind(to:
//                self.tableView
//                    .rx
//                    .items(cellIdentifier: "Cell")) {(index, demo: Demo, cell) in
//                        cell.textLabel?.text = demo.name
//            }
//            .disposed(by: self.disposeBag)
        
        //方法调用会与上面的调用冲突，需要注视掉上面的
//        functionButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { (_) in
//            self.loadToReload()
//        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
//        
//        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
//            self.viewModel.serviceDriver
//                .do(onNext: nil, onError: nil, onCompleted: { 
//                    self.tableView.mj_header.endRefreshing()
//                }, onSubscribe: nil, onSubscribed: nil, onDispose: nil)
//                .bind(to: self.tableView.rx.items(cellIdentifier: "Cell")) {
//                    (index, demo: Demo, cell) in
//                    cell.textLabel?.text = demo.name
//                }
//                .disposed(by: self.disposeBag)
//        })
        
//        self.viewModel.nextPage.subscribe(onNext: nil, onError: nil, onCompleted: {
//            self.tableView.mj_footer.endRefreshing()
//        }, onDisposed: nil).disposed(by: disposeBag)
//    
//        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
//            self.viewModel.nextPage.onNext(1)
//    
//        })
        
    }
    
    fileprivate func loadToReload()
    {
        return
//            
//        self.viewModel.serviceDriver
//            .bind(to: tableView.rx.items(cellIdentifier: "Cell")) {
//                (index, demo: Demo, cell) in
//                cell.textLabel?.text = demo.name
//            }
//            .disposed(by: disposeBag)
    }
}
