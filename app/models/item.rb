class Item < ApplicationRecord
  validates :name, {presence: true}
  validates :price, {presence: true,numericality: {only_interger: true}}
  validates :condition, {presence: true}
  validates :seller_id, {presence: true}
end
