require 'spec_helper'

describe 'postgresqlrepo' do

  ['Fedora', 'RedHat', 'CentOS', 'Debian', 'Ubuntu'].each do |operatingsystem|

    context "Operating system #{operatingsystem}" do

      case operatingsystem
      when 'Fedora'
        os = 'fedora'
        os_shortname = 'fedora'
      when 'RedHat'
        os = 'redhat'
        os_shortname = 'rhel'
      when 'CentOS'
        os = 'redhat'
        os_shortname = 'rhel'
      when 'Debian'
        codename  = 'wheezy'
      when 'Ubuntu'
        codename  = 'precise'
      end

      let (:facts) do
        {
          :operatingsystem => operatingsystem,
          :lsbdistcodename => codename,
          :lsbdistid       => "#{operatingsystem}"
        }
      end

      let(:params) do
        {
          :version            => '9.3',
          :repo_enable        => true,
          :repo_source_enable => false
        }
      end

      case operatingsystem
      when 'Fedora','RedHat','CentOS'
        it 'setup pgdg93.repo' do
          should contain_yumrepo('pgdg93').with({
            'enabled'  => '1',
            'gpgcheck' => '1',
            'gpgkey'   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG-93',
            'baseurl'  => "http://yum.postgresql.org/9.3/#{os}/#{os_shortname}-$releasever-$basearch"
          })
        end

        it 'setup pgdg93-source.repo' do
          should contain_yumrepo('pgdg93-source').with({
            'enabled'  => '0',
            'gpgcheck' => '1',
            'gpgkey'   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG-93',
            'baseurl'  => "http://yum.postgresql.org/srpms/9.3/#{os}/#{os_shortname}-$releasever-$basearch"
          })
        end
      when 'Debian','Ubuntu'
        it 'setup pgdg93.list' do
          should contain_apt__source('pgdg93').with({
            'location'    => 'http://apt.postgresql.org/pub/repos/apt/',
            'release'     => "#{codename}-pgdg",
            'repos'       => 'main',
            'key_source'  => 'https://www.postgresql.org/media/keys/ACCC4CF8.asc',
            'include_src' => false
          })
        end
      end

    end

  end

end
