# RatingView
Usage:
 let ratingV = RatingView()
 ratingV.text = "4.5+"
 ratingV.cornerRadius = 8.0
 ratingV.updateUIElements()
 ratingV.frame = CGRect(x: 30, y: 230.0, width: ratingV.viewWidth, height: 16.0)
 self.view.addSubview(ratingV)
 
 
 or
 
 
 
 let ratingV = RatingView()
 
 ratingV.text = "4.5+"
 
 ratingV.textFont = UIFont(name: Constants.FontNames.ProximaSemiBold, size: Constants.FontSize.Small)!
 
 ratingV.rightImage = #imageLiteral(resourceName: "notification")
 
 ratingV.borderColor = UIColor.red
 
 ratingV.borderWidth = 2.0
 
 ratingV.backgroundColor = Constants.Colors.Teal
 
 ratingV.cornerRadius = 5.0
 
 ratingV.renderChanges()
 
 ratingV.frame = CGRect(x: 30, y: 30.0, width: ratingV.viewSize.width, height: ratingV.viewSize.height)
 
 self.view.addSubview(ratingV)
