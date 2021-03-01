module Elasticsearch
  class NoMatch < ::NullObject
    def to_a
      []
    end

    def objects
      []
    end
  end
end
