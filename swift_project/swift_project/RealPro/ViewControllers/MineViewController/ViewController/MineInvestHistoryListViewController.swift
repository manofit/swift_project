//
//  MineInvestHistoryListViewController.swift
//  swift_project
//
//  Created by 高军 on 2018/4/16.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import UIKit

enum InvestHostoryType {
    case all
    case investing
    case waite
    case already
}

class MineInvestHistoryListViewController: GJBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var type:InvestHostoryType = .all
    
    var page = 1
    var tableView:UITableView?
    var dataArray = Array<Any>()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createTableView()
        loadDataWith(Page: 1)
    }

    func loadDataWith(Page page:Int){
        if page == 1 {
            dataArray = []
        }
        
        
    }
    
    func createTableView(){
        tableView = UITableView.init(frame: CGRect(x:0, y:0, width:SCREEN_WIDTH, height:SCREEN_HEIGHT - STATUS_NAV_BAR_Y - TABBAR_HEIGHT - 40), style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        self.view.addSubview(tableView!)
        
        let header = GJRefreshHeader()
        header.setRefreshingTarget(self, refreshingAction: #selector(refreshHeader))
        header.lastUpdatedTimeLabel.isHidden = true
        header.stateLabel.isHidden = true
        tableView?.mj_header = header
        
        let footer = GJRefreshFooter()
        footer.setRefreshingTarget(self, refreshingAction: #selector(refreshFooter))
        footer.stateLabel.isHidden = true
        tableView?.mj_footer = footer
        tableView?.mj_footer.isAutomaticallyChangeAlpha = true
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if type == .all || type == .investing {
            return 190
        }else{
            return 230
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid") as! InvestListCell
        cell.createCell()
        if !dataArray.isEmpty {
            
        }
        cell.contentView.backgroundColor = UIColor.white
        cell.selectionStyle = .none
        return cell
    }
    
    @objc func refreshHeader(){
        page = 1
        loadDataWith(Page: page)
        tableView?.mj_header.endRefreshing()
    }
    
    @objc func refreshFooter(){
        page += 1
        loadDataWith(Page: page)
        tableView?.mj_footer.endRefreshing()
    }
}
