using System;
using System.Linq;
using System.Windows;

namespace ChitaiGorodApp
{
    public partial class OrderEditWindow : Window
    {
        private readonly Order? _editingOrder;
        private readonly bool _isNew;

        public OrderEditWindow(Order? order)
        {
            InitializeComponent();
            _editingOrder = order;
            _isNew = order == null;

            StatusBox.ItemsSource = Database.GetLookup("order_statuses", "id_Заказа", "Статус заказа");
            PickupBox.ItemsSource = Database.GetLookup("pickup_points", "id_Адрес", "Адрес");
            ClientBox.ItemsSource = Database.GetLookup("users", "id_Пользователей", "ФИО");

            if (_isNew)
            {
                this.Title = "Добавление нового заказа";
                OrderNumBox.Text = "Автоматически (+1)";
                OrderDatePicker.SelectedDate = DateTime.Today;
                DeliveryDatePicker.SelectedDate = DateTime.Today.AddDays(3);
                CodeBox.Text = new Random().Next(100, 999).ToString();
                if (StatusBox.Items.Count > 0) StatusBox.SelectedIndex = 0;
                if (PickupBox.Items.Count > 0) PickupBox.SelectedIndex = 0;
                if (ClientBox.Items.Count > 0) ClientBox.SelectedIndex = 0;
            }
            else
            {
                this.Title = $"Редактирование заказа №{order!.Id}";
                OrderNumBox.Text = order.Id.ToString();
                OrderDatePicker.SelectedDate = order.OrderDate;
                DeliveryDatePicker.SelectedDate = order.DeliveryDate;
                CodeBox.Text = order.ReceiveCode.ToString();

                StatusBox.SelectedItem = StatusBox.Items.Cast<LookupItem>().FirstOrDefault(x => x.Id == order.StatusId);
                PickupBox.SelectedItem = PickupBox.Items.Cast<LookupItem>().FirstOrDefault(x => x.Id == order.PickupPointId);
                ClientBox.SelectedItem = ClientBox.Items.Cast<LookupItem>().FirstOrDefault(x => x.Id == order.UserId);
            }
        }

        private void SaveBtn_Click(object sender, RoutedEventArgs e)
        {
            if (OrderDatePicker.SelectedDate == null || DeliveryDatePicker.SelectedDate == null)
            {
                MessageBox.Show("Укажите дату заказа и дату выдачи", "Ошибка валидации",
                    MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            if (!int.TryParse(CodeBox.Text, out int code))
            {
                MessageBox.Show("Код для получения должен быть числом", "Ошибка валидации",
                    MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            try
            {
                var ord = new Order
                {
                    Id = _isNew ? 0 : _editingOrder!.Id,
                    OrderDate = OrderDatePicker.SelectedDate.Value,
                    DeliveryDate = DeliveryDatePicker.SelectedDate.Value,
                    StatusId = ((LookupItem)StatusBox.SelectedItem).Id,
                    PickupPointId = ((LookupItem)PickupBox.SelectedItem).Id,
                    UserId = ((LookupItem)ClientBox.SelectedItem).Id,
                    ReceiveCode = code
                };

                Database.SaveOrder(ord, _isNew);
                MessageBox.Show("Заказ успешно сохранен.", "Инфа-я", MessageBoxButton.OK, MessageBoxImage.Information);
                this.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка сохран-я заказа:\n{ex.Message}", "Ошибка БД",
                    MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void CancelBtn_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}