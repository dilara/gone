# frozen_string_literal: true

if User.count.zero?
  [
    %w[Admin User adminuser admin@gone.com admin 12345678],
    %w[Member User memberuser member@gone.com member 12345678],
    %w[Member User2 memberuser2 member2@gone.com member 12345678]
  ].each do |user|
    User.create(
      first_name: user[0],
      last_name: user[1],
      username: user[2],
      email: user[3],
      role: user[4],
      password: user[5]
    )
  end
end

if Brand.count.zero?
  6.times do |i|
    Brand.create(name: "Brand #{i + 1}")
  end
end

if Auction.count.zero?
  description = 'Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit. '
  now = Time.zone.now

  User.member.each do |member|
    5.times do
      auction = member.auctions.new(
        name: 'Auction',
        description: description * rand(5),
        base_price: rand(10..1_000),
        brand_id: Brand.pluck(:id).sample,
        starts_at: now,
        expires_at: now + rand(5..30).minutes,
      )

      auction.cover.attach(
        io: File.open(Rails.root.join('app', 'assets', 'images', 'logo.png')),
        filename: 'logo.png',
        content_type: 'image/png')

      auction.save
    end
  end
end
