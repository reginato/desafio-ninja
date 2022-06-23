# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: User do
	name { "Rodrigo Reginato"}
	email { "rreginatom@gmail.com" }
  end
end
  