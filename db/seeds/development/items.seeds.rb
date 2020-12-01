50.times do
  Item.create(
    title: Faker::Kpop.girl_groups,
    description: Faker::Lorem.paragraph(sentence_count: 4, random_sentences_to_add: 4),
    price: rand(0.1..100)
  )
end
