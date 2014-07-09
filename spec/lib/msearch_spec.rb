require 'spec_helper'

describe Waistband::Msearch do
  let(:msearch)   { Waistband::Msearch.new }

  it 'can work' do
    msearch.add_raw_query({query: {match_all: {}}})
  end

end