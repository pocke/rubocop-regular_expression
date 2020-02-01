# frozen_string_literal: true

RSpec.describe RuboCop::Cop::RegularExpression::MixedCaptureTypes do
  subject(:cop) { described_class.new(config) }

  let(:config) { RuboCop::Config.new }

  it 'registers an offense when both of named and numbered captures are used' do
    expect_offense(<<~RUBY)
      /(?<foo>bar)(baz)/
      ^^^^^^^^^^^^^^^^^^ Do not mix named captures and numbered captures
    RUBY
  end

  it 'does not register offense to a regexp with named capture only' do
    expect_no_offenses(<<~RUBY)
      /(?<foo>bar)/
    RUBY
  end

  it 'does not register offense to a regexp with numbered capture only' do
    expect_no_offenses(<<~RUBY)
      /(bar)/
    RUBY
  end

  it 'does not register offense to a regexp with named capture and non-capturing group' do
    expect_no_offenses(<<~RUBY)
      /(<foo>bar)(?:bar)/
    RUBY
  end
end
