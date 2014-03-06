require 'pry'

def deal(cards)
  hand = []
  while hand.length < 2
    card = cards.pop
    hand << card
  end
  hand
end

def score(hand)
  array = hand.map { |card| card.split }
  
  values = []
  array.each { |element| values << element.slice(0) }

  score = 0
  values.each do |value|
    if value == 'Ace'
      score += 11
      if score > 21
        score -= 10
      end
    elsif value.to_i == 0
      score += 10
    else
      score += value.to_i
    end
  end
  
  score
end

puts "Welcome to BlackJack! Please enter your name!"
name = gets.chomp
puts

suits = ["Diamonds", "Spades", "Hearts", "Clubs"]
card_values = ["2", "3", "4", "5", "6", "7", "8", "9", "10", 'Jack', 'Queen', 'King', 'Ace']
deck = []

suits.each do |suit|
  card_values.each do |value| 
    card = "#{value} of #{suit}" 
    deck << card
  end
end
deck.shuffle!

puts "Dealing..."

player_hand = deal(deck)
dealer_hand = deal(deck)

puts
puts "#{name}'s hand => #{player_hand}"
puts score(player_hand) 
puts
puts "Dealer's hand => #{dealer_hand}"
puts score(dealer_hand)
puts

if score(player_hand) == 21
  puts "Congratulations #{name}, you hit blackjack!  Winner winner chicken dinner!"
  exit
end
 
while score(player_hand) < 21
  puts "Would you like to hit or stay?"
  puts
  move = gets.chomp.downcase
  puts

  if !["hit","stay"].include?(move)
    puts "Error. Please enter hit or stay."
    puts
    next
  end

  if move == "hit"
    player_hand = player_hand << deck.pop
    puts "#{name}'s hand => #{player_hand}"
    puts score(player_hand)
    puts
      if score(player_hand) > 21
        puts "Sorry #{name}, you busted! Dealer wins :("
        exit
      end
  end
  
  if move == 'stay'
    puts "#{name}'s hand => #{player_hand}"
    puts score(player_hand)
    puts
    break
  end
end

if score(dealer_hand) == 21
  puts "Sorry #{name}, dealer hit blackjack. Dealer wins :("
  exit
end
  
while score(dealer_hand) <= 16 
    dealer_hand = dealer_hand << deck.pop
    puts "Dealer hits..."
    puts "Dealer's hand => #{dealer_hand}"
    puts score(dealer_hand)
    puts

    if score(dealer_hand) > 21
      puts "Dealer busted! Congratulations #{name}, you win!"
      break
    end    
end

if score(player_hand) > score(dealer_hand)
  puts "Congratulations #{name}, you win! :)"
elsif score(player_hand) == score(dealer_hand)
  puts "Push"
else
  puts "Sorry #{name}, dealer wins :(" 
end



