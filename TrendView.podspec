Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '9.0'
s.name = "TrendView"
s.summary = "trendview lets you trend data in a chart"
s.requires_arc = true

# 2
s.version = "0.2.3"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "nick wilkerson" => "nickwilkerson@gmail.com" }


# 5 - Replace this URL with your own Github page's URL (from the address bar)
s.homepage = "https://github.com/nsnick/TrendView"


# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/nsnick/TrendView.git", :tag => "#{s.version}"}



# 7
s.framework = "UIKit"

# 8
s.source_files = "TrendView/*.{h,m,c,cpp}"

# 9
#s.resources = "RWPickFlavor/**/*.{png,jpeg,jpg,storyboard,xib}"
end
