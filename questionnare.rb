#!/usr/bin/env ruby
require "pstore"

class Questionnare
  STORE_NAME = "tendable.pstore"
  attr_reader :input

  QUESTIONS = {
    "q1" => "Can you code in Ruby?", # Question 1
    "q2" => "Can you code in Javascript?", # Question 2
    "q3" => "Can you code in Swift?", # Question 3
    "q4" => "Can you code in Java?", # Question 4
    "q5" => "Can you code in C#?", # Question 5
    "q6" => "Can you code in Python?", # Question 6
    "q7" => "Can you code in Kotlin?", # Question 7
    "q8" => "Can you code in PHP?" # Question 8
  }.freeze

  # Run the questionnaire
  def self.run
    store = PStore.new(STORE_NAME) # Create a new PStore instance with the store name
    instance = new # Create a new instance of the Questionnare class
    instance.do_prompt(store) # Prompt the user for answers and store them in the PStore
    instance.do_report(store) # Display the report based on the stored answers
  end

  # Initialize the Questionnare instance with an input stream.
  # By default, it uses the standard input stream ($stdin).
  def initialize(input = $stdin)
    @input = input
  end

  def do_prompt(store)
    answers = {}
    QUESTIONS.each_key do |question_key|
      puts QUESTIONS[question_key] # Display the question
      ans = input.gets.chomp.downcase
      answers[question_key] = ans == "yes" || ans == "y" # Store the answer
      current_rating = 100.0 * answers.values.count(true) / QUESTIONS.size # Calculate the current rating
      puts "Last run rating: #{current_rating}%" # Display the current rating
    end
    store.transaction { store[:answers] = (store[:answers] || []) << answers } # Store the answers in the PStore
  end

  def do_report(store)
    store.transaction do
      all_answers = store[:answers] || []
      if all_answers.empty?
        puts "No runs yet." # Display message if no runs have been recorded
      else
        last_run = all_answers.last
        average_rating = (100.0 * last_run.values.count(true)) / QUESTIONS.size # Calculate the average rating
        puts "Average rating: #{average_rating}%" # Display the average rating
      end
    end
  end
end

Questionnare.run if __FILE__ == $0
