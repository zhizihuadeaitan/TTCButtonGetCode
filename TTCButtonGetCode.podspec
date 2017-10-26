
Pod::Spec.new do |s|
  s.name         = 'TTCButtonGetCode'
  s.version      = '1.0.0'
  s.license          = 'MIT'
  s.homepage     = 'https://github.com/zhizihuadeaitan/TTCButtonGetCode'
  s.author             = { 'Cindy' => '493761458@qq.com' }
  s.summary      = '倒计时按钮，比如发送验证码'
  s.source       = { :git => 'https://github.com/zhizihuadeaitan/TTCButtonGetCode.git', :tag => '1.0.0' }
  s.source_files  = 'TTCButtonGetCode', 'TTCButtonGetCode/**/*.{h,m}'
  s.requires_arc = true
  s.platform     = :ios, '9.0'

end

