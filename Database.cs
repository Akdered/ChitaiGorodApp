using System;
using System.Collections.Generic;
using Npgsql;

namespace ChitaiGorodApp
{
    public static class Database
    {
        
        public static string ConnStr = "Host=localhost;Port=5432;Database=UP_Ushkova;Username=postgres;Password=postgres";

        public static User? Authenticate(string login, string password)
        {
            using var conn = new NpgsqlConnection(ConnStr);
            conn.Open();
            string sql = @"
                SELECT u.""id_Пользователей"", u.""id_Роли"", r.""Роль сотрудника"", u.""ФИО"", u.""Логин""
                FROM users u
                JOIN roles r ON u.""id_Роли"" = r.""id_Роли""
                WHERE u.""Логин"" = @login AND u.""Пароль"" = @pass";

            using var cmd = new NpgsqlCommand(sql, conn);
            cmd.Parameters.AddWithValue("login", login);
            cmd.Parameters.AddWithValue("pass", password);

            using var reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                return new User
                {
                    Id = reader.GetInt32(0),
                    RoleId = reader.GetInt32(1),
                    RoleName = reader.GetString(2),
                    FullName = reader.GetString(3),
                    Login = reader.GetString(4)
                };
            }
            return null;
        }

        public static List<Product> GetProducts()
        {
            var list = new List<Product>();
            using var conn = new NpgsqlConnection(ConnStr);
            conn.Open();
            string sql = @"
                SELECT p.""id_Товара"", p.""Артикул"", p.""Наименование товара"",
                       p.""id_ЕдИзм"", u.""Единица измерения"",
                       p.""Цена"",
                       p.""id_Поставщика"", s.""Поставщик"",
                       p.""id_Производителя"", m.""Производитель"",
                       p.""id_Категории"", c.""Категория товара"",
                       p.""Действующая скидка"", p.""Кол-во на складе"",
                       p.""Описание товара"", p.""Фото""
                FROM products p
                JOIN units u ON p.""id_ЕдИзм"" = u.""id_ЕдИзм""
                JOIN suppliers s ON p.""id_Поставщика"" = s.""id_Поставщика""
                JOIN manufacturers m ON p.""id_Производителя"" = m.""id_Производителя""
                JOIN categories c ON p.""id_Категории"" = c.""id_Категории""
                ORDER BY p.""id_Товара""";

            using var cmd = new NpgsqlCommand(sql, conn);
            using var r = cmd.ExecuteReader();
            while (r.Read())
            {
                list.Add(new Product
                {
                    Id = r.GetInt32(0),
                    Article = r.GetString(1),
                    Name = r.GetString(2),
                    UnitId = r.GetInt32(3),
                    UnitName = r.GetString(4),
                    Price = r.GetDecimal(5),
                    SupplierId = r.GetInt32(6),
                    SupplierName = r.GetString(7),
                    ManufacturerId = r.GetInt32(8),
                    ManufacturerName = r.GetString(9),
                    CategoryId = r.GetInt32(10),
                    CategoryName = r.GetString(11),
                    Discount = r.GetInt32(12),
                    StockQuantity = r.GetInt32(13),
                    Description = r.IsDBNull(14) ? null : r.GetString(14),
                    PhotoFileName = r.IsDBNull(15) ? null : r.GetString(15)
                });
            }
            return list;
        }

        public static List<LookupItem> GetLookup(string table, string idCol, string nameCol)
        {
            var list = new List<LookupItem>();
            using var conn = new NpgsqlConnection(ConnStr);
            conn.Open();
            string sql = $@"SELECT ""{idCol}"", ""{nameCol}"" FROM {table} ORDER BY ""{nameCol}""";
            using var cmd = new NpgsqlCommand(sql, conn);
            using var r = cmd.ExecuteReader();
            while (r.Read())
            {
                list.Add(new LookupItem { Id = r.GetInt32(0), Name = r.GetString(1).Trim() });
            }
            return list;
        }

        public static int GetNextProductId()
        {
            using var conn = new NpgsqlConnection(ConnStr);
            conn.Open();
            using var cmd = new NpgsqlCommand(@"SELECT COALESCE(MAX(""id_Товара""), 0) + 1 FROM products", conn);
            return Convert.ToInt32(cmd.ExecuteScalar());
        }

        public static void SaveProduct(Product p, bool isNew)
        {
            using var conn = new NpgsqlConnection(ConnStr);
            conn.Open();
            string sql = isNew
                ? @"INSERT INTO products (""Артикул"", ""Наименование товара"", ""id_ЕдИзм"", ""Цена"", ""id_Поставщика"", ""id_Производителя"", ""id_Категории"", ""Действующая скидка"", ""Кол-во на складе"", ""Описание товара"", ""Фото"")
                    VALUES (@art, @name, @unit, @price, @sup, @man, @cat, @disc, @stock, @desc, @photo)"
                : @"UPDATE products SET
                        ""Артикул"" = @art,
                        ""Наименование товара"" = @name,
                        ""id_ЕдИзм"" = @unit,
                        ""Цена"" = @price,
                        ""id_Поставщика"" = @sup,
                        ""id_Производителя"" = @man,
                        ""id_Категории"" = @cat,
                        ""Действующая скидка"" = @disc,
                        ""Кол-во на складе"" = @stock,
                        ""Описание товара"" = @desc,
                        ""Фото"" = @photo
                    WHERE ""id_Товара"" = @id";

            using var cmd = new NpgsqlCommand(sql, conn);
            if (!isNew) cmd.Parameters.AddWithValue("id", p.Id);
            cmd.Parameters.AddWithValue("art", p.Article);
            cmd.Parameters.AddWithValue("name", p.Name);
            cmd.Parameters.AddWithValue("unit", p.UnitId);
            cmd.Parameters.AddWithValue("price", p.Price);
            cmd.Parameters.AddWithValue("sup", p.SupplierId);
            cmd.Parameters.AddWithValue("man", p.ManufacturerId);
            cmd.Parameters.AddWithValue("cat", p.CategoryId);
            cmd.Parameters.AddWithValue("disc", p.Discount);
            cmd.Parameters.AddWithValue("stock", p.StockQuantity);
            cmd.Parameters.AddWithValue("desc", (object?)p.Description ?? DBNull.Value);
            cmd.Parameters.AddWithValue("photo", (object?)p.PhotoFileName ?? DBNull.Value);
            cmd.ExecuteNonQuery();
        }

        public static bool IsProductInOrders(int productId)
        {
            using var conn = new NpgsqlConnection(ConnStr);
            conn.Open();
            using var cmd = new NpgsqlCommand(@"SELECT COUNT(*) FROM order_items WHERE ""id_Товара"" = @id", conn);
            cmd.Parameters.AddWithValue("id", productId);
            return Convert.ToInt64(cmd.ExecuteScalar()) > 0;
        }

        public static void DeleteProduct(int productId)
        {
            using var conn = new NpgsqlConnection(ConnStr);
            conn.Open();
            using var cmd = new NpgsqlCommand(@"DELETE FROM products WHERE ""id_Товара"" = @id", conn);
            cmd.Parameters.AddWithValue("id", productId);
            cmd.ExecuteNonQuery();
        }

        public static List<Order> GetOrders()
        {
            var list = new List<Order>();
            using var conn = new NpgsqlConnection(ConnStr);
            conn.Open();
            string sql = @"
                SELECT o.""id_Заказа"", o.""Дата заказа"", o.""Дата доставки"",
                       o.""Адрес пункта выдачи"", pp.""Адрес"",
                       o.""id_Пользователей"", u.""ФИО"",
                       o.""Код для получения"",
                       o.""id_СтатусЗаказа"", os.""Статус заказа"",
                       COALESCE((
                           SELECT string_agg(p.""Артикул"" || ' (' || oi.""Количество"" || ' шт.)', ', ')
                           FROM order_items oi
                           JOIN products p ON oi.""id_Товара"" = p.""id_Товара""
                           WHERE oi.""id_Заказа"" = o.""id_Заказа""
                       ), 'Нет позиций') AS articles
                FROM ""order"" o
                JOIN pickup_points pp ON o.""Адрес пункта выдачи"" = pp.""id_Адрес""
                JOIN users u ON o.""id_Пользователей"" = u.""id_Пользователей""
                JOIN order_statuses os ON o.""id_СтатусЗаказа"" = os.""id_Заказа""
                ORDER BY o.""id_Заказа""";

            using var cmd = new NpgsqlCommand(sql, conn);
            using var r = cmd.ExecuteReader();
            while (r.Read())
            {
                list.Add(new Order
                {
                    Id = r.GetInt32(0),
                    OrderDate = r.GetDateTime(1),
                    DeliveryDate = r.GetDateTime(2),
                    PickupPointId = r.GetInt32(3),
                    PickupAddress = r.GetString(4),
                    UserId = r.GetInt32(5),
                    ClientFullName = r.GetString(6),
                    ReceiveCode = r.GetInt32(7),
                    StatusId = r.GetInt32(8),
                    StatusName = r.GetString(9).Trim(),
                    ArticlesSummary = r.GetString(10)
                });
            }
            return list;
        }

        public static void SaveOrder(Order o, bool isNew)
        {
            using var conn = new NpgsqlConnection(ConnStr);
            conn.Open();
            string sql = isNew
                ? @"INSERT INTO ""order"" (""Дата заказа"", ""Дата доставки"", ""Адрес пункта выдачи"", ""id_Пользователей"", ""Код для получения"", ""id_СтатусЗаказа"")
                    VALUES (@odate, @ddate, @pp, @uid, @code, @status)"
                : @"UPDATE ""order"" SET
                        ""Дата заказа"" = @odate,
                        ""Дата доставки"" = @ddate,
                        ""Адрес пункта выдачи"" = @pp,
                        ""id_Пользователей"" = @uid,
                        ""Код для получения"" = @code,
                        ""id_СтатусЗаказа"" = @status
                    WHERE ""id_Заказа"" = @id";

            using var cmd = new NpgsqlCommand(sql, conn);
            if (!isNew) cmd.Parameters.AddWithValue("id", o.Id);
            cmd.Parameters.AddWithValue("odate", o.OrderDate.Date);
            cmd.Parameters.AddWithValue("ddate", o.DeliveryDate);
            cmd.Parameters.AddWithValue("pp", o.PickupPointId);
            cmd.Parameters.AddWithValue("uid", o.UserId);
            cmd.Parameters.AddWithValue("code", o.ReceiveCode);
            cmd.Parameters.AddWithValue("status", o.StatusId);
            cmd.ExecuteNonQuery();
        }

        public static void DeleteOrder(int orderId)
        {
            using var conn = new NpgsqlConnection(ConnStr);
            conn.Open();
            using var cmd = new NpgsqlCommand(@"DELETE FROM ""order"" WHERE ""id_Заказа"" = @id", conn);
            cmd.Parameters.AddWithValue("id", orderId);
            cmd.ExecuteNonQuery();
        }
    }
}