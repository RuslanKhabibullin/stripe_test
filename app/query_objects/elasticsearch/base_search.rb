module Elasticsearch
  class BaseSearch
    attr_reader :term, :limit
    private :term, :limit

    DEFAULT_LIMIT = 10

    def initialize(term, limit = DEFAULT_LIMIT)
      @term = term
      @limit = limit
    end

    def call
      return NoMatch.new if term.blank?

      elastic_index.query(dis_max_query).limit(limit)
    end

    private

    def dis_max_query
      {
        dis_max: {
          queries: queries,
          tie_breaker: 0.5
        }
      }
    end

    def queries
      elastic_index::TEXT_FIELDS.flat_map { |field| field_query(field) }
    end

    def field_query(field)
      [
        { match: { "#{field}.original" => { query: term, boost: 100 } } },
        { match: { "#{field}.edge" => { query: term, boost: 50 } } },
        { match: { "#{field}.edge_word" => { query: term, boost: 20 } } },
        { match: { "#{field}.ngram" => { query: term, boost: 10 } } }
      ]
    end

    def elastic_index
      "::#{self.class.to_s.demodulize.chomp('Search')}Index".constantize
    end
  end
end
