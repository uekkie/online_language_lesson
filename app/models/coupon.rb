class Coupon < ActiveHash::Base
  self.data = [
    {id: 1, name: "1回分：2000円+税", price: 2000, number: 1},
    {id: 2, name: "3回分：5000円+税", price: 5000, number: 3},
    {id: 3, name: "5回分：7500円+税", price: 7500, number: 5}
  ]
end
