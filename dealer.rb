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

  def initialize
    @deck = build_deck
    @player_lost = false
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
    hand.each do |card|
      #tells card to start at index 0, minus the amount of characters to ignore, so that it takes off
      #the suits and only keeps the value.
      value += SCORE[card[0,card.length - 1]]
    end
    puts "#{who} score: #{value}"
    value
  end

  def stand?
    print "Hit or stand (H/S): "
    hit_or_stand = gets.chomp
    return true if hit_or_stand.downcase == 's'
    return false if hit_or_stand.downcase == 'h'
    puts "Invalid input. Please put H or S."
    stand?
  end

  def bust?(score)
    return false if score < 21
    @player_lost = true
    true
  end

  def dealer_play
  end

  def play_game
    puts "Welcome to Blackjack!\n\n"
    player_hand = []
    player_hand << deal("Player") << deal("Player")
    score = score(player_hand, "Player")
    while !bust?(score) && !stand?
      player_hand << deal("Player")
      score = score(player_hand, "Player")
    end
    if !@player_lost
      dealer_play
    else
      puts "Bust! You lose!"
  end

end