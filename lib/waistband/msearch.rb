require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/array/extract_options'
require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/object/try'
require 'elasticsearch'

module WaistBand
  class Msearch

    def initialize(query_arr=[])
      @query_arr = query_arr
    end

    def add_query(index, query, options={})
      b = ::Waistband::Index.new(index, options)
      @query_arr << b.search_builder(query)
    end

    def perform
      results = client.msearch body: @query_arr

      results.each_with_index.map do |v, k|
        if @query_arr[k][:from].present? && @query_arr[k][:size].present?
          ::Waistband::SearchResults.new(v, page: (@query_arr[k][:from]/@query_arr[k][:size]) + 1, page_size: @query_arr[k][:size])
        else
          ::Waistband::SearchResults.new(v)
        end
      end
    end

    def client
      @client ||= ::Waistband.config.client
    end

  end
end