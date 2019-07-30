//
//  ViewController.swift
//  MyTaxiCodingTest
//
//  Created by Amit  Singh on 29/07/19.
//  Copyright © 2019 singhamit089. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class ListViewController: UIViewController,UITableViewDelegate {

    private let disposeBag = DisposeBag()
    private var tableView: UITableView!
    private let viewModel = ListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        bind()
        self.viewModel.loadPageTrigger.onNext(())
    }

    func bind() {
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String,Taxi>>(
            configureCell: { _, _, _, taxi in
                
                guard let cell:TaxiTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: String(describing: TaxiTableViewCell.self)) as? TaxiTableViewCell else {
                    fatalError("Table view cell specified could not be found.")
                }
                cell.configure(taxi: taxi)
                return cell
        }
        )
        
        viewModel.outputs.elements.asDriver()
            .map { [SectionModel(model: String(describing: Taxi.self), items: $0)] }
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.isLoading.asDriver(onErrorJustReturn: false).map({ [weak self] isLoading in
            guard let self = self else {
                return
            }
            
        })
            .drive()
            .disposed(by: disposeBag)
    }
    
    func configureTableView() {
        
        title = "MyTaxi - List"
        
        tableView = UITableView(frame: UIScreen.main.bounds)
        
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        view = tableView
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
        
        definesPresentationContext = true
        
        tableView.register(
            UINib(nibName: String(describing: TaxiTableViewCell.self), bundle: Bundle.main),
            forCellReuseIdentifier: String(describing: TaxiTableViewCell.self)
        )
    }
    
}

