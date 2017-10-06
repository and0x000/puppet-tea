require 'spec_helper'

if Puppet.version.to_f >= 4.5
  describe 'test::rfc1918', type: :class do
    describe 'accepts rfc1918 addresses' do
      [
        '192.168.4.3',
        '192.168.255.255',
        '192.168.0.0',
        '10.0.23.89',
        '172.25.32.167'
      ].each do |value|
        describe value.inspect do
          let(:params) { { value: value } }
          it { is_expected.to compile }
        end
      end
    end
    describe 'rejects other values' do
      [
        '224.0.0.0',
        '255.255.255.255',
        '172.0.2.0',
        '172.32.1.0',
        '0.0.0.0',
        '192.168.256.0',
        '192.88.99.0',
        'nope',
        '77',
        '4.4.4',
        '256.255.255.255',
        '2001:0db8:85a3:0000:0000:8a2e:0370:73342001:0db8:85a3:0000:0000:8a2e:0370:7334'
      ].each do |value|
        describe value.inspect do
          let(:params) { { value: value } }
          it { is_expected.to compile.and_raise_error(%r{parameter 'value' expects a match for Tea::Rfc1918}) }
        end
      end
    end
  end
end
