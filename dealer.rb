#!/usr/bin/env ruby
# encoding: UTF-8
require 'pry'

class Dealer

  SUITS = ['♠', '♣', '♥', '♦']
  VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
  SCORE = {
           '2' => 2, '3' => 3, '4' => 4, '5' => 5, 
           '6' => 6, '7' => 7, '8' => 8, '9' => 9,
           '10' => 10, 'J' => 10, 'Q' => 10, 'K' => 10, 'A' => 11
          }
  PLAYER = "Player"
  DEALER = "Dealer"

  def initialize
    @deck = build_deck
    @player_lost = false
    @dealer_lost = false
    @player_score = 0
    @dealer_score = 0
  end

  def build_deck
    deck = []
    SUITS.each do |suit|
      VALUES.each do |value|
        deck.push(value + suit)
      end
    end
    deck.shuffle
  end

  def deal(who)
    card = @deck.pop
    puts "#{who} was dealt: #{card}"
    card
  end

  def score(hand, who)
    value = 0
    aces = 0
    hand.each do |card|
      #.chop takes the last character out leaving only the card value.
      card = card.chop
      if card != 'A'
        value += SCORE[card]
      else
        aces += 1
      end
    end
    aces.times do
      if value + SCORE['A'] + (aces - 1) <= 21
        value += SCORE['A']
      else
        value += 1
      end
    end
    puts "#{who} score: #{value}"
    value
  end

  def stand?
    print "Hit or stand (H/S): "
    hit_or_stand = gets.chomp
    return true if hit_or_stand.downcase == 's'
    return false if hit_or_stand.downcase == 'h'
    puts "Invalid input. Please put H or S.\n"
    stand?
  end

  def bust?(score, who)
    return false if score <= 21
    @player_lost = true if who == PLAYER
    @dealer_lost = true if who == DEALER
    true
  end

  def dealer_play
    dealer_hand = []
    dealer_hand << deal(DEALER) << deal(DEALER)
    score = score(dealer_hand, DEALER)
    while !bust?(score, DEALER) && score < 17
      dealer_hand << deal(DEALER)
      score = score(dealer_hand, DEALER)
    end
    if !@dealer_lost
      puts "Dealer stands.\n\n"
      @dealer_score = score
      display_winner
    else
      puts "Dealer bust! Player wins!"
    end
  end

  def display_winner
    if @player_score > @dealer_score
      puts "You win!"
    else
      puts "You lose!"
    end
  end

  def play_game
    puts "Welcome to Blackjack!\n\n"
    player_hand = []
    player_hand << deal(PLAYER) << deal(PLAYER)
    score = score(player_hand, PLAYER)
    while !bust?(score, PLAYER) && !stand?
      player_hand << deal(PLAYER)
      score = score(player_hand, PLAYER)
    end
    if !@player_lost
      @player_score = score
      dealer_play
    else
      puts "Bust! You lose!"
    end
  end
end