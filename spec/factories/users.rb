FactoryBot.define do
  factory :admin, class: User do
    name {"Amin"}
    email {"admin@ts.com"}
    password {"111111"}
    password_confirmation {"111111"}
    supervisor {true}
  end

  factory :user, class: User do
    name {"User"}
    email {"user@ts.com"}
    password {"111111"}
    password_confirmation {"111111"}
    supervisor {false}
  end
end
