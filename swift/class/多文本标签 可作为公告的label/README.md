# MultiLabel
多行文本  文本切换动画

        let annLabel = MultiLabel()
        annLabel.frame = CGRectMake(21, 100, 200, 40)
        annLabel.backgroundColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.8)

        annLabel.textArray = ["111111111111","222222","333333333333333"]
        annLabel.textColor = UIColor.blueColor()
        annLabel.highlightedTextColor = UIColor.yellowColor()

        annLabel.timeInterval = 5

        self.view.addSubview(annLabel)

        annLabel.didValueChanged = {
            (text: String, index: Int) -> Void in

            print(text)
            print(index)
            return
        }

        annLabel.onClickHandle = {
            (text: String) -> Void in

            print(text)
            return
        }

        annLabel.textAlignment = .Center
