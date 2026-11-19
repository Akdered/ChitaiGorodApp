using System;
using System.Windows;
using System.Windows.Input;

namespace ChitaiGorodApp
{
    public partial class OrdersWindow : Window
    {
        private readonly User _currentUser;

        public OrdersWindow(User user)
        {
            InitializeComponent();
            _currentUser = user;

            AdminOrderPanel.Visibility = _currentUser.RoleName == "Администратор"
                ? Visibility.Visible
                : Visibility.Collapsed;

            LoadOrders();
        }

        private void LoadOrders()
        {
            try
             {
                OrdersListBox.ItemsSource = Database.GetOrders();
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка загрузки заказов:\n{ex.Message}", "Ошибка БД",
                    MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void AddOrderBtn_Click(object sender, RoutedEventArgs e)
        {
            var win = new OrderEditWindow(null) { Owner = this };
            win.ShowDialog();
            LoadOrders();
 }

        private void OrdersListBox_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            if (_currentUser.RoleName != "Администратор") return;
            if (OrdersListBox.SelectedItem is Order selected)
            {
                var win = new OrderEditWindow(selected) { Owner = this };
                win.ShowDialog();
                LoadOrders();
        }
        }

        private void DeleteOrderBtn_Click(object sender, RoutedEventArgs e)
        {
            if (OrdersListBox.SelectedItem is not Order selected)
            {
                MessageBox.Show("Выберите заказ для удаления.", "Информация",
                    MessageBoxButton.OK, MessageBoxImage.Information);
                return;
            }

            if (MessageBox.Show($"Удалить заказ №{selected.Id}?", "Подтверждение",
                MessageBoxButton.YesNo, MessageBoxImage.Warning) != MessageBoxResult.Yes)
                return;

            try
            {
                Database.DeleteOrder(selected.Id);
                LoadOrders();
                MessageBox.Show("Зказ успешно удален.", "Информация", MessageBoxButton.OK, MessageBoxImage.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка при удалении заказа:\n{ex.Message}", "Ошибка",
                    MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void BackBtn_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}