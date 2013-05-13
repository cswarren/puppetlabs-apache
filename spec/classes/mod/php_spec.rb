describe 'apache::mod::php', :type => :class do
  let :pre_condition do
    'class { "apache": mpm_module => prefork, }'
  end
  context "on a Debian OS with mpm_module => prefork" do
    let :facts do
      {
        :osfamily               => 'Debian',
        :operatingsystemrelease => '6',
        :concat_basedir         => '/dne',
      }
    end
    it { should include_class("apache::params") }
    it { should contain_apache__mod('php5') }
    it { should contain_package("libapache2-mod-php5") }
    it { should contain_file("php5.load").with(
      :content => "LoadModule php5_module /usr/lib/apache2/modules/libphp5.so\n"
    ) }
  end
  context "on a RedHat OS with mpm_module => prefork" do
    let :facts do
      {
        :osfamily               => 'RedHat',
        :operatingsystemrelease => '6',
        :concat_basedir         => '/dne',
      }
    end
    it { should include_class("apache::params") }
    it { should contain_apache__mod('php5') }
    it { should contain_package("php") }
    it { should contain_file("php5.load").with(
      :content => "LoadModule php5_module modules/libphp5.so\n"
    ) }
  end
end
