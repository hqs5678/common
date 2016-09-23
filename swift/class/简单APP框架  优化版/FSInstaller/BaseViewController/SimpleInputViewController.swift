//
//  Certified1ViewController.swift
//  formoney
//
//  Created by 火星人 on 16/4/10.
//  Copyright © 2016年 hqs. All rights reserved.
//

//  输入 选择照片


class SimpleInputViewController: BaseTableViewController {
    
    
    fileprivate var selectPicIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(SimpleInputCell.classForCoder(), forCellReuseIdentifier: "SimpleInputCell")
        self.tableView.allowsSelection = false
        self.tableView.separatorStyle = .none
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SimpleInputCell = tableView.dequeueReusableCell(withIdentifier: "SimpleInputCell", for: indexPath) as! SimpleInputCell
        
        let tmpArray: NSArray = self.data[(indexPath as NSIndexPath).section] as! NSArray
        let model = tmpArray[(indexPath as NSIndexPath).row] as! SimpleInputModel
        
        if model.inputType == SimpleInputType.text {
            cell.inputModel = model
            cell.textField.font = cell.textField.font?.withSize(14)
        }
        else{
            cell.setModel(model, indexPath: indexPath)
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let tmpArray: NSArray = self.data[section] as! NSArray
        let model = tmpArray[0] as! SimpleInputModel
        return model.title 
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tmpArray: NSArray = self.data[(indexPath as NSIndexPath).section] as! NSArray
        
        let model = tmpArray[0] as! SimpleInputModel
        if model.inputType == SimpleInputType.image {
            // 选择图片上传
            
            
            print("选择图片上传")
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tmpArray: NSArray = self.data[(indexPath as NSIndexPath).section] as! NSArray
        let model = tmpArray[0] as! SimpleInputModel
        
        if model.inputType == SimpleInputType.text || model.inputType == SimpleInputType.switch{
            return 44
        }
        else{
            return 120
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section != self.data.count - 1 {
            return super.tableView(tableView, heightForFooterInSection: section)
        }
        
        return 44
    }
    
    
    func selectImage(_ button: UIButton) -> Void {
        
        self.selectPicIndex = button.tag
        self.selectMultiPic()
    }
    
    override func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        let tmpArray = data[self.selectPicIndex] as! NSArray
        let model = tmpArray[0] as! SimpleInputModel
        model.image = image
        
        let indexPath = IndexPath(row: 0, section: self.selectPicIndex)
        
        self.tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    
    
}
