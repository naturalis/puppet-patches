require 'spec_helper'
describe 'patches' do

  context 'with defaults for all parameters' do
    it { should contain_class('patches') }
  end
end
