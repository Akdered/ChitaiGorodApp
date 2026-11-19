using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;

namespace ChitaiGorodApp
{
    public partial class ProductsWindow : Window
    {
        private readonly User _currentUser;
        private List<Product> _allProducts = new();
        private bool _isEditWindowOpen = false;

        public ProductsWindow(User user)
        {
            InitializeComponent();
            _currentUser = user;

            if (_currentUser.RoleName == "Гость" || _currentUser.Id == 0)
                UserInfoText.Text = "Гость";
            else
                UserInfoText.Text = $"{_currentUser.FullName} ({_currentUser.RoleName})";

            ConfigureRoleAccess();
            LoadProducts();
        }

        private void ConfigureRoleAccess()
        {
            bool isManagerOrAdmin = _currentUser.RoleName == "Менеджер" || _currentUser.RoleName == "Администратор";
            bool isAdmin = _currentUser.RoleName == "Администратор";

            FilterPanel.Visibility = isManagerOrAdmin ? Visibility.Visible : Visibility.Collapsed;
              BottomPanel.Visibility = isManagerOrAdmin ? Visibility.Visible : Visibility.Collapsed;
            OrdersBtn.Visibility = isManagerOrAdmin ? Visibility.Visible : Visibility.Collapsed;
             AddProductBtn.Visibility = isAdmin ? Visibility.Visible : Visibility.Collapsed;
            DeleteProductBtn.Visibility = isAdmin ? Visibility.Visible : Visibility.Collapsed;
        }

        public void LoadProducts()
        {
            try
            {
                _allProducts = Database.GetProducts();
                ApplyFilters();
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка загрузки товаров:\n{ex.Message}", "Ошибка БД",
                    MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void FilterChanged(object sender, EventArgs e)
        {
            ApplyFilters();
        }

        private void ApplyFilters()
        {
            if (_allProducts == null || ProductsListBox == null) return;
            IEnumerable<Product> query = _allProducts;

            string search = SearchBox?.Text.Trim().ToLower() ?? "";
            if (!string.IsNullOrEmpty(search))
            {
                query = query.Where(p =>
                    p.Article.ToLower().Contains(search) ||
                    p.Name.ToLower().Contains(search) ||
                    p.CategoryName.ToLower().Contains(search) ||
                    p.ManufacturerName.ToLower().Contains(search) ||
                    p.SupplierName.ToLower().Contains(search) ||
                    p.UnitName.ToLower().Contains(search) ||
                    (p.Description != null && p.Description.ToLower().Contains(search))
                );
            }

            int discountIdx = DiscountFilterComboBox?.SelectedIndex ?? 0;
            if (discountIdx == 1) // 0-12,99%
                query = query.Where(p => p.Discount >= 0 && p.Discount <= 12);
            else if (discountIdx == 2) // 13-16,99%
                query = query.Where(p => p.Discount >= 13 && p.Discount <= 16);
            else if (discountIdx == 3) // 17% и более
                query = query.Where(p => p.Discount >= 17);

            int sortIdx = SortComboBox?.SelectedIndex ?? 0;
            query = sortIdx switch
            {
                1 => query.OrderBy(p => p.FinalPrice),
                2 => query.OrderByDescending(p => p.FinalPrice),
                3 => query.OrderBy(p => p.StockQuantity),
                4 => query.OrderByDescending(p => p.StockQuantity),
                _ => query.OrderBy(p => p.Id)
            } ;

            var result = query.ToList();
            ProductsListBox.ItemsSource = result;
            if (CountText != null)
                CountText.Text = $"Показано: {result.Count} из {_allProducts.Count}";
        }

        private void OpenEditWindow(Product? product)
        {
            if (_isEditWindowOpen)
            {
                MessageBox.Show("Окно добавления/редактирования товара уже открыто. Закройте текущее окно перед открытием нового.",
                    "Предупреждение", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            _isEditWindowOpen = true;
            var editWin = new ProductEditWindow(product);
            editWin.Owner = this;
            editWin.Closed += (s, args) =>
            {
                _isEditWindowOpen = false;
                LoadProducts();
            };
            editWin.Show();
        }

        private void AddProductBtn_Click(object sender, RoutedEventArgs e)
        {
            OpenEditWindow(null);
        }

        private void ProductsListBox_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            if (_currentUser.RoleName != "Администратор") return;
            if (ProductsListBox.SelectedItem is Product selected)
            {
                OpenEditWindow(selected);
            }
        }

        private void DeleteProductBtn_Click(object sender, RoutedEventArgs e)
        {
            if (ProductsListBox.SelectedItem is not Product selected)
            {
                MessageBox.Show("Выберите товар из списка для удаления.", "Информация",
                    MessageBoxButton.OK, MessageBoxImage.Information);
                return;
            }

            if (Database.IsProductInOrders(selected.Id))
            {
                MessageBox.Show($"Товар «{selected.Name}» ({selected.Article}) присутствует в заказах клиентов и не может быть удален из базы данных.",
                    "Запрет удаления", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            var confirm = MessageBox.Show($"Вы действительно хотите безвозвратно удалить товар «{selected.Name}»?",
                "Подтверждение удаления", MessageBoxButton.YesNo, MessageBoxImage.Warning);

            if (confirm != MessageBoxResult.Yes) return;

            try
            {
                Database.DeleteProduct(selected.Id);

                if (!string.IsNullOrWhiteSpace(selected.PhotoFileName))
                {
                    string imgPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Images", selected.PhotoFileName);
                    if (File.Exists(imgPath))
                    {
                        try { File.Delete(imgPath); } catch { }
                    }
                }

                LoadProducts();
                MessageBox.Show("Товар успешно удален.", "Информация", MessageBoxButton.OK, MessageBoxImage.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Не удалось удалить товар:\n{ex.Message}", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void OrdersBtn_Click(object sender, RoutedEventArgs e)
        {
            var ordersWin = new OrdersWindow(_currentUser);
            ordersWin.Owner = this;
            ordersWin.ShowDialog();
        }

        private void LogoutButton_Click(object sender, RoutedEventArgs e)
        {
            var loginWin = new LoginWindow();
            loginWin.Show();
            this.Close();
        }
    }
}