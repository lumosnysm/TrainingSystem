require "rails_helper"

RSpec.describe Course, type: :model do
  subject {FactoryBot.create :course}

  describe "validations" do
    it {is_expected.to validate_presence_of :start_date}
    it {is_expected.to validate_presence_of :end_date}
    it {is_expected.to validate_presence_of :name}

    it "valid course" do
      expect(subject).to be_valid
    end

    it "invalid course" do
      subject.name = nil
      expect(subject).to_not be_valid
    end
  end

  describe "associations" do
    it {is_expected.to have_many :subjects}
    it {is_expected.to have_many :user_subjects}
    it {is_expected.to have_many :users}
  end

  describe "db schema" do
    context "columns" do
      it {is_expected.to have_db_column(:name).of_type :string}
      it {is_expected.to have_db_column(:description).of_type :text}
      it {is_expected.to have_db_column(:start_date).of_type :date}
      it {is_expected.to have_db_column(:end_date).of_type :date}
      it {is_expected.to have_db_column(:status).of_type :integer}
    end
  end

  describe ".lastest" do
    it "return courses order by date desc" do
      expect(Course.lastest).to eq Course.order(updated_at: :desc)
    end
  end
end
