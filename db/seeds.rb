# db/seeds.rb

reviews = [
  {
    name: "Jasmine Thompson",
    review: "I've been getting my braids done at Braided Beauty for over a year now and I'm always impressed. Michelle's attention to detail is incredible, and my knotless braids last for months!",
    rating: 5,
  },
  {
    name: "Olivia Chen",
    review: "First time getting box braids and I couldn't be happier with the results. The stylist took the time to explain the process and made sure I was comfortable throughout. Definitely coming back!",
    rating: 5,

  },
]

reviews.each do |review|
  Review.create!(review)
end
