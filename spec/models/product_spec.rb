require 'rails_helper'

RSpec.describe Product, type: :model do

  before do
    @product = FactoryGirl.create(:product)
  end

  subject { @product }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:price) }

  it { should be_valid }

  describe "when product name is not present" do
    context "name is an empty string" do
      before { @product.name = "" }
      it { should_not be_valid }
    end

    context "name is nil" do
      before { @product.name = nil }
      it { should_not be_valid }
    end
  end

  describe "when product description is not present" do
    context "description is an empty string" do
      before { @product.description = "" }
      it { should_not be_valid }
    end

    context "description is nil" do
      before { @product.description = nil }
      it { should_not be_valid }
    end
  end

  describe "when product price is not present" do
    context "price is an empty string" do
      before { @product.price = "" }
      it { should_not be_valid }
    end

    context "price is nil" do
      before { @product.price = nil }
      it { should_not be_valid }
    end
  end

  describe "when price is not a number" do
    before { @product.price = "12a3" }
    it { should_not be_valid }
  end

end
