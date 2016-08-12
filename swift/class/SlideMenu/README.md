# 简单弹出单选框

let menus = NSMutableArray()
menus.addObject("全部")
menus.addObject("未完工")
menus.addObject("待验收")
menus.addObject("已完成")

if menuView == nil {
menuView = QSSlideMenuView()
menuView.frame = self.view.frame
menuView.contentViewFrame = CGRectMake(0, 0, 200, CGFloat(50 * menus.count))
menuView.menuItems = menus
menuView.didSelectMenuItem = {
(index: Int) -> Void in
print(index)

Helper.doInMainThreadAfter(0.2, task: {
self.menuView.dismiss()
})

return
}

}


menuView.show()

