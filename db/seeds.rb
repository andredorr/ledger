puts "Destroying existing records..."
User.destroy_all
Debt.destroy_all
Person.destroy_all

User.create email: 'admin@admin.com', password: '111111'

puts "Usuário criado:"
puts "login admin@admin.com"
puts "111111"

10000.times do |counter|
  puts "Creating user #{counter}"
  User.create email: Faker::Internet.email, password: '111111'
end

50000.times do |counter|
  puts "Inserting Person #{counter}"

  attrs = {
    name: Faker::Name.name,
    phone_number: Faker::PhoneNumber.phone_number,
    national_id: CPF.generate,
    active: [true, false].sample,
    user: User.order('random()').first
  }
  person = Person.create(attrs)

  5.times do |debt_counter|
    puts "Inserting Debt #{debt_counter}"
    person.debts.create(
      amount: Faker::Number.between(from: 1, to: 200),
      observation: Faker::Lorem.paragraph
    )
  end
  5.times do |payment_counter|
    puts "Inserting Payment #{payment_counter}"
    start_date = Time.new(2000, 1, 1).to_i
    end_date = Time.new(2024, 5, 4).to_i
    person.payments.create( 
      amount: Faker::Number.between(from: 1, to: 500),
      paid_at: Time.at(rand * (end_date - start_date) + start_date)
    )
  end



end
