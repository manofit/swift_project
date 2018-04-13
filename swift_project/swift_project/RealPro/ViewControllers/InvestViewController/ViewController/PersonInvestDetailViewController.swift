//
//  PersonInvestDetailViewController.swift
//  swift_project
//
//  Created by 高军 on 2018/4/13.
//  Copyright © 2018年 Jun Gao. All rights reserved.
//

import UIKit

class PersonInvestDetailViewController: GJBaseViewController, UITableViewDelegate, UITableViewDataSource{

    var productType = ""
    var uuid = ""
    var isAlreadySwipeInTop = false
    
    var tableView:UITableView?
    var cell:PersonInvestDetailCell?
    var model:PersonInvestDetailModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        isAlreadySwipeInTop = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        createTableView()
        loadData()
    }
    
    func loadData(){
        GJNetWorkTool.tool.getInvestDetailAfterUpSwipeWith(UUID: uuid, TypeID: productType) { (result) in
            self.model?.setValuesForKeys(result.res_data!)
            
            self.tableView?.reloadData()
        }
    }
    
    func createTableView(){
        tableView = UITableView.init(frame: CGRect(x:0, y:0, width:SCREEN_WIDTH, height:SCREEN_HEIGHT - STATUS_NAV_BAR_Y - 40), style: .grouped)
        tableView?.delegate = self
        tableView?.dataSource = self
        self.view.addSubview(tableView!)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = GJUtil.createViewWith(Frame: CGRect(x:0, y:0, width:SCREEN_WIDTH, height:8), BackgroundColor: MAIN_WHITE_COLOR)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 275
        }else if indexPath.section == 1 {
            return 100
        }else if indexPath.section == 2 {
            return 100
        }else if indexPath.section == 3 {
            return (cell?.returnCellHeight())!
        }else{
            return (cell?.returnPicCellHeight())!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: "cellID") as? PersonInvestDetailCell
        cell?.createCellWith(Section: indexPath.section)
        cell?.configCellWith(Model: model!)
        cell?.selectionStyle = .none
        return cell!
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableView?.contentOffset.y == 0 {
            if isAlreadySwipeInTop {
                self.parent?.dismiss(animated: true, completion: nil)
            }
            isAlreadySwipeInTop = true
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let point = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        if point.y < 0 {
            isAlreadySwipeInTop = false
        }
    }
}
