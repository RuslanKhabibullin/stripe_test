class ItemsIndex < ApplicationIndex
  TEXT_FIELDS = %i[title].freeze

  settings DEFAULT_SETTINGS

  define_type Item do
    TEXT_FIELDS.each do |field_name|
      field field_name,
            type: "keyword",
            index: false,
            fields: {
              original: ORIGINAL_FIELD,
              edge: EDGE_NGRAM_FIELD,
              edge_word: EDGE_NGRAM_WORD_FIELD,
              ngram: NGRAM_FIELD
            }
    end
  end
end
