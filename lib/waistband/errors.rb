module Waistband
  module Errors

    class IndexExists < StandardError; end
    class IndexNotFound < StandardError; end
    class NoSearchHits < StandardError; end

  end
end
