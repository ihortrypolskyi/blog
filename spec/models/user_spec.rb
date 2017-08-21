require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do

    context 'presence:' do
      let(:user) {build(:user, first_name: nil)}
      # (:user, first_name: nil, last_name: nil, email: nil, password: nil )
      it 'should require user first_name'do
        expect(user).to_not be_valid
      end
      let(:user_1) {build(:user, last_name: nil )}
      it 'should require user last_name'do
        expect(user_1).to_not be_valid
      end
      let(:user_2) {build(:user, email: nil)}
      it 'should require user email'do
        expect(user_2).to_not be_valid
      end
      let(:user_3) {build(:user, password: nil )}
      it 'should require user password'do
        expect(user_3).to_not be_valid
      end
    end

    context 'length:' do
      let(:user_4) {build(:user, first_name: 'Jo')}
      it 'should require first_name length >= 3' do
        expect(user_4).to_not be_valid
      end

      let(:user_5) {build(:user, first_name: 'Joooooooooooooooooooooooooooooo')}
      it 'should require first_name length <= 30' do
        expect(user_5).to_not be_valid
      end

      let(:user_6) {build(:user, last_name: 'Jo')}
      it 'should require last_name length >= 3' do
        expect(user_7).to_not be_valid
      end

      let(:user_7) {build(:user, last_name: 'Joooooooooooooooooooooooooooooo')}
      it 'should require last_name length <= 30' do
        expect(user_7).to_not be_valid
      end

      let(:user_8) {build(:user, password: 'Jo')}
      it 'should require password length >= 3' do
        expect(user_8).to_not be_valid
      end

      let(:user_9) {build(:user, password: 'Joooooooooooooooooooooooooooooo')}
      it 'should require password length <= 30' do
        expect(user_9).to_not be_valid
      end

      let(:user_16) {build(:user, first_name: 'Johnna', last_name: 'Best', email: 'johndoes@gmail.com', password: 'john')}
      it 'should require first_name, last_name, password length: {in: 3..30}' do
        expect(user_16).to be_valid
      end
    end

    context 'uniqueness:' do
      let!(:user_12) {create(:user, first_name: 'John', last_name: 'Doe', email: 'johndoe@gmail.com')}
      let(:user_13) {build(:user, first_name: 'John', last_name: 'Doe', email: 'johndoe@gmail.com')}
      it 'should require unique first_name, last_name, email' do
        expect(user_13).to_not be_valid
      end

      let(:user_14) {build(:user, first_name: 'Johns', last_name: 'Does', email: 'johndoes@gmail.com')}
      it 'should require unique first_name, last_name, email' do
        expect(user_14).to be_valid
      end

      let(:user_15) {build(:user, first_name: 'john', last_name: 'doe', email: 'johndoes@gmail.com')}
      it 'should require unique first_name, last_name {case sensitive: false}' do
        expect(user_15).to_not be_valid
      end
    end
  end
end
