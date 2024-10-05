require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should allow_value('user@example.com').for(:email) }
    it { should_not allow_value('invalid-email').for(:email) }

    it { should validate_length_of(:password).is_at_least(6) }

    context "when email format is invalid" do
      it "is invalid with an improperly formatted email" do
        invalid_emails = %w[user@com user_at_example.org user.name@example. foo@bar_baz.com foo@bar+baz.com foo@bar_baz.c]
        invalid_emails.each do |invalid_email|
          subject.email = invalid_email
          expect(subject).not_to be_valid
        end
      end
    end

    context "when email format is valid" do
      it "is valid with a properly formatted email" do
        valid_emails = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
        valid_emails.each do |valid_email|
          subject.email = valid_email
          expect(subject).to be_valid
        end
      end
    end

    context "when email is not unique" do
      let!(:existing_user) { create(:user, email: "test@example.com") }

      it "is invalid with a duplicate email" do
        duplicate_user = build(:user, email: "test@example.com")
        expect(duplicate_user).not_to be_valid
      end
    end

    context "when password is too short" do
      it "is invalid if the password is shorter than 6 characters" do
        subject.password = "short"
        expect(subject).not_to be_valid
        expect(subject.errors[:password]).to include("is too short (minimum is 6 characters)")
      end
    end

    context "when password meets length requirement" do
      it "is valid with a password of 6 or more characters" do
        subject.password = "validpassword"
        subject.password_confirmation = "validpassword"
        expect(subject).to be_valid
      end
    end

    context "when password and password confirmation does not match" do
      it "is invalid with a different password and password confirmation" do
        subject.password = "valid_password"
        subject.password_confirmation = "different_password"
        expect(subject).not_to be_valid
      end
    end
  end
end