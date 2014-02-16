FactoryGirl.define do
	factory :user do
		sequence(:username) { |n| "Pekka#{n}" }
		password "Foobar1"
		password_confirmation "Foobar1"
	end

	factory :rating do
		score 10
	end

	factory :rating2, class: Rating do
		score 20
	end
	factory :brewery do
		name "anonymous"
		year 1900
	end

	factory :beer do
		name "anonymous"
		brewery
		style Style.create name:"Lager"
	end
end