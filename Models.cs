using System;
using System.IO;
using System.Windows;
using System.Windows.Media;
using System.Windows.Media.Imaging;

namespace ChitaiGorodApp
{
    public class User
    {
        public int Id { get; set; }
        public int RoleId { get; set; }
        public string RoleName { get; set; } = "";
        public string FullName { get; set; } = "";
        public string Login { get; set; } = "";
    }

    public class LookupItem
    {
        public int Id { get; set; }
        public string Name { get; set; } = "";
        public override string ToString() => Name;
    }

    public class Product
    {
        public int Id { get; set; }
        public string Article { get; set; } = "";
        public string Name { get; set; } = "";
        public int UnitId { get; set; }
        public string UnitName { get; set; } = "";
        public decimal Price { get; set; }
        public int SupplierId { get; set; }
        public string SupplierName { get; set; } = "";
        public int ManufacturerId { get; set; }
        public string ManufacturerName { get; set; } = "";
        public int CategoryId { get; set; }
        public string CategoryName { get; set; } = "";
        public int Discount { get; set; }
        public int StockQuantity { get; set; }
        public string? Description { get; set; }
        public string? PhotoFileName { get; set; }

        public string DescriptionDisplay => string.IsNullOrWhiteSpace(Description) ? "Описание товара: отсутствует" : $"Описание товара: {Description}";

        public bool HasDiscount => Discount > 0;
        public decimal FinalPrice => Math.Round(Price * (100 - Discount) / 100m, 2);

        public Visibility OldPriceVisibility => HasDiscount ? Visibility.Visible : Visibility.Collapsed;
        public string PriceDisplay => HasDiscount ? $"{FinalPrice:N2} руб." : $"{Price:N2} руб.";
        public string OldPriceDisplay => $"{Price:N2} руб.";

        public Brush RowBackground
        {
            get
            {
                if (StockQuantity <= 0)
                    return new SolidColorBrush(Colors.LightGray);
                if (Discount > 25)
                    return (SolidColorBrush)new BrushConverter().ConvertFrom("#23E1EF")!;
                return Brushes.White;
            }
        }

        public ImageSource ProductImage
        {
            get
            {
                string baseDir = AppDomain.CurrentDomain.BaseDirectory;
                string? targetPath = null;

                if (!string.IsNullOrWhiteSpace(PhotoFileName))
                {
                    string cleanName = PhotoFileName.Trim();
                    string candidate1 = Path.Combine(baseDir, "Images", cleanName);
                    string candidate2 = Path.Combine(baseDir, cleanName);
                    if (File.Exists(candidate1)) targetPath = candidate1;
                    else if (File.Exists(candidate2)) targetPath = candidate2;
                    else
                    {
                        string projectDir = Path.GetFullPath(Path.Combine(baseDir, "..", "..", ".."));
                        string candidate3 = Path.Combine(projectDir, "Images", cleanName);
                        string candidate4 = Path.Combine(projectDir, cleanName);
                        if (File.Exists(candidate3)) targetPath = candidate3;
                        else if (File.Exists(candidate4)) targetPath = candidate4;
                    }
                }

                if (targetPath == null)
                {
                    string fallback = Path.Combine(baseDir, "picture.png");
                    if (File.Exists(fallback)) targetPath = fallback;
                    else
                    {
                        string projectFallback = Path.GetFullPath(Path.Combine(baseDir, "..", "..", "..", "picture.png"));
                        if (File.Exists(projectFallback)) targetPath = projectFallback;
                    }
                }

                if (targetPath == null) return null!;

                try
                {
                    var bitmap = new BitmapImage();
                    bitmap.BeginInit();
                    bitmap.CacheOption = BitmapCacheOption.OnLoad;
                    bitmap.UriSource = new Uri(targetPath, UriKind.Absolute);
                    bitmap.EndInit();
                    bitmap.Freeze();
                    return bitmap;
                }
                catch
                {
                    try
                    {
                        string fallback = Path.Combine(baseDir, "picture.png");
                        if (!File.Exists(fallback))
                            fallback = Path.GetFullPath(Path.Combine(baseDir, "..", "..", "..", "picture.png"));

                        if (File.Exists(fallback) && targetPath != fallback)
                        {
                            var fb = new BitmapImage();
                            fb.BeginInit();
                            fb.CacheOption = BitmapCacheOption.OnLoad;
                            fb.UriSource = new Uri(fallback, UriKind.Absolute);
                            fb.EndInit();
                            fb.Freeze();
                            return fb;
                        }
                    }
                    catch { }

                    return null!;
                }
            }
        }
    }

    public class Order
    {
        public int Id { get; set; }
        public DateTime OrderDate { get; set; }
        public DateTime DeliveryDate { get; set; }
        public int PickupPointId { get; set; }
        public string PickupAddress { get; set; } = "";
        public int UserId { get; set; }
        public string ClientFullName { get; set; } = "";
        public int ReceiveCode { get; set; }
        public int StatusId { get; set; }
        public string StatusName { get; set; } = "";
        public string ArticlesSummary { get; set; } = "";
    }
}