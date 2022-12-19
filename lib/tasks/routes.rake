# frozen_string_literal: true

task routes: :environment do
  puts `bundle exec rails routes |
    grep --invert-match --extended-regexp 'turbo\/native\|\/action_mailbox\/\|\/active_storage\/'`
end
