FactoryBot.define do
  factory :user do 
    email "misora@mailinator.com"
    username "misora"
    password 'password'
    password_confirmation 'password'
    factory :another_user do 
      email "kanako@mailinator.com"
      username "kanako"
    end
    factory :activated_user do 
      email "kako@mailinator.com"
      username "kako"
      activate true
    end
  end

  factory :tweet do
    message 'This is my first tweet'
    user { create(:user) }
    factory :another_tweet do 
      message "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishin"
    end
  end

  factory :follow do
    followers { create(:user) }
    following { create(:another_user) }
  end
end
