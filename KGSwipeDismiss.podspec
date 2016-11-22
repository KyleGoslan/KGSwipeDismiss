Pod::Spec.new do |s|

  s.name             = "KGSwipeDismiss"
  s.version          = "0.0.1"
  s.summary          = "A popup view controller that you can swipe to dismiss."
  s.description      = "Close in functionality to viewing a photo in Facebook new feed."

  s.homepage         = "https://github.com/KyleGoslan/KGSwipeDismiss"
  s.license          = 'MIT'
  s.author           = { "KyleGoslan" => "kylegoslan@me.com" }
  s.source           = { :git => "https://github.com/KyleGoslan/KGSwipeDismiss.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/KyleGoslan'
  s.platform         = :ios, '10.0'
  s.requires_arc     = true
  s.source_files     = 'KGSwipeDismiss'
  
end
