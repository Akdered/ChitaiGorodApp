using System;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Windows;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using Microsoft.Win32;

namespace ChitaiGorodApp
{
    public partial class ProductEditWindow : Window
    {
        private readonly Product? _editingProduct;
        private readonly bool _isNew;
        private string? _newSelectedPhotoSourcePath;
        private string? _currentPhotoFileName;

        public ProductEditWindow(Product? product)
        {
            InitializeComponent();
            _editingProduct = product;
            _isNew = product == null;

            LoadLookups();

            if (_isNew)
            {
                this.Title = "Добавление нового товара";
                IdPanel.Visibility = Visibility.Collapsed;
                _currentPhotoFileName = null;
                LoadPreview(null);
            }
            else
            {
                this.Title = $"Редактирование товара — {product!.Name}";
                IdPanel.Visibility = Visibility.Visible;
                IdBox.Text = product.Id.ToString();
                ArticleBox.Text = product.Article;
                NameBox.Text = product.Name;
                PriceBox.Text = product.Price.ToString("0.##", CultureInfo.InvariantCulture);
                StockBox.Text = product.StockQuantity.ToString();
                DiscountBox.Text = product.Discount.ToString();
                DescriptionBox.Text = product.Description ?? "";

                CategoryBox.SelectedItem = CategoryBox.Items.Cast<LookupItem>().FirstOrDefault(x => x.Id == product.CategoryId);
                ManufacturerBox.SelectedItem = ManufacturerBox.Items.Cast<LookupItem>().FirstOrDefault(x => x.Id == product.ManufacturerId);
                SupplierBox.SelectedItem = SupplierBox.Items.Cast<LookupItem>().FirstOrDefault(x => x.Id == product.SupplierId);
                UnitBox.SelectedItem = UnitBox.Items.Cast<LookupItem>().FirstOrDefault(x => x.Id == product.UnitId);

                _currentPhotoFileName = product.PhotoFileName;
                PhotoNameText.Text = _currentPhotoFileName ?? "Изображение не задано (заглушка)";
                LoadPreview(_currentPhotoFileName);
            }
        }

        private void LoadLookups()
        {
            CategoryBox.ItemsSource = Database.GetLookup("categories", "id_Категории", "Категория товара");
            ManufacturerBox.ItemsSource = Database.GetLookup("manufacturers", "id_Производителя", "Производитель");
            SupplierBox.ItemsSource = Database.GetLookup("suppliers", "id_Поставщика", "Поставщик");
            UnitBox.ItemsSource = Database.GetLookup("units", "id_ЕдИзм", "Единица измерения");

            if (CategoryBox.Items.Count > 0) CategoryBox.SelectedIndex = 0;
            if (ManufacturerBox.Items.Count > 0) ManufacturerBox.SelectedIndex = 0;
            if (SupplierBox.Items.Count > 0) SupplierBox.SelectedIndex = 0;
            if (UnitBox.Items.Count > 0) UnitBox.SelectedIndex = 0;
        }

        private void LoadPreview(string? fileName)
        {
            string baseDir = AppDomain.CurrentDomain.BaseDirectory;
            string? targetPath = null;

            if (!string.IsNullOrWhiteSpace(fileName))
            {
                string cleanName = fileName.Trim();
                string candidate1 = Path.Combine(baseDir, "Images", cleanName);
                string candidate2 = Path.Combine(baseDir, cleanName);
                if (File.Exists(candidate1)) targetPath = candidate1;
                else if (File.Exists(candidate2)) targetPath = candidate2;
                else
                {
                    string projectDir = Path.GetFullPath(Path.Combine(baseDir, "..", "..", ".."));
                    string candidate3 = Path.Combine(projectDir, "Images", cleanName);
                    if (File.Exists(candidate3)) targetPath = candidate3;
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

            if (targetPath != null && File.Exists(targetPath))
            {
                try
                {
                    var bmp = new BitmapImage();
                    bmp.BeginInit();
                    bmp.CacheOption = BitmapCacheOption.OnLoad;
                    bmp.UriSource = new Uri(targetPath, UriKind.Absolute);
                    bmp.EndInit();
                    PreviewImage.Source = bmp;
                }
                catch
                {
                    try
                    {
                        string fallback = Path.Combine(baseDir, "picture.png");
                        if (!File.Exists(fallback))
                            fallback = Path.GetFullPath(Path.Combine(baseDir, "..", "..", "..", "picture.png"));

                        if (File.Exists(fallback))
                        {
                            var fb = new BitmapImage(new Uri(fallback, UriKind.Absolute));
                            PreviewImage.Source = fb;
                        }
                    }
                    catch { }
                }
            }
        }

        private void SelectPhoto_Click(object sender, RoutedEventArgs e)
        {
            var dlg = new OpenFileDialog
            {
                Title = "Выберите изображение товара",
                Filter = "Изображения (*.jpg;*.jpeg;*.png)|*.jpg;*.jpeg;*.png"
            };

            if (dlg.ShowDialog() == true)
            {
                try
                {
                    _newSelectedPhotoSourcePath = dlg.FileName;
                    PhotoNameText.Text = Path.GetFileName(dlg.FileName);

                    var bmp = new BitmapImage();
                    bmp.BeginInit();
                    bmp.CacheOption = BitmapCacheOption.OnLoad;
                    bmp.UriSource = new Uri(dlg.FileName, UriKind.Absolute);
                    bmp.EndInit();
                    PreviewImage.Source = bmp;
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Не удалось открыть изображение: {ex.Message}", "Ошибка",
                        MessageBoxButton.OK, MessageBoxImage.Warning);
                }
            }
        }

        private string SaveResizedImage(string sourceFilePath)
        {
            string imagesDir = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Images");
            Directory.CreateDirectory(imagesDir);

            string newFileName = $"{Guid.NewGuid():N}.jpg";
            string destPath = Path.Combine(imagesDir, newFileName);

            var original = new BitmapImage();
            original.BeginInit();
            original.CacheOption = BitmapCacheOption.OnLoad;
            original.UriSource = new Uri(sourceFilePath, UriKind.Absolute);
            original.EndInit();

            double scaleX = 300.0 / original.PixelWidth;
            double scaleY = 200.0 / original.PixelHeight;
            double scale = Math.Min(scaleX, scaleY);
            if (scale > 1.0) scale = 1.0;

            var transformed = new TransformedBitmap(original, new ScaleTransform(scale, scale));
            var encoder = new JpegBitmapEncoder { QualityLevel = 85 };
            encoder.Frames.Add(BitmapFrame.Create(transformed));

            using (var fs = new FileStream(destPath, FileMode.Create))
            {
                encoder.Save(fs);
            }

            try
            {
                string projectImagesDir = Path.GetFullPath(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "..", "..", "..", "Images"));
                if (Directory.Exists(projectImagesDir))
                {
                    File.Copy(destPath, Path.Combine(projectImagesDir, newFileName), true);
                }
            }
            catch { }

            return newFileName;
        }

        private void SaveBtn_Click(object sender, RoutedEventArgs e)
        {
            // Валидация полей по ТЗ
            if (string.IsNullOrWhiteSpace(ArticleBox.Text) || string.IsNullOrWhiteSpace(NameBox.Text))
            {
                MessageBox.Show("Заполните артикул и наименование товара.", "Ошибка",
                    MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            if (!decimal.TryParse(PriceBox.Text.Replace(',', '.'), NumberStyles.Any, CultureInfo.InvariantCulture, out decimal price) || price < 0)
            {
                MessageBox.Show("Неверная стоимость товара",
                    "Ошибка валидации", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            if (!int.TryParse(StockBox.Text, out int stock) || stock < 0)
            {
                MessageBox.Show("Количество на складе должно быть целым неотриц числом.",
                    "Ошибка", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            if (!int.TryParse(DiscountBox.Text, out int discount) || discount < 0 || discount > 100)
            {
                MessageBox.Show("Действующая скидка должна быть целым числом от 0 до 100",
                    "Ошибка валидации", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            try
            {
                string? finalPhotoFileName = _currentPhotoFileName;

                if (!string.IsNullOrEmpty(_newSelectedPhotoSourcePath))
                {
                    finalPhotoFileName = SaveResizedImage(_newSelectedPhotoSourcePath);

                    if (!string.IsNullOrWhiteSpace(_currentPhotoFileName))
                    {
                        string oldPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Images", _currentPhotoFileName);
                        if (File.Exists(oldPath))
                        {
                            try { File.Delete(oldPath); } catch { }
                        }
                    }
                }

                var product = new Product
                {
                    Id = _isNew ? 0 : _editingProduct!.Id,
                    Article = ArticleBox.Text.Trim(),
                    Name = NameBox.Text.Trim(),
                    CategoryId = ((LookupItem)CategoryBox.SelectedItem).Id,
                    ManufacturerId = ((LookupItem)ManufacturerBox.SelectedItem).Id,
                    SupplierId = ((LookupItem)SupplierBox.SelectedItem).Id,
                    UnitId = ((LookupItem)UnitBox.SelectedItem).Id,
                    Price = Math.Round(price, 2),
                    StockQuantity = stock,
                    Discount = discount,
                    Description = string.IsNullOrWhiteSpace(DescriptionBox.Text) ? null : DescriptionBox.Text.Trim(),
                    PhotoFileName = finalPhotoFileName
                };

                Database.SaveProduct(product, _isNew);
                MessageBox.Show("Данные товара успешно сохранены.", "Информаци", MessageBoxButton.OK, MessageBoxImage.Information);
                this.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при сохранении товара:\n{ex.Message}", "Ошибка БД",
                    MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void CancelBtn_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}