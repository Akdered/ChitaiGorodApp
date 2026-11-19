using System;
using System.Windows;

namespace ChitaiGorodApp
{
    public partial class LoginWindow : Window
    {
        public LoginWindow()
        {
            InitializeComponent();
        }

        private void LoginButton_Click(object sender, RoutedEventArgs e)
        {
            string login = LoginBox.Text.Trim();
            string pass = PasswordBox.Password.Trim();

            if (string.IsNullOrEmpty(login) || string.IsNullOrEmpty(pass))
            {
                MessageBox.Show("Введите логин и пароль для входа в систему.", "Ошибка ввода",
                    MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            User? user;
            try
            {
                user = Database.Authenticate(login, pass);
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка подключения к базе данных:\n{ex.Message}", "Ошибка БД",
                    MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            if (user == null)
            {
                MessageBox.Show("Неверный логин или пароль. Проверьте правильность введенных данных и повторите попытку.",
                    "Ошибка авторизации", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            try
            {
                var mainWin = new ProductsWindow(user);
                mainWin.Show();
                this.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка открытия окна товаров:\n{ex.Message}", "Ошибка приложения",
                    MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void GuestButton_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                var guest = new User { Id = 0, RoleId = 0, RoleName = "Гость", FullName = "Гость" };
                var mainWin = new ProductsWindow(guest);
                mainWin.Show();
                this.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка открытия окна товаров:\n{ex.Message}", "Ошибка приложения",
                    MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }
    }
}