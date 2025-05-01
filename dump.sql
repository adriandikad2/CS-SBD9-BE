CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS stores(
 id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
 name VARCHAR(255) NOT NULL,
 address VARCHAR(255) NOT NULL,
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE type transaction_status AS ENUM ('pending', 'paid');
CREATE TABLE IF NOT EXISTS transactions(
 id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
 user_id UUID NOT NULL,
 item_id UUID NOT NULL,
 quantity INT NOT NULL,
 total INT NOT NULL,
 status transaction_status DEFAULT 'pending',
 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
 FOREIGN KEY (item_id) REFERENCES items(id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS transactions CASCADE;
DROP TABLE IF EXISTS items CASCADE;
DROP TABLE IF EXISTS stores CASCADE;
DROP TABLE IF EXISTS users CASCADE;

CREATE TABLE IF NOT EXISTS users (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  balance INT DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS stores(
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(255) NOT NULL,
  address VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS items(
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(255) NOT NULL,
  price INT NOT NULL,
  store_id UUID NOT NULL,
  image_url VARCHAR(255),
  stock INT DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (store_id) REFERENCES stores(id) ON DELETE CASCADE
);

CREATE type transaction_status AS ENUM ('pending', 'paid');

CREATE TABLE IF NOT EXISTS transactions(
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL,
  item_id UUID NOT NULL,
  quantity INT NOT NULL,
  total INT NOT NULL,
  status transaction_status DEFAULT 'pending',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (item_id) REFERENCES items(id) ON DELETE CASCADE
);


INSERT INTO users (id, name, email, password, balance) VALUES ('fe546d66-d700-4098-9ec0-d055752c2376', 'Alice Johnson', 'alice@example.com', '$2b$12$MoVhtMKAX4A3S0TH81sHBu82dQYBKDM1LFEvAhjMdFmF2KrYQry3u', 1000);
INSERT INTO users (id, name, email, password, balance) VALUES ('3e26ab0a-df41-4299-ae35-57d5fd255a77', 'Bob Smith', 'bob@example.com', '$2b$12$3ejVXaeFvC2/NBD6WxxsZe0tRRBJzWsFgXKf6YC1DouZF7foFZCQW', 500);
INSERT INTO users (id, name, email, password, balance) VALUES ('7125d96a-5957-4490-926b-6473d4e6c59c', 'Charlie Brown', 'charlie@example.com', '$2b$12$ePn3NMZokV3nORT58wf4puw0gZgM.B4mglOIMyNtFi6zRzEySq.WG', 800);
INSERT INTO users (id, name, email, password, balance) VALUES ('31ac2218-8895-4b16-9077-ba87b91dd45d', 'David Wilson', 'david@example.com', '$2b$12$NeXL2KuFqpKzdstZk2IIzu/2isSPFwp0Jr2uHMtb9f7ZMoGKTxAkO', 1200);
INSERT INTO users (id, name, email, password, balance) VALUES ('8d83d070-25ae-40f2-ac50-6bacfda47709', 'Eve Davis', 'eve@example.com', '$2b$12$yNY8mNoiOoNWMI2M4jw0z.UvWyGvWvHJNdB591gjLrY7kzXTwQhNq', 700);
INSERT INTO users (id, name, email, password, balance) VALUES ('976bfefa-beaf-4871-960a-21a48d5574eb', 'Frank Miller', 'frank@example.com', '$2b$12$mhNIqIcag5Q9y.9PksxRAuH1yxpKTSUzv4hS764u6qIY2ADRPHfV2', 600);
INSERT INTO users (id, name, email, password, balance) VALUES ('ea2e0474-90ae-4405-bfd7-d3e52aa32c2c', 'Grace Lee', 'grace@example.com', '$2b$12$gaqwoHdkUmGh3JB3KV1Cf.6n9ZVcIu7doAdFSkjGRdOJOgxqCtFBC', 900);
INSERT INTO users (id, name, email, password, balance) VALUES ('94bdd443-f6cf-4469-a136-c3111054c153', 'Hank Green', 'hank@example.com', '$2b$12$lBV7mnf5E/zoc/TYR5I/T.pjzWCX7MMV.b0vZNq0WmmyO.XHFW3Zi', 1100);
INSERT INTO users (id, name, email, password, balance) VALUES ('f600472f-4008-4887-af9a-ba8e31c093f3', 'Ivy Carter', 'ivy@example.com', '$2b$12$aiGtePTZuTGJMkVL42wCiOHUYjuE4Ys8BTgJCVMTDrU8RolmJu8J6', 950);
INSERT INTO users (id, name, email, password, balance) VALUES ('8f24e4b4-8a16-48fb-a5ea-1973991e2224', 'Jack White', 'jack@example.com', '$2b$12$2oY4UMucr9TYso0fSi8GFOqVteZHkhNP0sXjTuQmTqZJbVs4DTSOm', 850);
INSERT INTO users (id, name, email, password, balance) VALUES ('624ce350-94b7-45f3-b1a1-ba1e11db0694', 'Karen Black', 'karen@example.com', '$2b$12$NBj81JS1BEgsJNsCJtie0e7dRwBi9wqIuJzayam1lgiYGGGzhLDgu', 1000);
INSERT INTO users (id, name, email, password, balance) VALUES ('59568fb6-fa64-48db-b915-c786a5b7a027', 'Leo King', 'leo@example.com', '$2b$12$l2NkD3Mpt40vKv279KRAquBx4EcANUjc0AmbO6Q6yNLOi8fCb/EXK', 750);
INSERT INTO users (id, name, email, password, balance) VALUES ('006e5315-334d-499d-a684-10a05fde3bb4', 'Mona Lisa', 'mona@example.com', '$2b$12$5w9m1eCyNFoZI7YjkAu9pelvKsNAZ2GB6uZJeGjMPJywCoxjRUAju', 1050);
INSERT INTO users (id, name, email, password, balance) VALUES ('73a04ea4-23a6-4ded-971f-690db09c88ce', 'Nina Brown', 'nina@example.com', '$2b$12$mUpFc/xKbWzPBQMD8lFdb.8cjW05y9aJ09lRvVCY2rAqo98SHfFL6', 980);
INSERT INTO users (id, name, email, password, balance) VALUES ('6ea951b0-853c-4ee5-988d-7aff8cf50eeb', 'Oscar Wilde', 'oscar@example.com', '$2b$12$4CqJmBJqrV/rl3Tut7/Age6AtqalWrujiDiNxIKTaAtFaWcf3L6LK', 870);
INSERT INTO users (id, name, email, password, balance) VALUES ('6071a684-b347-4993-8708-1d6e7221231b', 'Paul Newman', 'paul@example.com', '$2b$12$GE6a23AeCgRyxoQxdEaoXO1KmOA4yOIVmGzLjPsZ1j7RwPrxOZjuC', 920);
INSERT INTO users (id, name, email, password, balance) VALUES ('ae1e5d31-e0ee-4122-896b-959da6bea591', 'Quincy Adams', 'quincy@example.com', '$2b$12$pmtF8IQefmBVAN6wwTH.9uEXSunhG.t0bt6pU4bbwwk1vK92/WWAS', 890);
INSERT INTO users (id, name, email, password, balance) VALUES ('a744979d-cfb2-4238-8e89-572f2d42c625', 'Rachel Green', 'rachel@example.com', '$2b$12$EgBx5iaYYekzy6VJrsdQduoNVXuecObfwUJkLJxzCIXwAUbJ3ymMG', 970);
INSERT INTO users (id, name, email, password, balance) VALUES ('4c3b3222-188c-4767-9562-a4cabeefe95c', 'Steve Jobs', 'steve@example.com', '$2b$12$a8vDlxv/WYv./AnEL4aly.lRFSURiTrURG502zLTnj7pVkDF80B1K', 1020);
INSERT INTO users (id, name, email, password, balance) VALUES ('ca81230b-c514-4939-9c49-11a98beb10cb', 'Tracy Morgan', 'tracy@example.com', '$2b$12$t8JfpuzyKCf3SPxmKFri0e3oTxRhCxGzIVEXpLQWAW6q/VmCyJzjy', 940);
INSERT INTO users (id, name, email, password, balance) VALUES ('31f1c496-ad79-477c-9fb7-464012e6e556', 'Uma Thurman', 'uma@example.com', '$2b$12$x73PX1gR7/BV/IJklfDW/e9Kfa6rHPkoYupYGjR1lxLzCm6oNZqNi', 880);
INSERT INTO users (id, name, email, password, balance) VALUES ('9d5629b6-532b-4946-8942-aa7515b82a08', 'Victor Hugo', 'victor@example.com', '$2b$12$ymptTHXNdXiKF1VKHRAT4.dy/lTxjk5VuRFFWEAzi9GhieSveKmAO', 910);
INSERT INTO users (id, name, email, password, balance) VALUES ('5e716aab-9f94-40ab-9633-df384b3fe954', 'Wendy Darling', 'wendy@example.com', '$2b$12$WjG7Hgm7xOmaPx/5ZU./2uO6TCSs.gM/VO2qM7fKJgMzIRbMDWgWi', 860);
INSERT INTO users (id, name, email, password, balance) VALUES ('4e69e13d-020d-4f32-b828-40766f661ec5', 'Xander Cage', 'xander@example.com', '$2b$12$E25SV5K8vJAARca26vNqNeGQktsQtMxWhy8Wac1XQUzMgBgNZlAjK', 930);
INSERT INTO users (id, name, email, password, balance) VALUES ('13c509c0-0078-42c7-9340-14847449eb9e', 'Yara Shahidi', 'yara@example.com', '$2b$12$v3myEALcrpxp8CApV6r5KOCKhxyRkHDloHG63Vxk8XZahZl5sPAmK', 990);
INSERT INTO users (id, name, email, password, balance) VALUES ('1ac4e547-1702-4bf6-b2f8-ec03e5079925', 'Zane Grey', 'zane@example.com', '$2b$12$GNrdvnyNrvH/sLIPoumWzudC321So98FSopxxWNWuRDWlg75crv62', 870);
INSERT INTO users (id, name, email, password, balance) VALUES ('6ef69116-3bf9-4f49-9ce9-9e0ac1cdc778', 'Aaron Paul', 'aaron@example.com', '$2b$12$YzdzwSLvmbyjsHsox/Wzfu0kVNl9Fqk8WyOipdbt2jXQXJsdfBI5O', 950);
INSERT INTO users (id, name, email, password, balance) VALUES ('42d103ba-fd96-4bf9-be83-bb655bc2cc03', 'Bella Swan', 'bella@example.com', '$2b$12$s1lXkCviyIY6rGkhXJsm0eKbSLR3q97/nJ0GjLMw8/dd/UB5Ws5R.', 890);
INSERT INTO users (id, name, email, password, balance) VALUES ('d7c352f5-6a7d-4162-bac1-32a553b542aa', 'Cody Simpson', 'cody@example.com', '$2b$12$Fh70P5heGKy2tJ2VMp3MEOY1arZohm/TzqtT8nta4FMkdVHsZ3oXe', 920);
INSERT INTO users (id, name, email, password, balance) VALUES ('298e18a1-01d2-4208-bd0d-8b51a6025c5b', 'Diana Prince', 'diana@example.com', '$2b$12$nqKxYN3xs9z3I0R.Y994EeKz7XFpJMz34p.EGGF68NrHbYrh2FdF6', 970);
INSERT INTO users (id, name, email, password, balance) VALUES ('bb21a7a7-f16b-444d-b39f-4ba9dc05e642', 'Ethan Hunt', 'ethan@example.com', '$2b$12$i26ktJgQ8K6lU9xGmzhO4e6IL/RhwaTnbTCwH4KcJy7eMBKEP/T0W', 940);
INSERT INTO users (id, name, email, password, balance) VALUES ('1be44015-07bf-4267-bb32-ad195b32d9e6', 'Fiona Apple', 'fiona@example.com', '$2b$12$FNLM94aYFCzVuBBHUb1XDu8k6A1JdsyTGqt7AkCGtSvnIl/ygNlkq', 880);
INSERT INTO users (id, name, email, password, balance) VALUES ('657d3b45-47ec-48ee-9a2c-2c7f546c2185', 'George Clooney', 'george@example.com', '$2b$12$5BAPF1DxqJ54oO05C.DYUe7BCjZM9l.3W/Kuw.uF7.fTyzTdo3mGa', 910);
INSERT INTO users (id, name, email, password, balance) VALUES ('3e3c6463-7972-48e2-9e71-e3d130f1cb8f', 'Holly Golightly', 'holly@example.com', '$2b$12$uEJIqQ1NjhrqGOltLBsv1ON8xnMLJkpiIDRnKqr6Mei75lEThsDQq', 860);
INSERT INTO users (id, name, email, password, balance) VALUES ('d6037cf9-071a-4c8f-bc7f-f7bb5e14a041', 'Ian McKellen', 'ian@example.com', '$2b$12$hUTvLgOY36bzYmjzjE8BD.XOTcBOuE7bjEwVwQ4nLgvC99AVjXFW6', 930);
INSERT INTO users (id, name, email, password, balance) VALUES ('6cd00ebc-7879-4a7d-a662-94f0c0d8fa53', 'Jill Valentine', 'jill@example.com', '$2b$12$qJ6WfrcTA4Bdb3fs7yoprOQ3Kens5Xm.w0Y4neZQVV6RegznTmXhC', 990);
INSERT INTO users (id, name, email, password, balance) VALUES ('69004c61-4c6a-4996-b5c6-98f6c4259519', 'Kyle Reese', 'kyle@example.com', '$2b$12$lChp7/7HW.nJRRlsGBlqzeuV8rynLMeriYSBDgEa7Jnr7XXvZSeaS', 870);
INSERT INTO users (id, name, email, password, balance) VALUES ('5c154fd0-dd78-4edc-96b6-9a5cf58ee0db', 'Liam Neeson', 'liam@example.com', '$2b$12$btK2/5tmRGTB9W4TjptYPe5F0S8pSy4Bl7.KUb4lv8oJw3V3cA132', 950);
INSERT INTO users (id, name, email, password, balance) VALUES ('e86a0c88-1bec-4977-9e3f-559a007a8471', 'Mia Wallace', 'mia@example.com', '$2b$12$M6OeZpML3IFy/a8cL5ZZrO9F6vhKV2fWTYQeUGx3hZ4jq8e2AWSEO', 890);
INSERT INTO users (id, name, email, password, balance) VALUES ('aa3674d2-77aa-416e-9ff5-d7c20a7d7487', 'Nate Fisher', 'nate@example.com', '$2b$12$E1GDx1OmxflMAwDM/pFCQevvgZaIqcJy0TDR8hvqk6DZmXHAHyMx2', 920);
INSERT INTO users (id, name, email, password, balance) VALUES ('83871411-0644-4915-a35c-f6f39f66a1eb', 'Olivia Pope', 'olivia@example.com', '$2b$12$a2jBFW4.MxviBYf2wv806OmKaj0gwJ4uaE2YEJit2wozjC2UMl1Dy', 970);
INSERT INTO users (id, name, email, password, balance) VALUES ('04ae1631-daa7-425a-ae44-a82a7fe9d2ff', 'Pete Campbell', 'pete@example.com', '$2b$12$wIW/Hx4Q5a3AXzcZpbUewuxLjkxCfp2cwZfLPp8.HNLUwmyeM4d2.', 940);
INSERT INTO users (id, name, email, password, balance) VALUES ('f05c6808-4285-42f9-b9e8-15034cfdfbcb', 'Quinn Fabray', 'quinn@example.com', '$2b$12$wbTYccra1z/SBgzbZvEZpeKV.xnUwayZcsiPoLC4s0y.Gp2XqNtQC', 880);
INSERT INTO users (id, name, email, password, balance) VALUES ('00684f93-cc3c-402e-b40d-d5b7c4e1d60a', 'Rita Skeeter', 'rita@example.com', '$2b$12$IldFtW2ScDIQlV3OjTJlJuErhA4oJzjfphxnGCyT6WLOHDK55zHie', 910);
INSERT INTO users (id, name, email, password, balance) VALUES ('97c2dc08-84a4-40ca-9093-226171e52434', 'Sam Winchester', 'sam@example.com', '$2b$12$qw.Up5nB2gnac5d834J96eyaoHw5m.IQtNlKtH20R1ph3fspHSnoe', 860);
INSERT INTO users (id, name, email, password, balance) VALUES ('4a87049d-e505-4642-9883-6924d56af510', 'Tina Fey', 'tina@example.com', '$2b$12$Bbew7JiV9IcSUOkJTy7Y4.lcfHFPMbKDgM945aQbPICxMEZVjQBSG', 930);
INSERT INTO users (id, name, email, password, balance) VALUES ('402ea4dd-75ba-4e8a-bd04-a577ef605c55', 'Ursula Andress', 'ursula@example.com', '$2b$12$gMZ6fNG7ugd6cnp4vnkVvu1YVKH4aZEd6e81yyKRaisFskdy.GTOy', 990);
INSERT INTO users (id, name, email, password, balance) VALUES ('3e700130-167b-4fb5-8e08-321098ed20a1', 'Vince Vaughn', 'vince@example.com', '$2b$12$bSlDhIzsMaRxiBF6X8kTwefCA595hDTeGouv5nKSiAaHQma6UdBTm', 870);
INSERT INTO users (id, name, email, password, balance) VALUES ('9d3e9c15-bf9a-440b-883a-10fd5b30a3a4', 'Will Smith', 'will@example.com', '$2b$12$3Vq7zshQ72tYQjTeB.U8Ouqe5hin1hEGuI7J/GybUefUOHwMFtBsS', 950);
INSERT INTO users (id, name, email, password, balance) VALUES ('f228e72b-26a7-40fd-bd7f-58f4f6451af9', 'Xena Warrior', 'xena@example.com', '$2b$12$NcuvGEeesRzZzL3s9OoKbekVB1If4Ip/2DKXyHq2NZ7wDHxyTR4ya', 890);
INSERT INTO users (id, name, email, password, balance) VALUES ('445ba30c-96da-4fc8-bbbe-da89111e204d', 'Yvonne Strahovski', 'yvonne@example.com', '$2b$12$hJzj1gPNh1wvAm74lBypXuY5AEbSSgVfzuEZkJ5hbews7slJkYp.m', 920);
INSERT INTO users (id, name, email, password, balance) VALUES ('27bcd31a-093b-4927-9b5c-7976850b167d', 'Zack Morris', 'zack@example.com', '$2b$12$N0HkwU49hX0LIL5nFjbkv.YY0X1bGY9TLeQctQ2QXn7uNchLLH7xi', 970);
INSERT INTO stores (id, name, address) VALUES ('f27e54c7-9ff8-4fc8-a9b9-bf3c54d876d8', 'Tech Store', '123 Tech Street');
INSERT INTO stores (id, name, address) VALUES ('9322185a-e6d3-48b3-88ad-67cc1eb6747e', 'Book Haven', '456 Library Lane');
INSERT INTO stores (id, name, address) VALUES ('4ef61db5-c2ff-4e91-be13-abe7c73216f4', 'Fashion Outlet', '789 Style Avenue');
INSERT INTO stores (id, name, address) VALUES ('715c9b79-0e94-40d8-9d12-de2aa256f497', 'Home Goods', '321 Furnishings Road');
INSERT INTO stores (id, name, address) VALUES ('2c8dcf58-1671-4454-990d-5475262d0104', 'Pet Supplies', '654 Animal Drive');
INSERT INTO stores (id, name, address) VALUES ('209da321-1099-43f9-b4a7-e33d36315181', 'Sporting Goods', '987 Fitness Boulevard');
INSERT INTO stores (id, name, address) VALUES ('049c71a3-8d75-4333-8081-b55138844ca9', 'Music Shop', '135 Melody Lane');
INSERT INTO stores (id, name, address) VALUES ('67bb65ae-ce6e-4b88-a6bb-2c7ae442265a', 'Garden Center', '246 Greenhouse Court');
INSERT INTO stores (id, name, address) VALUES ('03dc7fb5-ead5-4318-9bfb-a200188aa4f6', 'Toy Store', '579 Playtime Plaza');
INSERT INTO stores (id, name, address) VALUES ('140326e0-8bfb-42fb-bf41-6f7cec2aeb25', 'Craft Shop', '753 Handmade Highway');
INSERT INTO stores (id, name, address) VALUES ('e3210309-1fba-456f-a2b5-2cfd20fec4a2', 'Gadget Hub', '852 Innovation Alley');
INSERT INTO stores (id, name, address) VALUES ('7c7e4bdc-e11c-461c-aa68-33fa15507852', 'Gaming Emporium', '963 Pixel Park');
INSERT INTO stores (id, name, address) VALUES ('a66fb752-ebf4-4a1b-b165-3c1117e7c19e', 'Office Essentials', '147 Workspace Way');
INSERT INTO stores (id, name, address) VALUES ('0532622c-1568-4a38-b124-05e5e3979b17', 'Kitchen Supplies', '369 Culinary Court');
INSERT INTO stores (id, name, address) VALUES ('173d0192-ab74-472f-b69c-ab78b4e4869f', 'Footwear Haven', '258 Sneaker Street');
INSERT INTO stores (id, name, address) VALUES ('5fb01952-3ce5-4d29-82c4-d61fdeaa9765', 'Appliance Depot', '741 Home Tech Drive');
INSERT INTO stores (id, name, address) VALUES ('db9db5fc-f129-48d0-82f9-9c31c96f8523', 'Fitness Store', '357 Strength Lane');
INSERT INTO stores (id, name, address) VALUES ('89adeeaf-c961-4c86-837e-e74cdf0c81e6', 'Outdoor Adventure', '159 Explorer Avenue');
INSERT INTO stores (id, name, address) VALUES ('5b2ccefb-1ca4-4533-921b-d80dbe4a07d6', 'Automotive Parts', '268 Auto Drive');
INSERT INTO stores (id, name, address) VALUES ('d2fd8647-1594-4632-b115-26e19ce1fb24', 'Luxury Boutique', '684 Prestige Plaza');
INSERT INTO stores (id, name, address) VALUES ('23d0c91a-eaaf-4586-b6db-419afb209da3', 'Pharmacy Plus', '951 Wellness Way');
INSERT INTO stores (id, name, address) VALUES ('3db5f6fb-832b-4d87-a785-6e58b9f7b74b', 'Eco Market', '753 Sustainable Square');
INSERT INTO stores (id, name, address) VALUES ('3e5f1659-ac03-4438-ba34-2eaea1c317e8', 'Watch & Jewelry', '357 Elegance Street');
INSERT INTO stores (id, name, address) VALUES ('f657e833-9a7a-48d2-9b76-80d81af39372', 'Stationery World', '864 Paper Lane');
INSERT INTO stores (id, name, address) VALUES ('2a2a98a2-2ba0-4706-98ef-619db222742f', 'Furniture Warehouse', '135 Cozy Corner');
INSERT INTO stores (id, name, address) VALUES ('134a6606-244e-48bb-9dda-dbfe3bfda4a4', 'Hiking Gear', '579 Mountain Trail');
INSERT INTO stores (id, name, address) VALUES ('77017eee-74c2-49ef-a236-db4902f26cd1', 'Electronics MegaStore', '753 Circuit Drive');
INSERT INTO stores (id, name, address) VALUES ('c4978448-c149-4bfb-899b-1430a32142bd', 'Wine & Spirits', '369 Vineyard Road');
INSERT INTO stores (id, name, address) VALUES ('8da5954c-3e2c-458b-aeae-4ca2eeb54001', 'Antique Treasures', '258 Vintage Way');
INSERT INTO stores (id, name, address) VALUES ('0bcb1b4f-8e91-472a-9cb2-5ab4d688933c', 'Board Game Café', '987 Strategy Street');
INSERT INTO stores (id, name, address) VALUES ('1f620afb-d107-462b-b806-203a909b9b1f', 'Bicycle Shop', '951 Pedal Plaza');
INSERT INTO stores (id, name, address) VALUES ('0bafab15-8475-496a-8658-dfb2ed4a6f98', 'Deli & Groceries', '684 Fresh Market');
INSERT INTO stores (id, name, address) VALUES ('6f4db460-e24d-4180-a6f2-3163c1f7c2db', 'Beauty & Skincare', '123 Glow Avenue');
INSERT INTO stores (id, name, address) VALUES ('8802241b-98dd-4b21-b96e-5c2913b7bcd6', 'Comic Book Store', '654 Hero Lane');
INSERT INTO stores (id, name, address) VALUES ('f4a5fb9f-dd61-4606-96e2-a237f323b737', 'VR & AR Experience', '369 Virtual Square');
INSERT INTO stores (id, name, address) VALUES ('6dc5d840-fd90-45f5-bc16-1f92ffc2f88c', 'Luggage & Travel', '258 Jetsetter Blvd');
INSERT INTO stores (id, name, address) VALUES ('f617d5d5-111e-4b78-aa8f-ff2701c100da', 'Art Gallery & Supplies', '147 Creative Road');
INSERT INTO stores (id, name, address) VALUES ('93a4cd56-d902-4846-a5ea-a7cc1d87a0d6', 'Tattoo & Piercing', '753 Ink Street');
INSERT INTO stores (id, name, address) VALUES ('1a827172-251a-4573-b114-2b41fbb4eb67', 'Car Wash & Accessories', '357 Shine Lane');
INSERT INTO stores (id, name, address) VALUES ('bcb3b9dd-2bb3-435f-a5e3-bc5e26278e50', 'Drone & RC Cars', '864 Aerial Way');
INSERT INTO stores (id, name, address) VALUES ('a3d03959-92ea-4348-a62f-1b9d5e46035b', 'Shoe Repair & Customization', '159 Fix-It Blvd');
INSERT INTO stores (id, name, address) VALUES ('ca652fbf-6303-4715-ba66-d4bec9bc22cf', 'Mens Grooming', '951 Barber Street');
INSERT INTO stores (id, name, address) VALUES ('870e91cb-9d31-4ad3-b299-42e0b347372f', 'Home Automation', '753 Smart Tech Avenue');
INSERT INTO stores (id, name, address) VALUES ('23816b2a-6da2-4180-8c15-35485bba1f21', 'Photography Studio', '321 Snapshot Lane');
INSERT INTO stores (id, name, address) VALUES ('c1460950-96b7-4973-b8fb-d66ccab7cc82', 'Perfume & Fragrance', '258 Aroma Boulevard');
INSERT INTO stores (id, name, address) VALUES ('b4f6c3c9-0baa-4d41-b043-a64ac029d3b3', 'Baby & Kids Store', '951 Little Wonders Street');
INSERT INTO stores (id, name, address) VALUES ('005e6184-5f4a-4f67-a7d7-3b62abba07e5', 'Farmers Market', '369 Organic Road');
INSERT INTO stores (id, name, address) VALUES ('cb31a0f2-119e-4766-b0c9-1ef6eda545df', 'Luxury Cars Showroom', '159 Prestige Drive');
INSERT INTO stores (id, name, address) VALUES ('f298a9e9-99ba-4168-b506-85481dd7a9ea', 'Tatami & Japanese Goods', '357 Sakura Avenue');
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('a539c043-fa56-47e4-bb89-80ab58fd2d6b', 'Laptop', 900, 'f27e54c7-9ff8-4fc8-a9b9-bf3c54d876d8', 'laptop.png', 10);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('8dac7861-4d6f-4e69-9f46-1e0d43a8b3db', 'Smartphone', 700, 'f27e54c7-9ff8-4fc8-a9b9-bf3c54d876d8', 'smartphone.png', 8);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('071b62aa-0b20-49bb-9c90-a8e29465f272', 'Wireless Headphones', 120, 'f27e54c7-9ff8-4fc8-a9b9-bf3c54d876d8', 'headphones.png', 18);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('364b43f1-6645-474f-a905-c487b9c39646', 'Programming Book', 40, '9322185a-e6d3-48b3-88ad-67cc1eb6747e', 'book.png', 50);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('0fb792c8-18e0-409e-9920-1348b1020ffe', 'Comic Book Collection', 25, '9322185a-e6d3-48b3-88ad-67cc1eb6747e', 'comicbook.png', 30);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('320d0636-eb29-45c8-9a5c-6461a4f51128', 'Designer Dress', 150, '4ef61db5-c2ff-4e91-be13-abe7c73216f4', 'dress.png', 20);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('6e3df909-f2ce-4f6a-9a99-d07812e6ec65', 'Running Shoes', 130, '4ef61db5-c2ff-4e91-be13-abe7c73216f4', 'shoes.png', 28);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('d4701bdf-b11c-4bf4-8c3d-5cb63e0b8c7a', 'Luxury Watch', 500, '4ef61db5-c2ff-4e91-be13-abe7c73216f4', 'watch.png', 5);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('9214ee17-b2c0-4158-8cdd-917b8fc13ad2', 'Sofa', 500, '715c9b79-0e94-40d8-9d12-de2aa256f497', 'sofa.png', 5);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('c1547c39-23e1-4c60-b59c-ac2758bc0a68', 'Dining Table', 750, '715c9b79-0e94-40d8-9d12-de2aa256f497', 'diningtable.png', 3);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('e22237d1-344a-401e-8dcc-e079b7012de6', 'Dog Food', 30, '2c8dcf58-1671-4454-990d-5475262d0104', 'dogfood.png', 100);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('6fa4c16f-8499-4995-ac59-2d212f1b62dd', 'Cat Scratching Post', 45, '2c8dcf58-1671-4454-990d-5475262d0104', 'scratchingpost.png', 20);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('fef421ce-c12a-4bf5-bd4c-61c36172d27b', 'Yoga Mat', 20, '209da321-1099-43f9-b4a7-e33d36315181', 'yogamat.png', 30);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('e6ff3b87-ee77-4a8f-9790-a60779b83525', 'Dumbbells Set', 90, '209da321-1099-43f9-b4a7-e33d36315181', 'dumbbells.png', 15);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('cebe5c27-baac-4f07-834d-ad14db90685d', 'Football', 25, '209da321-1099-43f9-b4a7-e33d36315181', 'football.png', 40);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('d8bc660e-e24f-430e-bf58-43b04f1ba48b', 'Guitar', 300, '049c71a3-8d75-4333-8081-b55138844ca9', 'guitar.png', 15);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('99e03d7c-af98-45d5-b597-da78a65cab18', 'Keyboard Synthesizer', 450, '049c71a3-8d75-4333-8081-b55138844ca9', 'synthesizer.png', 7);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('b735e080-ba40-491e-b72a-144d221d1ef5', 'Potted Plant', 10, '67bb65ae-ce6e-4b88-a6bb-2c7ae442265a', 'plant.png', 40);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('e3faa5e0-87f7-4d28-9e6b-778d6f74b9ff', 'Gardening Tools Set', 50, '67bb65ae-ce6e-4b88-a6bb-2c7ae442265a', 'gardentools.png', 15);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('08d02b40-ebb4-43ef-997b-2c16960a0c9e', 'Action Figure', 5, '03dc7fb5-ead5-4318-9bfb-a200188aa4f6', 'actionfigure.png', 200);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('26019041-83cf-45d4-88a7-7021ce92484e', 'Board Game', 30, '03dc7fb5-ead5-4318-9bfb-a200188aa4f6', 'boardgame.png', 35);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('5c075d0f-c58a-4174-a489-576a531291e2', 'Paint Set', 25, '140326e0-8bfb-42fb-bf41-6f7cec2aeb25', 'paintset.png', 25);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('9bb0543c-b965-4e3d-818c-bb1a9447715f', 'Sketchbook', 15, '140326e0-8bfb-42fb-bf41-6f7cec2aeb25', 'sketchbook.png', 50);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('b0514f27-4f88-47d2-a662-0c02b0c38254', 'Gaming Mouse', 60, 'e3210309-1fba-456f-a2b5-2cfd20fec4a2', 'mouse.png', 35);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('8a93c799-3e70-4ac9-bb55-770fe51c55f3', 'Mechanical Keyboard', 120, 'e3210309-1fba-456f-a2b5-2cfd20fec4a2', 'keyboard.png', 18);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('79a2d804-16db-416e-ab3d-52c15336432b', 'Office Chair', 220, '7c7e4bdc-e11c-461c-aa68-33fa15507852', 'chair.png', 12);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('7b499276-5bcc-4daf-9b4c-198a2ad36478', 'Standing Desk', 400, '7c7e4bdc-e11c-461c-aa68-33fa15507852', 'standingdesk.png', 8);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('8f9df3d1-52a0-4048-aa43-31a5e7395d33', 'Cookware Set', 85, 'a66fb752-ebf4-4a1b-b165-3c1117e7c19e', 'cookware.png', 22);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('2e3e6bac-657c-400e-890b-7b0100af2ef2', 'Chefs Knife', 55, 'a66fb752-ebf4-4a1b-b165-3c1117e7c19e', 'knife.png', 25);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('faa2f148-08f9-4389-ba35-e82f9c54384e', 'Bluetooth Speaker', 75, '0532622c-1568-4a38-b124-05e5e3979b17', 'speaker.png', 20);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('284a4c71-cb70-4a72-8b5d-5fee28f4aaf0', 'Smartwatch', 250, '0532622c-1568-4a38-b124-05e5e3979b17', 'smartwatch.png', 15);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('f8c39b9b-8305-4b90-9b0e-f6399aee9a9b', 'Car Tire Set', 600, '173d0192-ab74-472f-b69c-ab78b4e4869f', 'cartire.png', 10);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('34c90ac7-5eb3-4e3a-8d12-89af3123391c', 'Car Phone Mount', 20, '173d0192-ab74-472f-b69c-ab78b4e4869f', 'phonemount.png', 30);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('ce68f6a9-873e-4fb9-8acc-5510f6d27a0b', 'Perfume', 80, '5fb01952-3ce5-4d29-82c4-d61fdeaa9765', 'perfume.png', 40);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('5fa18465-c825-4143-95ee-d25fe28d1e45', 'Luxury Handbag', 950, '5fb01952-3ce5-4d29-82c4-d61fdeaa9765', 'handbag.png', 5);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('859cab73-d1b7-4eff-81a0-14e6aacad7d5', 'VR Headset', 350, 'db9db5fc-f129-48d0-82f9-9c31c96f8523', 'vrheadset.png', 10);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('97578af9-4cf1-46f6-9fe9-08808f409337', 'Electric Scooter', 800, '89adeeaf-c961-4c86-837e-e74cdf0c81e6', 'scooter.png', 5);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('3ea9dce0-4b7a-4a78-b4db-63557c538a72', 'Bicycle', 500, '89adeeaf-c961-4c86-837e-e74cdf0c81e6', 'bicycle.png', 10);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('fe4dba97-cfee-4b02-8f4d-a347f56804cc', 'Telescope', 400, '5b2ccefb-1ca4-4533-921b-d80dbe4a07d6', 'telescope.png', 8);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('6d5d5d81-ae3d-431d-b52e-8d9232c61a12', 'Microscope Kit', 250, '5b2ccefb-1ca4-4533-921b-d80dbe4a07d6', 'microscope.png', 12);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('59337edd-204b-40d5-85a1-5329b9772b3b', 'Tent', 150, 'd2fd8647-1594-4632-b115-26e19ce1fb24', 'tent.png', 15);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('28dbcc6f-d1b4-48e3-8b9e-9cdbe5d2a09d', 'Camping Stove', 75, 'd2fd8647-1594-4632-b115-26e19ce1fb24', 'campstove.png', 20);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('25a85c56-d26c-42fc-b64b-49fb873ab833', 'Tatami Mat', 60, '23d0c91a-eaaf-4586-b6db-419afb209da3', 'tatami.png', 25);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('69cfaaf7-d72e-45c5-a823-286f3516a037', 'Samurai Sword Replica', 300, '23d0c91a-eaaf-4586-b6db-419afb209da3', 'katana.png', 5);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('18cb7e69-6912-4416-8b9f-0a0ca7faf08a', 'Wine Bottle Set', 120, '3db5f6fb-832b-4d87-a785-6e58b9f7b74b', 'wine.png', 10);
INSERT INTO items (id, name, price, store_id, image_url, stock) VALUES ('75fb29cd-8857-4296-8ce1-8676715e5eca', 'Gourmet Coffee Beans', 40, '3e5f1659-ac03-4438-ba34-2eaea1c317e8', 'coffee.png', 30);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('0a803de7-92e2-449c-ac32-f8a8f0bcb97f', 'fe546d66-d700-4098-9ec0-d055752c2376', 'a539c043-fa56-47e4-bb89-80ab58fd2d6b', 1, 900);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('ca6371e1-ee1a-43c5-886f-66061d8826a6', '3e26ab0a-df41-4299-ae35-57d5fd255a77', '8dac7861-4d6f-4e69-9f46-1e0d43a8b3db', 1, 700);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('7b1eaee4-28f7-432d-8ce2-22ef9001b2bf', '7125d96a-5957-4490-926b-6473d4e6c59c', '071b62aa-0b20-49bb-9c90-a8e29465f272', 1, 120);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('db91971e-4ee9-4571-9344-dc96961caec5', '31ac2218-8895-4b16-9077-ba87b91dd45d', '364b43f1-6645-474f-a905-c487b9c39646', 1, 40);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('0d594702-d4c9-4a5c-a9c7-93e409636033', '8d83d070-25ae-40f2-ac50-6bacfda47709', '0fb792c8-18e0-409e-9920-1348b1020ffe', 1, 25);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('3619e4a5-8d6f-4e27-b80c-5dda7e2ff9b3', '976bfefa-beaf-4871-960a-21a48d5574eb', '320d0636-eb29-45c8-9a5c-6461a4f51128', 1, 150);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('b5133f6c-2aac-439e-8b10-71ba63f152aa', 'ea2e0474-90ae-4405-bfd7-d3e52aa32c2c', '6e3df909-f2ce-4f6a-9a99-d07812e6ec65', 1, 130);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('3a722d84-2ebf-4700-8cdc-7406521915f6', '94bdd443-f6cf-4469-a136-c3111054c153', 'd4701bdf-b11c-4bf4-8c3d-5cb63e0b8c7a', 1, 500);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('d7abd82a-3040-4cdc-a274-937369acc18b', 'f600472f-4008-4887-af9a-ba8e31c093f3', '9214ee17-b2c0-4158-8cdd-917b8fc13ad2', 1, 500);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('68a28a51-0169-41b2-acc3-e87e9b922780', '8f24e4b4-8a16-48fb-a5ea-1973991e2224', 'c1547c39-23e1-4c60-b59c-ac2758bc0a68', 1, 750);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('b2d32796-7a99-4c14-afa3-64df3faacd02', '624ce350-94b7-45f3-b1a1-ba1e11db0694', 'e22237d1-344a-401e-8dcc-e079b7012de6', 1, 30);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('2c2e0697-9df6-49dc-a1a1-8d0609b3ad30', '59568fb6-fa64-48db-b915-c786a5b7a027', '6fa4c16f-8499-4995-ac59-2d212f1b62dd', 1, 45);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('0e9fff1f-132b-4fac-9b36-f6b3b8ec8859', '006e5315-334d-499d-a684-10a05fde3bb4', 'fef421ce-c12a-4bf5-bd4c-61c36172d27b', 1, 20);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('e97a64f8-f85a-47ae-ad51-27adfde23171', '73a04ea4-23a6-4ded-971f-690db09c88ce', 'e6ff3b87-ee77-4a8f-9790-a60779b83525', 1, 90);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('8d023328-2955-4b02-9371-2cdc0d821e95', '6ea951b0-853c-4ee5-988d-7aff8cf50eeb', 'cebe5c27-baac-4f07-834d-ad14db90685d', 1, 25);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('4dbe9331-22d6-4e9b-80dc-d2d2ec0ee019', '6071a684-b347-4993-8708-1d6e7221231b', 'd8bc660e-e24f-430e-bf58-43b04f1ba48b', 1, 300);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('1300578a-edd8-4455-9088-9ae8e951e73f', 'ae1e5d31-e0ee-4122-896b-959da6bea591', '99e03d7c-af98-45d5-b597-da78a65cab18', 1, 450);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('15ea8357-89ec-47cb-a23f-1cbf9d7c92e0', 'a744979d-cfb2-4238-8e89-572f2d42c625', 'b735e080-ba40-491e-b72a-144d221d1ef5', 1, 10);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('31aa39e5-aa58-4f16-801e-856dc79a1cfb', '4c3b3222-188c-4767-9562-a4cabeefe95c', 'e3faa5e0-87f7-4d28-9e6b-778d6f74b9ff', 1, 50);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('4d1e6d75-7e90-4b1d-91cd-3134fe016f26', 'ca81230b-c514-4939-9c49-11a98beb10cb', '08d02b40-ebb4-43ef-997b-2c16960a0c9e', 1, 5);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('bb18b1b9-1fbe-4fbe-92b2-f91e72b55efb', '31f1c496-ad79-477c-9fb7-464012e6e556', '26019041-83cf-45d4-88a7-7021ce92484e', 1, 30);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('9f14f751-fc0c-4e97-8602-2c56e9b2755e', '9d5629b6-532b-4946-8942-aa7515b82a08', '5c075d0f-c58a-4174-a489-576a531291e2', 1, 25);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('6f995425-ada4-479b-a9ca-fe5485aebd43', '5e716aab-9f94-40ab-9633-df384b3fe954', '9bb0543c-b965-4e3d-818c-bb1a9447715f', 1, 15);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('980a154f-1621-401e-af56-f2176d9163fd', '4e69e13d-020d-4f32-b828-40766f661ec5', 'b0514f27-4f88-47d2-a662-0c02b0c38254', 1, 60);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('26e9e794-959b-4f30-8178-790ed7408112', '13c509c0-0078-42c7-9340-14847449eb9e', '8a93c799-3e70-4ac9-bb55-770fe51c55f3', 1, 120);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('8bd94039-ff7f-4a9c-a559-401d4d6750c6', '1ac4e547-1702-4bf6-b2f8-ec03e5079925', '79a2d804-16db-416e-ab3d-52c15336432b', 1, 220);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('744022e6-e553-495e-b628-ea769ec74eab', '6ef69116-3bf9-4f49-9ce9-9e0ac1cdc778', '7b499276-5bcc-4daf-9b4c-198a2ad36478', 1, 400);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('f3cc1545-b545-4a43-961f-9bb5579494c6', '42d103ba-fd96-4bf9-be83-bb655bc2cc03', '8f9df3d1-52a0-4048-aa43-31a5e7395d33', 1, 85);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('c228676b-e7bf-429a-b978-b1fbcea70ba9', 'd7c352f5-6a7d-4162-bac1-32a553b542aa', '2e3e6bac-657c-400e-890b-7b0100af2ef2', 1, 55);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('c25bb084-b462-42ee-b13f-b628a1604eb2', '298e18a1-01d2-4208-bd0d-8b51a6025c5b', 'faa2f148-08f9-4389-ba35-e82f9c54384e', 1, 75);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('be6ce5bb-67d8-414e-b184-15c3687f7416', 'bb21a7a7-f16b-444d-b39f-4ba9dc05e642', '284a4c71-cb70-4a72-8b5d-5fee28f4aaf0', 1, 250);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('09ae5d80-d75e-4585-9f75-19651b7a4fcd', '1be44015-07bf-4267-bb32-ad195b32d9e6', 'f8c39b9b-8305-4b90-9b0e-f6399aee9a9b', 1, 600);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('237980a3-77d5-4f91-b073-5ba98f8c6624', '657d3b45-47ec-48ee-9a2c-2c7f546c2185', '34c90ac7-5eb3-4e3a-8d12-89af3123391c', 1, 20);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('d5af7133-07b9-48d0-a498-918f75394b5a', '3e3c6463-7972-48e2-9e71-e3d130f1cb8f', 'ce68f6a9-873e-4fb9-8acc-5510f6d27a0b', 1, 80);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('edb7e1aa-0e7b-4eb1-9ab9-6c75a34548ae', 'd6037cf9-071a-4c8f-bc7f-f7bb5e14a041', '5fa18465-c825-4143-95ee-d25fe28d1e45', 1, 950);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('2c1db7bb-a737-478c-befe-1b95ef7e7b1f', '6cd00ebc-7879-4a7d-a662-94f0c0d8fa53', '859cab73-d1b7-4eff-81a0-14e6aacad7d5', 1, 350);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('1a28158b-e1dc-43ca-8688-ff0a87ef7969', '69004c61-4c6a-4996-b5c6-98f6c4259519', '97578af9-4cf1-46f6-9fe9-08808f409337', 1, 800);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('057350d7-2ff6-4023-a633-c656bbaba4e0', '5c154fd0-dd78-4edc-96b6-9a5cf58ee0db', '3ea9dce0-4b7a-4a78-b4db-63557c538a72', 1, 500);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('25e3188c-049e-453f-9f2a-63174c0cbb15', 'e86a0c88-1bec-4977-9e3f-559a007a8471', 'fe4dba97-cfee-4b02-8f4d-a347f56804cc', 1, 400);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('3f50a588-0bd7-4462-b9c6-c27b421cf48e', 'aa3674d2-77aa-416e-9ff5-d7c20a7d7487', '6d5d5d81-ae3d-431d-b52e-8d9232c61a12', 1, 250);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('d4356a42-e835-48f5-b5d6-355cc7dce99f', '83871411-0644-4915-a35c-f6f39f66a1eb', '59337edd-204b-40d5-85a1-5329b9772b3b', 1, 150);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('b490e05c-b316-47ca-bb48-bb058a110941', '04ae1631-daa7-425a-ae44-a82a7fe9d2ff', '28dbcc6f-d1b4-48e3-8b9e-9cdbe5d2a09d', 1, 75);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('9866ea11-1d43-4da0-b42f-f9ec198f58b4', 'f05c6808-4285-42f9-b9e8-15034cfdfbcb', '25a85c56-d26c-42fc-b64b-49fb873ab833', 1, 60);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('f0d8b2c7-373a-4430-ab3d-1d23bd718140', '00684f93-cc3c-402e-b40d-d5b7c4e1d60a', '69cfaaf7-d72e-45c5-a823-286f3516a037', 1, 300);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('834fd921-c533-425b-8305-e260d99aae25', '97c2dc08-84a4-40ca-9093-226171e52434', '18cb7e69-6912-4416-8b9f-0a0ca7faf08a', 1, 120);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('ecea07d2-b173-4732-9054-5a6393ddc08a', '4a87049d-e505-4642-9883-6924d56af510', '75fb29cd-8857-4296-8ce1-8676715e5eca', 1, 40);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('bd666024-0415-4b09-a325-9ba00d9cc08a', '402ea4dd-75ba-4e8a-bd04-a577ef605c55', 'a539c043-fa56-47e4-bb89-80ab58fd2d6b', 1, 900);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('96834f54-23e5-454f-8c9b-a51f71b8c02c', '3e700130-167b-4fb5-8e08-321098ed20a1', '8dac7861-4d6f-4e69-9f46-1e0d43a8b3db', 1, 700);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('e6821e74-452b-4a8e-9289-549f67506d45', '9d3e9c15-bf9a-440b-883a-10fd5b30a3a4', '071b62aa-0b20-49bb-9c90-a8e29465f272', 1, 120);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('108caa6d-3a1c-4620-bba2-f215457d24b2', 'f228e72b-26a7-40fd-bd7f-58f4f6451af9', '364b43f1-6645-474f-a905-c487b9c39646', 1, 40);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('faef024c-4c9c-4604-a8f6-9541fc702431', '445ba30c-96da-4fc8-bbbe-da89111e204d', '0fb792c8-18e0-409e-9920-1348b1020ffe', 1, 25);
INSERT INTO transactions (id, user_id, item_id, quantity, total) VALUES ('c60b656d-b864-4cb6-b701-dd06d526c663', '27bcd31a-093b-4927-9b5c-7976850b167d', '320d0636-eb29-45c8-9a5c-6461a4f51128', 1, 150);