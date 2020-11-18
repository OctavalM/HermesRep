using Hermes.Data;
using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel.DataAnnotations;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Hermes.Pages
{
    /// <summary>
    /// Логика взаимодействия для AddEditClientPage.xaml
    /// </summary>
    public partial class AddEditClientPage : Page
    {
        public static VideoRentalEntities DB = new VideoRentalEntities();
        private Client contextClient = new Client();

        public AddEditClientPage(Client postClient)
        {
            InitializeComponent();
            contextClient = postClient;
            DataContext = contextClient;
        }

        private void Page_Loaded(object sender, RoutedEventArgs e)
        {
            GenderCB.ItemsSource = VideoRentalEntities.GetContext().Gender.ToList(); 

            if (contextClient.ClientId == 0)
            {
                TitleTB.Visibility = Visibility.Hidden;
                IdTB.Visibility = Visibility.Hidden;
                TagCB.IsEnabled = false;
                AddTagBtn.IsEnabled = false;
                DeleteTagBtn.IsEnabled = false;
            }
            else
            {
                TagsLV.ItemsSource = VideoRentalEntities.GetContext().ClientTag.ToList().Where(x => x.ClientId == contextClient.ClientId).ToList(); 
                TagCB.ItemsSource = VideoRentalEntities.GetContext().Tag.ToList();
            }
        }
         
        private void AddTagBtn_Click(object sender, RoutedEventArgs e)
        {
            if (TagCB.SelectedIndex >= 0)
            {
                var selectedTag = (TagCB.SelectedItem as Tag).TagId;
                var isTag = VideoRentalEntities.GetContext().ClientTag.Where(x => x.ClientId == contextClient.ClientId && x.TagId == selectedTag).Count();

                if (isTag == 0)
                {
                    VideoRentalEntities.GetContext().ClientTag.Add(new ClientTag { ClientId = contextClient.ClientId, TagId = selectedTag });
                    VideoRentalEntities.GetContext().SaveChanges();
                    TagsLV.ItemsSource = VideoRentalEntities.GetContext().ClientTag.ToList().Where(x => x.ClientId == contextClient.ClientId).ToList();
                }
            }
        }

        private void DeleteTagBtn_Click(object sender, RoutedEventArgs e)
        {
            if (TagsLV.SelectedItem != null)
            {
                var selectedTag = (TagsLV.SelectedItem as ClientTag).TagId;
                var removeTag = VideoRentalEntities.GetContext().ClientTag.Where(x => x.ClientId == contextClient.ClientId && x.TagId == selectedTag).Single();

                VideoRentalEntities.GetContext().ClientTag.Remove(removeTag);
                VideoRentalEntities.GetContext().SaveChanges();
                TagsLV.ItemsSource = VideoRentalEntities.GetContext().ClientTag.ToList().Where(x => x.ClientId == contextClient.ClientId).ToList();
            }
        } 

        private void LoadBtn_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog dialog = new OpenFileDialog
            {
                Filter = "*.png|*.png|*.jpg|*.jpg"
            };

            if (dialog.ShowDialog().GetValueOrDefault())
            {
                FileInfo info = new FileInfo(dialog.FileName);

                if (info.Length / 1024 > 150) 
                    MessageBox.Show("Размер изображения превышает 150 КБ.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
                else
                {
                    contextClient.Photo = File.ReadAllBytes(dialog.FileName);
                    ClientImg.Source = new BitmapImage(new Uri(dialog.FileName));
                } 
            }
        }

        private void SaveBtn_Click(object sender, RoutedEventArgs e)
        {
            EmailAddressAttribute emailAddressAttribute = new EmailAddressAttribute();
            Regex regex = new Regex(@"[+7|8]\([0-9]{3}\)[0-9]{3}\-[0-9]{2}\-[0-9]{2}$");
            Match matchTelephone = null;

            if (TelephoneTB.Text != null)
                matchTelephone = regex.Match(TelephoneTB.Text);

            StringBuilder error = new StringBuilder();

            if (string.IsNullOrWhiteSpace(contextClient.Name))
                error.AppendLine("Введите имя клиента.");
            if (string.IsNullOrWhiteSpace(contextClient.Surname))
                error.AppendLine("Введите фамилию клиента.");
            if (string.IsNullOrWhiteSpace(contextClient.Patronymic))
                error.AppendLine("Введите отчество клиента.");
            if (string.IsNullOrWhiteSpace(contextClient.Email))
                error.AppendLine("Введите email клиента.");
            if (!emailAddressAttribute.IsValid(contextClient.Email))
                error.AppendLine("Email введен неправильно.");
            if (string.IsNullOrWhiteSpace(contextClient.PhoneNumber))
                error.AppendLine("Введите номер телефона клиента.");
            if (!(matchTelephone.Success))
                error.AppendLine("Номер телефона не соответствует формату +7(XXX)XXX-XX-XX или 8(XXX)XXX-XX-XX.");
            if (contextClient.BirthDate == null)
                error.AppendLine("Выберите дату рождения клиента.");
            if (contextClient.Gender == null)
                error.AppendLine("Выберите пол клиента.");

            if (error.Length > 0)
                MessageBox.Show(error.ToString(), "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            else
            {
                if (contextClient.ClientId == 0)
                {
                    contextClient.AddedDate = DateTime.Now.Date;
                    VideoRentalEntities.GetContext().Client.Add(contextClient);
                }

                VideoRentalEntities.GetContext().SaveChanges();
                MessageBox.Show("Информация сохранена.", "Сообщение", MessageBoxButton.OK, MessageBoxImage.Information);
            }
        }
    }
}
