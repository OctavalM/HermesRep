using Hermes.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Hermes
{
    /// <summary>
    /// Логика взаимодействия для AuthorizationWindow.xaml
    /// </summary>
    public partial class AuthorizationWindow : Window
    {
        public AuthorizationWindow()
        {
            InitializeComponent();
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            if (Properties.Settings.Default.Login != null)
                LoginTB.Text = Properties.Settings.Default.Login;
        }

        private void LoginBtn_Click(object sender, RoutedEventArgs e)
        {
            string login = LoginTB.Text;
            string password = PasswordPB.Password;
            
            StringBuilder error = new StringBuilder();

            if (string.IsNullOrWhiteSpace(login))
                error.AppendLine("Введите логин пользователя.");
            if (string.IsNullOrWhiteSpace(password))
                error.AppendLine("Введите пароль пользователя.");

            if (error.Length > 0)
                MessageBox.Show(error.ToString(), "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            else
            {
                var user = VideoRentalEntities.GetContext().User.FirstOrDefault(x => x.Login == login && x.Password == password);
        
               if (user != null)
               {
                   if (RememberCB.IsChecked == true)
                   {
                        Properties.Settings.Default.Login = user.Login;
                        Properties.Settings.Default.Save();
                   }
                   else
                   {
                        Properties.Settings.Default.Login = null;
                        Properties.Settings.Default.Save();
                   }

                    MainWindow mainWindow = new MainWindow();
                    Hide();
                    mainWindow.Show();
               }
               else
               {
                   MessageBox.Show("Пользователь не найден.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                   LoginTB.Clear();
                   PasswordPB.Clear();
               }
            } 
        }
    }
}
