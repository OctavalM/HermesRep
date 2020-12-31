  using Hermes.Data;
using Hermes.MyTools;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
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

namespace Hermes.Pages
{
    /// <summary>
    /// Логика взаимодействия для ClientsPage.xaml
    /// </summary>
    public partial class ClientsPage : Page
    {
        private int numberRecord;
        private enum pagingMode { Next = 1, Previous = 2, PageCountChange = 3 };
        int pageIndex = 1;
        public ClientsPage()
        {
            InitializeComponent();
        } 

        private void GenderCB_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
           
        }

        private void NameTB_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            if (!(Char.IsLetter(e.Text, 0)))
            {
                e.Handled = true;
            }
        }

        private void NameTB_TextChanged(object sender, TextChangedEventArgs e)
        {
            RefreshPagesDataGrid();
        }

        private void SurnameTB_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            if (!(Char.IsLetter(e.Text, 0)))
            {
                e.Handled = true;
            }
        }

        private void SurnameTB_TextChanged(object sender, TextChangedEventArgs e)
        {
            RefreshPagesDataGrid();
        }

        private void PatronymicTB_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            if (!(Char.IsLetter(e.Text, 0)))
            {
                e.Handled = true;
            }
        }

        private void PatronymicTB_TextChanged(object sender, TextChangedEventArgs e)
        {
            RefreshPagesDataGrid();
        }

        private void EmailTB_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            if (!(Char.IsDigit(e.Text, 0) || Char.IsLetter(e.Text, 0) || e.Text == "@"
                || e.Text == "."))
            {
                e.Handled = true;
            }
        }

        private void EmailTB_TextChanged(object sender, TextChangedEventArgs e)
        {
            RefreshPagesDataGrid();
        }

        private void TelephoneTB_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            if (!(Char.IsDigit(e.Text, 0) || e.Text == "("
                || e.Text == ")" || e.Text == "+" || e.Text == "-"))
            {
                e.Handled = true;
            }
        }

        private void TelephoneTB_TextChanged(object sender, TextChangedEventArgs e)
        {
            RefreshPagesDataGrid();
        }

        private void DateBirthCB_Checked(object sender, RoutedEventArgs e)
        {
            RefreshPagesDataGrid();
        }

        private void DateBirthCB_Unchecked(object sender, RoutedEventArgs e)
        {
            RefreshPagesDataGrid();
        }

        private void PreviousBtn_Click(object sender, RoutedEventArgs e)
        {
            Navigate((int)pagingMode.Previous, Refresh());
        }

        private void NextBtn_Click(object sender, RoutedEventArgs e)
        {
            Navigate((int)pagingMode.Next, Refresh());
        }

        private void NumberRecordCB_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Navigate((int)pagingMode.PageCountChange, Refresh());
        }

        private void AddBtn_Click(object sender, RoutedEventArgs e)
        {
            AddEditClientPage addEditClient = new AddEditClientPage(new Client { BirthDate = DateTime.Now });
            addEditClient.TitlePageTB.Text = "Добавление клиента";
            NavigationService.Navigate(addEditClient);
        }

        private void EditBtn_Click(object sender, RoutedEventArgs e)
        {
            var selectedClient = ClientsDG.SelectedItem as Client;
            AddEditClientPage addEditClient = new AddEditClientPage(selectedClient);
            addEditClient.TitlePageTB.Text = "Редактирование данных клиента";

            

            NavigationService.Navigate(addEditClient);
        }

        private void DeleteBtn_Click(object sender, RoutedEventArgs e)
        {
            var selectedClient = ClientsDG.SelectedItem as Client;

            if (selectedClient == null)
                return;
        
            if (MessageBox.Show("Вы действительно хотите удалить информацию о клиенте ?", "Предупреждение", MessageBoxButton.YesNo, MessageBoxImage.Question) == MessageBoxResult.Yes)
            {
                int isVisit = VideoRentalEntities.GetContext().Visit.Where(x => x.ClientId == selectedClient.ClientId).Count();
                
                if (isVisit == 0)
                {
                    VideoRentalEntities.GetContext().Client.Remove(selectedClient);
                    VideoRentalEntities.GetContext().SaveChanges();
                    MessageBox.Show("Информация удалена.", "Сообщение", MessageBoxButton.OK, MessageBoxImage.Information);
                    ClientsDG.ItemsSource = VideoRentalEntities.GetContext().Client.ToList();
                }
                else MessageBox.Show("У клиента есть информация о посещениях или тегах.", "Ошибка", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void VisitsBtn_Click(object sender, RoutedEventArgs e)
        {
            var selectedClient = ClientsDG.SelectedItem as Client;

            if (selectedClient == null)
                return;

            NavigationService.Navigate(new VisitsPage(selectedClient));
        }

        private void RefreshPagesDataGrid()
        {
            ClientsDG.ItemsSource = Refresh();
            CountRecTB.Text = $"{ClientsDG.Items.Count} из {ClientsDG.Items.Count}";
        }

        public List<Client> Refresh()
        {
            var filteredClients = VideoRentalEntities.GetContext().Client.ToList();
            var selectedGender = GenderCB.SelectedItem as Gender;
            var name = NameTB.Text;
            var surname = SurnameTB.Text;
            var patronymic = PatronymicTB.Text;
            var email = EmailTB.Text;
            var telephone = TelephoneTB.Text;

            if (GenderCB.SelectedIndex > 0)
                filteredClients = filteredClients.Where(x => x.GenderId == selectedGender.GenderId).ToList();

            if (!string.IsNullOrWhiteSpace(name))
                filteredClients = filteredClients.Where(x => x.Name.ToLower().Contains(name.ToLower())).ToList();

            if (!string.IsNullOrWhiteSpace(surname))
                filteredClients = filteredClients.Where(x => x.Surname.ToLower().Contains(surname.ToLower())).ToList();

            if (!string.IsNullOrWhiteSpace(patronymic))
                filteredClients = filteredClients.Where(x => x.Patronymic.ToLower().Contains(patronymic.ToLower())).ToList();

            if (!string.IsNullOrWhiteSpace(email))
                filteredClients = filteredClients.Where(x => x.Email.ToLower().Contains(email.ToLower())).ToList();

            if (!string.IsNullOrWhiteSpace(telephone))
                filteredClients = filteredClients.Where(x => x.PhoneNumber.ToLower().Contains(telephone.ToLower())).ToList();

            if (DateBirthCB.IsChecked == true)
                filteredClients = filteredClients.Where(x => x.BirthDate.Month == DateTime.Now.Month).ToList();

            return filteredClients;
        }

        private void Navigate(int mode, List<Client> filteredClients)
        {
            int count;
            switch (mode)
            {
                case (int)pagingMode.Next:
                PreviousBtn.IsEnabled = true;
                if (filteredClients.Count >= pageIndex * numberRecord)
                {
                    if (filteredClients.Skip(pageIndex * numberRecord).Take(numberRecord).Count() == 0)
                    {
                        ClientsDG.ItemsSource = null;
                        ClientsDG.ItemsSource = filteredClients.Skip(pageIndex * numberRecord - numberRecord).Take(numberRecord);
                        count = pageIndex * numberRecord + filteredClients.Skip(pageIndex * numberRecord).Take(numberRecord).Count();
                    }
                    else
                    {
                        ClientsDG.ItemsSource = null;
                        ClientsDG.ItemsSource = filteredClients.Skip(pageIndex * numberRecord).Take(numberRecord);
                        count = pageIndex * numberRecord + filteredClients.Skip(pageIndex * numberRecord).Take(numberRecord).Count();
                        pageIndex++;
                    }

                    if (count == filteredClients.Count)
                        NextBtn.IsEnabled = false;

                    CountRecTB.Text = $"{count} из {filteredClients.Count}";
                } 
                break;

                case (int)pagingMode.Previous:
                NextBtn.IsEnabled = true;

                if (pageIndex > 1)
                {
                    pageIndex -= 1;
                    ClientsDG.ItemsSource = null;

                    if (pageIndex == 1)
                    {
                        ClientsDG.ItemsSource = filteredClients.Take(numberRecord);
                        count = filteredClients.Take(numberRecord).Count();
                        CountRecTB.Text = $"{count} из {filteredClients.Count}";
                    }
                    else
                    {
                        ClientsDG.ItemsSource = filteredClients.Skip(numberRecord).Take(numberRecord);
                        count = Math.Min(pageIndex * numberRecord, filteredClients.Count);
                        CountRecTB.Text = $"{count} из {filteredClients.Count}";
                    }

                    if (count == numberRecord)
                        PreviousBtn.IsEnabled = false;
                } 
                break;

                case (int)pagingMode.PageCountChange:
                pageIndex = 1;

                if (NumberRecordCB.SelectedIndex == 0)
                {
                    PreviousBtn.IsEnabled = false;
                    NextBtn.IsEnabled = false;
                    ClientsDG.ItemsSource = filteredClients;
                    CountRecTB.Text = $"{ClientsDG.Items.Count} из {ClientsDG.Items.Count}"; 
                }
                else
                {
                    numberRecord = Convert.ToInt32(NumberRecordCB.SelectedItem);
                    ClientsDG.ItemsSource = filteredClients.Take(numberRecord);
                    count = filteredClients.Take(numberRecord).Count();

                    if (count == filteredClients.Count)
                    {
                        NextBtn.IsEnabled = false;
                        PreviousBtn.IsEnabled = false;
                    }
                    else
                        NextBtn.IsEnabled = true;

                    CountRecTB.Text = $"{count} из {filteredClients.Count}";
                } 
                break;
            }
        }

        private void Page_IsVisibleChanged(object sender, DependencyPropertyChangedEventArgs e)
        {
            if (Visibility == Visibility.Visible)
            {
                VideoRentalEntities.GetContext().ChangeTracker.Entries().ToList().ForEach(x => x.Reload());

                GenderCB.ItemsSource = Tools.CreateComboBox(VideoRentalEntities.GetContext().Gender.ToList(), new Gender() { GenderName = "Все" });
                GenderCB.SelectedIndex = 0;

                NumberRecordCB.ItemsSource = new List<string> { "Все", "10", "50", "200" };
                NumberRecordCB.SelectedIndex = 0; 
                 
                ClientsDG.ItemsSource = null;
                ClientsDG.ItemsSource = VideoRentalEntities.GetContext().Client.ToList();
                CountRecTB.Text = $"{ClientsDG.Items.Count} из {ClientsDG.Items.Count}";
            }
           
        }
    }
}
