# FILEPATH: /home/sujith/questionnare/questionnare_spec.rb
require "rspec"
require_relative "../questionnare/questionnare"

RSpec.describe Questionnare do
  before(:each) do
    @store = PStore.new("test.pstore")
    @input = StringIO.new("yes\nno\nyes\nno\nyes\nno\nyes\nno\n")
    @questionnare = Questionnare.new(@input)
  end

  after(:each) do
    File.delete("test.pstore") if File.exist?("test.pstore")
  end

  describe "#do_prompt" do
    it "stores answers correctly and calculates rating" do
      p @store
      @questionnare.do_prompt(@store)
      expected_answers = {
        "q1" => true,
        "q2" => false,
        "q3" => true,
        "q4" => false,
        "q5" => true,
        "q6" => false,
        "q7" => true,
        "q8" => false
      }

      @store.transaction do
        expect(@store[:answers].last).to eq(expected_answers)
      end
    end

    it "handles unexpected input" do
      @input = StringIO.new("maybe\nno\nyes\nno\nyes\nno\nyes\nno\n")
      @questionnare = Questionnare.new(@input)
      @questionnare.do_prompt(@store)
      expected_answers = {
        "q1" => false, # 'maybe' is not 'yes' or 'y'
        "q2" => false,
        "q3" => true,
        "q4" => false,
        "q5" => true,
        "q6" => false,
        "q7" => true,
        "q8" => false
      }
      @store.transaction do
        expect(@store[:answers].last).to eq(expected_answers)
      end
    end

    it "handles missing input" do
      @input = StringIO.new("\nno\nyes\nno\nyes\nno\nyes\nno\n")
      @questionnare = Questionnare.new(@input)
      @questionnare.do_prompt(@store)
      expected_answers = {
        "q1" => false, # empty input is not 'yes' or 'y'
        "q2" => false,
        "q3" => true,
        "q4" => false,
        "q5" => true,
        "q6" => false,
        "q7" => true,
        "q8" => false
      }
      @store.transaction do
        expect(@store[:answers].last).to eq(expected_answers)
      end
    end

    it "handles mixed case input" do
      @input = StringIO.new("YeS\nnO\nYeS\nnO\nYeS\nnO\nYeS\nnO\n")
      @questionnare = Questionnare.new(@input)
      @questionnare.do_prompt(@store)
      expected_answers = {
        "q1" => true, # 'YeS' is treated as 'yes'
        "q2" => false,
        "q3" => true,
        "q4" => false,
        "q5" => true,
        "q6" => false,
        "q7" => true,
        "q8" => false
      }
      @store.transaction do
        expect(@store[:answers].last).to eq(expected_answers)
      end
    end

    it "calculates rating correctly" do
      @questionnare.do_prompt(@store)
      @store.transaction do
        expect(@store[:answers].last.values.count(true)).to eq(4)
      end
    end
  end
end
