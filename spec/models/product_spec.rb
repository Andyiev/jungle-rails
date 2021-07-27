require 'rails_helper'

RSpec.describe Product, type: :model do

  puts @categories = Category.all

  describe 'Validations' do
    
    it "should successfully save with all valid parameters" do
      @category = Category.new(name: 'Tools')
      @category.save
      @product = @category.products.create!(name: 'Hunner', price: 1599, quantity: 5, category_id: @category)
      @product.save
      expect(@product).to be_valid
    end

    it 'fails to create a new product when name is nil' do
      @category = Category.new(name: 'Tools')
      @category.save
      @product = Product.new(price: 1599, quantity: 5, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Name can't be blank")
      expect(@product).to_not be_valid
    end

    it 'fails to create a new product when price is nil' do
      @category = Category.new(name: 'Tools')
      @category.save
      @product = Product.new(name: 'Hunner', quantity: 5, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Price can't be blank")
      expect(@product).to_not be_valid
    end

    it 'fails to create a new product when quantaty is nil' do
      @category = Category.new(name: 'Tools')
      @category.save
      @product = Product.new(name: 'Hunner', price: 1599, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
      expect(@product).to_not be_valid
    end

    it 'fails to create a new product when category is nil' do
      @product = Product.new(name: "Hunner", price: 1599, quantity: 5)
      @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")
      expect(@product).to_not be_valid
    end
  end
end