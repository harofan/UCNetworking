Pod::Spec.new do |s|
    s.name         = 'UCNetworking'
    s.version      = '1.0'
    s.summary      = '一个去model化的AFNetworking的封装'
    s.homepage     = 'https://github.com/RPGLiker/UCNetworking'
    s.license      = 'MIT'
    s.authors      = {'RPGLiker' => 'fanyang_32012@outlook.com'}
    s.platform     = :ios, '9.0'
    s.source       = {:git => 'https://github.com/RPGLiker/UCNetworking.git', :tag => '1.0'}
    s.source_files = 'UCNetworking/**/*.{h,m}'
    # s.resource     = 'MJRefresh/MJRefresh.bundle'
    s.requires_arc = true
end
