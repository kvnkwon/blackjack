#!/usr/bin/env ruby
# encoding: UTF-8
require 'pry'

class Dealer

  SUITS = ['♠', '♣', '♥', '♦']
  VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

  def initialize
    @deck = build_deck
  end

  def build_deck
    deck = []
    SUITS.each do |suit|
      VALUES.each do |value|
        deck.push(value + suit)
      end
    end
    deck.shuffle
    player_issued(deck)
  end

  def deal_hand(who)
    first = @deck.pop
    puts "#{who} was dealt: #{first}"
    second = @deck.pop
    puts "#{who} was dealt: #{second}"
    [] << first << second
  end

  def score(hand)
  end

  def hit_or_stand
  end

  def dealer_play
  end

  def start_game
    puts "Welcome to Blackjack!\n\n"
    player_hand = deal_hand("Player")
  end

end