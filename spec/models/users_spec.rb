require "rails_helper"

RSpec.describe User, type: :model do
  subject {FactoryBot.create :user}

  describe "validations" do
    it {is_expected.to validate_presence_of :email}
    it {is_expected.to validate_presence_of :name}

    it "valid user" do
      expect(subject).to be_valid
    end

    it "invalid user" do
      subject.name = nil
      expect(subject).to_not be_valid
    end
  end

  describe "associations" do
    it {is_expected.to have_many :courses}
    it {is_expected.to have_many :user_subjects}
    it {is_expected.to have_many :reports}
    it {is_expected.to have_many :activities}
  end

  describe "db schema" do
    context "columns" do
      it {is_expected.to have_db_column(:name).of_type :string}
      it {is_expected.to have_db_column(:email).of_type :string}
      it {is_expected.to have_db_column(:encrypted_password).of_type :string}
      it {is_expected.to have_db_column(:supervisor).of_type :boolean}
    end
  end
end
