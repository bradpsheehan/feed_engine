FactoryGirl.define do

  factory :user do
    name             "kareemgrant"
    provider         "twitter"
    oauth_token      "318092c9fa74468dba0507844d29cf4d"
    oauth_secret     "abscded"
    uid              "5234295"
    status           "confirmed"
  end

  factory :app_provider do
    user

    name              "kareemgrant"
  end

  factory :activity do
    user

    provider          "RunKeeper"
    duration          3138.844
    distance          10622.2704823343
    detail_present    false
    sequence(:activity_id) { |n| "#{n}769314" }
  end


end

