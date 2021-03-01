# Check how field will split phrase into tokens:
# POST localhost:9200/stripe_test_development_items/_analyze
# { "field": "title.edge", "text": "astartes" }

# Check how analyzer will split phrase into tokens:
# POST localhost:9200/stripe_test_development_items/_analyze
# { "analyzer": "edge_ngram_analyzer", "text": "astartes" }

class ApplicationIndex < Chewy::Index
  ORIGINAL_FIELD = {
    type: "text",
    index: true,
    analyzer: :original_analyzer,
    search_analyzer: :original_analyzer
  }.freeze
  EDGE_NGRAM_FIELD = {
    type: "text",
    index: true,
    analyzer: :edge_ngram_analyzer,
    search_analyzer: :original_analyzer
  }.freeze
  EDGE_NGRAM_WORD_FIELD = {
    type: "text",
    index: true,
    analyzer: :edge_ngram_word_analyzer,
    search_analyzer: :word_analyzer
  }.freeze
  NGRAM_FIELD = {
    type: "text",
    index: true,
    analyzer: :ngram_analyzer,
    search_analyzer: :word_analyzer
  }.freeze

  DEFAULT_SETTINGS = {
    number_of_shards: 1,
    index: {
      max_ngram_diff: 20
    },
    analysis: {
      analyzer: {
        original_analyzer: {
          type: "custom",
          tokenizer: "keyword",
          filter: %w[lowercase asciifolding]
        },
        word_analyzer: {
          type: "custom",
          tokenizer: "standard",
          filter: %w[lowercase asciifolding]
        },
        edge_ngram_analyzer: {
          type: "custom",
          tokenizer: "edge_ngram_tokenizer",
          filter: %w[lowercase asciifolding edge_ngram_filter distinct_words_filter]
        },
        edge_ngram_word_analyzer: {
          type: "custom",
          tokenizer: "standard",
          filter: %w[lowercase asciifolding edge_ngram_filter]
        },
        ngram_analyzer: {
          type: "custom",
          tokenizer: "standard",
          filter: %w[lowercase asciifolding ngram_filter distinct_words_filter]
        }
      },
      tokenizer: {
        edge_ngram_tokenizer: {
          type: "edge_ngram",
          min_gram: 1,
          max_gram: 20
        }
      },
      filter: {
        ngram_filter: {
          type: "ngram",
          min_gram: 1,
          max_gram: 20
        },
        edge_ngram_filter: {
          type: "edge_ngram",
          min_gram: 1,
          max_gram: 20
        },
        distinct_words_filter: {
          type: "unique",
          only_on_same_position: true
        }
      }
    }
  }.freeze
end
