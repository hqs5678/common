//
//  Certified1ViewController.swift
//  formoney
//
//  Created by 火星人 on 16/4/10.
//  Copyright © 2016年 hqs. All rights reserved.
//

//  输入 选择照片


class SimpleInputViewController: BaseTableViewController {
    
    
    private var selectPicIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(SimpleInputCell.classForCoder(), forCellReuseIdentifier: "SimpleInputCell")
        self.tableView.allowsSelection = false
        self.tableView.separatorStyle = .None
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: SimpleInputCell = tableView.dequeueReusableCellWithIdentifier("SimpleInputCell", forIndexPath: indexPath) as! SimpleInputCell
        
        let tmpArray: NSArray = self.data[indexPath.section] as! NSArray
        let model = tmpArray[indexPath.row] as! SimpleInputModel
        
        if model.inputType == SimpleInputType.Text {
            cell.inputModel = model
            cell.textField.font = cell.textField.font?.fontWithSize(14)
        }
        else{
            cell.setModel(model, indexPath: indexPath)
        }
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let tmpArray: NSArray = self.data[section] as! NSArray
        let model = tmpArray[0] as! SimpleInputModel
        return model.title 
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let tmpArray: NSArray = self.data[indexPath.section] as! NSArray
        
        let model = tmpArray[0] as! SimpleInputModel
        if model.inputType == SimpleInputType.Image {
            // 选择图片上传
            
            
            print("选择图片上传")
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let tmpArray: NSArray = self.data[indexPath.section] as! NSArray
        let model = tmpArray[0] as! SimpleInputModel
        
        if model.inputType == SimpleInputType.Text || model.inputType == SimpleInputType.Switch{
            return 44
        }
        else{
            return 120
        }
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section != self.data.count - 1 {
            return super.tableView(tableView, heightForFooterInSection: section)
        }
        
        return 44
    }
    
    
    func selectImage(button: UIButton) -> Void {
        
        self.selectPicIndex = button.tag
        self.selectPic()
    }
    
    override func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        let tmpArray = data[self.selectPicIndex] as! NSArray
        let model = tmpArray[0] as! SimpleInputModel
        model.image = image
        
        let indexPath = NSIndexPath(forRow: 0, inSection: self.selectPicIndex)
        
        self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }
    
    
    
}
