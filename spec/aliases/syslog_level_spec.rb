require 'spec_helper'

if Puppet.version.to_f >= 4.5
  describe 'test::syslog_level', type: :class do
    describe 'valid handling' do
      %w(
        critical
        error
        warn
        info
        debug
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
        ].each do |value|
          describe value.inspect do
            let(:params) { { value: value } }
            it { is_expected.to compile.and_raise_error(%r{parameter 'value' expects a match for Tea::Syslog_level}) }
          end
        end
      end
    end
  end
end
