# frozen_string_literal: true

if User.count.zero?
  [
    %w[Admin User admin@gone.com admin 12345678],
    %w[Customer User customer@gone.com customer 12345678],
    %w[Customer User2 customer2@gone.com customer 12345678]
  ].each do |user|
    User.create(
      first_name: user[0],
      last_name: user[1],
      email: user[2],
      role: user[3],
      password: user[4]
    )
  end
end

if Auction.count.zero?
  description = 'Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit. '
  now = Time.zone.now

  User.customer.each do |customer|
    5.times do
      customer.auctions.create(
        name: 'Auction',
        description: description * rand(5),
        base_price: rand(10..1_000),
        starts_at: now + rand(30).minutes,
        expires_at: now + rand(30..300).minutes
      )
    end
  end
end
