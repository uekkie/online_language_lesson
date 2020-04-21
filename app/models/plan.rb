class Plan < ActiveHash::Base
  self.data=[
      {id: 1, name: "ライトプラン：毎月5回、月額7000円", price: 7000, number: 5},
      {id: 2, name: "スタンダードプラン：毎月7回、月額9500円", price: 9500, number: 7},
      {id: 3, name: "ヘビープラン：毎月10回、月額12000円", price: 12000, number: 10},
  ]
end
