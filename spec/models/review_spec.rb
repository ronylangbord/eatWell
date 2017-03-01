require 'rails_helper'

describe Review, type: :model do

  describe "data validation" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:rating) }
    it { should validate_presence_of(:comment) }
  end


end

