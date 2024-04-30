# Tendable Coding Assessment

## Usage
```
bundle exec questionnaire.rb

```

## Goal

The goal is to implement a survey where a user should be able to answer a series of Yes/No questions. After each run, a rating is calculated to let them know how they did. Another rating is also calculated to provide an overall score for all runs.

## Requirements

Possible question answers are: "Yes", "No", "Y", or "N" case insensitively to answer each question prompt.

The answers will need to be **persisted** so they can be used in calculations for subsequent runs >> it is proposed you use the pstore for this, already included in the Gemfile

After _each_ run the program should calculate and print a rating. The calculation for the rating is: `100 * number of yes answers / number of questions`.

The program should also print an average rating for all runs.

The questions can be found in questionnaire.rb

Ensure we can run your exercise

## Bonus Points

Updated readme with an explanation of your approach

Unit Tests

Code Comments

Dockerfile / Bash script if needed for us to run the exercise


# Explanation

The Questionnaire application is designed to allow users to answer a series of questions and store their answers for later analysis. To achieve this, I have implemented the following approach:

Question Storage: I used a PStore, which is a simple file-based persistence library in Ruby, to store the questions and answers. This allows us to save the user's responses and retrieve them later.

User Interaction: The application prompts the user with a series of questions and waits for their input. I use the gets method in Ruby to read the user's input from the command line.


Average Rating Calculation: After the user has answered all the questions, I calculate the average rating based on their responses. This provides a summary of the overall rating for the questionnaire.

Reporting: Finally, I generate a report that displays the average rating to the user. This report helps them understand the overall feedback received from the questionnaire.

# Execution

1. Clone the repository
2. bundle install
3. bundle exec questionnare.rb or ./questionnare.rb
