# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Admin
Admin.create(email:"boss@final",password:"senhaimbativel")

###Menu
#Types
Type.create!(name:"entrada")
Type.create!(name:"pizza")
Type.create!(name:"lasanha")
Type.create!(name:"macarrao")
Type.create!(name:"bebida")

#Products
Product.create!(name:"Tábua de Queijos", price: 69.00, quantity: "Porção para 2 pessoas.", description: "Queijos Frescos: Minas Frescal, Ricota, Cream Cheese. Queijos Firmes: Grana Padano, parmesão, Queijos Azuis: Stilton, gorgonzola, roquefort.", type_id: 1)
Product.last.photo.attach(io: File.open('./public/Images/Tábua-de-queijos.jpg'), filename: 'Tábua-de-queijos.jpg')
Product.create!(name:"Tábua de Carne Frias", price: 39.00, quantity: "Porção para 2 pessoas.", description: "Galatines variadas, chourição, mortadela, presunto, fiambre.", type_id: 1)
Product.last.photo.attach(io: File.open('./public/Images/Tábua-de-carnes-frias.jpg'), filename: 'Tábua-de-carnes-frias.jpg')
Product.create!(name:"Saladinha", price: 39.50, quantity: "Porção para 1 pessoas.", description: "Salada levinha, com o toque crocante das amêndoas laminadas.", type_id: 1)
Product.last.photo.attach(io: File.open('./public/Images/Salada.jpg'), filename: 'Salada.jpg')

Product.create!(name:"Pizza de Calabresa", price: 67.00 , quantity: "8 fatias.", description: "Queijo, molho especial, calabresa.", type_id: 2)
Product.last.photo.attach(io: File.open('./public/Images/Calabresa.jpg'), filename: 'Calabresa.jpg')
Product.create!(name:"Pizza Portuguesa", price: 71.00, quantity: "8 fatias.", description: "Queijo, molho especial, ovo fatiado , tomate, rúcula.", type_id: 2)
Product.last.photo.attach(io: File.open('./public/Images/portuguesa.jpg'), filename: 'portuguesa.jpg')
Product.create!(name:"Pizza de Frango com Catupiry", price: 80.00, quantity: "8 fatias.", description: "Queijo, molho especial, frango catupiry.", type_id: 2)
Product.last.photo.attach(io: File.open('./public/Images/pizza-de-frango-com-catupiry-18845.jpg'), filename: 'pizza-de-frango-com-catupiry-18845.jpg')

Product.create!(name:"Lasanha de Camarão", price: 200.00 , quantity: "Porção de até 6 pessoas.", description: "Variação que é a cara do Brasil, com gostinho de mar e a cremosidade do requeijão. A Maizena engrossa o molho bechamel, que ganha uma cremosidade surpreendente.", type_id: 3)
Product.last.photo.attach(io: File.open('./public/Images/LasanhadeCamarão​.jpg'), filename: 'LasanhadeCamarão​.jpg')
Product.create!(name:"Lasanha de Frango", price: 180.00, quantity: "Porção de até 6 pessoas.", description: "Esse “quase ragú” de frango vai muito bem com a fina massa da lasanha e o queijo muçarela fatiado. A carne branca ganha sabor único com o tempero em pó Knorr zero sal frango. Nessa variação, o molho é ao sugo.", type_id: 3)
Product.last.photo.attach(io: File.open('./public/Images/Lasanhadefrango.jpg'), filename: 'Lasanhadefrango.jpg')
Product.create!(name:"Lasanha Bolonhesa", price: 220.00, quantity: "Porção de até 6 pessoas.", description: "Um clássico que não pode faltar para quem não dispensa as boas tradições à mesa: a lasanha à bolonhesa! Essa versão pra lá de cremosa guarda um segredo especial: o caldo de carne Knorr, que contém um mix de especiarias para realçar o sabor.", type_id: 3)
Product.last.photo.attach(io: File.open('./public/Images/LasanhaBolonhesa.jpg'), filename: 'LasanhaBolonhesa.jpg')

Product.create!(name:"Macarrão ao vinho branco", price: 65.00, quantity: "Porção individual.", description: "Massa Pérola Negra leva muçarela de búfala, tomate, pancetta, azeitonas pretas e manjericão fresco.", type_id: 4)
Product.last.photo.attach(io: File.open('./public/Images/VinhoBranco.jpg'), filename: 'VinhoBranco.jpg')
Product.create!(name:"Macarrão à parisiense", price: 80.00, quantity: "Porção individual.", description: "Tradicional molho francês que leva frango e ervilha com massa especial.", type_id: 4)
Product.last.photo.attach(io: File.open('./public/Images/macarrao-a-parisiense.jpg'), filename: 'macarrao-a-parisiense.jpg')
Product.create!(name:"Espaguete ao vôngole", price: 120.00, quantity: "Porção individual.", description: "Massa leve e saborosa feita com frutos do mar.", type_id: 4)
Product.last.photo.attach(io: File.open('./public/Images/spaghetti.jpg'), filename: 'spaghetti.jpg')

Product.create!(name:"Àgua mineral sem gás", price: 7.50, quantity: "500ml.", description: "Garrafa chique de água da fonte.", type_id: 5)
Product.last.photo.attach(io: File.open('./public/Images/Agua.jpg'), filename: 'Agua.jpg')
Product.create!(name:"Fanta Laranja", price: 11.00, quantity: "350ml.", description: "Latinha original.", type_id: 5)
Product.last.photo.attach(io: File.open('./public/Images/Fanta.jpeg'), filename: 'Fanta.jpeg')
Product.create!(name:"Vinho topíssimo", price: 99999.99, quantity: "Garrafa de 1 litro.", description: "Vinho descoberto no derretimento de uma calota polar, provavelmente envelhecido a ao menos 5000 anos.", type_id: 5)
Product.last.photo.attach(io: File.open('./public/Images/Caro.jpg'), filename: 'Caro.jpg')

#Users
User.create!(name: "Lucas", email: "lucas@gmail.com", password: "lucas123")
User.last.profile_picture.attach(io: File.open('./public/Images/Lucas_profile_picture.png'), filename:'Lucas_profile_picture.png')
User.create!(name: "Matheus", email: "matheus@gmail.com", password: "matheus123")
User.create!(name: "Victor", email: "victor@gmail.com", password: "victor123")

#Favourites
Favourite.create!(user_id:1, product: Product.last)
Favourite.create!(user_id:1, product_id: 4)
Favourite.create!(user_id:2, product_id: 7)
Favourite.create!(user_id:3, product_id: 13)

#User Admin
User.create!(name: "admin", email: "boss@final", password: "senhaimbativel")