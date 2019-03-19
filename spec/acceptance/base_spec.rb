require 'spec_helper_acceptance'
require_relative './version.rb'

describe 'csit class' do

  context 'basic setup' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOF

      csit::pkg { 'csitdemo':
        content => file('csit/demo/csitdemo-3.14.15_926_53_59-1.noarch.rpm'),
      }

      EOF

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end

    describe package('csitdemo') do
      it { is_expected.to be_installed }
    end

    it 'should work with no errors' do
      pp = <<-EOF

      csit::pkg { 'csitdemo':
      ensure => 'absent',
        content => file('csit/demo/csitdemo-3.14.15_926_53_59-1.noarch.rpm'),
      }

      EOF

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end

    it "csit cleanup" do
      expect(shell("rm -f /usr/local/src/*").exit_code).to be_zero
    end

    it 'should work with no errors' do
      pp = <<-EOF

      csit::pkg { 'csitdemo':
        content => file('csit/demo/csitdemo-3.14.15_926_53_59-1.noarch.rpm'),
      }

      csit::preinstallscript { 'csitdemo':
        content => file('csit/demo/preinstalldemo.sh'),
      }

      EOF

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end

    describe package('csitdemo') do
      it { is_expected.to be_installed }
    end

    describe file('/usr/local/src/preinstall-csitdemo.installed') do
      it { should be_file }
    end

  end
end
