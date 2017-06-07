require 'spec_helper'

if Puppet.version.to_f >= 4.5
  describe 'test::syslogfacility', type: :class do
    describe 'valid handling' do
      %w(
        kern user mail daemon auth lpr news uucp cron
        local0 local1 local2 local3 local4 local5 local6 local7
      ).each do |value|
        describe value.inspect do
          let(:params) { { value: value } }
          it { is_expected.to compile }
        end
      end
    end

    describe 'invalid path handling' do
      context 'garbage inputs' do
        [
          [nil],
          [nil, nil],
          { 'foo' => 'bar' },
          {},
          '',
          1,
          'asdasd!@#$',
          '=asdasd9879876876+/',
          'asda=sd9879876876+/',
          'asdaxsd9879876876+/===',
          'asdads asdasd'
        ].each do |value|
          describe value.inspect do
            let(:params) { { value: value } }
            it { is_expected.to compile.and_raise_error(%r{parameter 'value' expects a match for Tea::Syslogfacility}) }
          end
        end
      end
    end
  end
end
