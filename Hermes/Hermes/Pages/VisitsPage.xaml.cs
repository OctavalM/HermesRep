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

namespace Hermes.Pages
{
    /// <summary>
    /// Логика взаимодействия для VisitsPage.xaml
    /// </summary>
    public partial class VisitsPage : Page
    {
        public VisitsPage()
        {
            InitializeComponent();
            VisitsDG.ItemsSource = VideoRentalEntities.GetContext().Visit.ToList();

        } 

        private void DayCB_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            var filteredVisits = VideoRentalEntities.GetContext().Visit.ToList();

            if (DayCB.SelectedIndex == 0)
                filteredVisits = filteredVisits.Where(x => x.DateVisit.DayOfWeek == DayOfWeek.Monday).ToList();

            if (DayCB.SelectedIndex == 1)
                filteredVisits = filteredVisits.Where(x => x.DateVisit.DayOfWeek == DayOfWeek.Tuesday).ToList();

            if (DayCB.SelectedIndex == 2)
                filteredVisits = filteredVisits.Where(x => x.DateVisit.DayOfWeek == DayOfWeek.Wednesday).ToList();

            if (DayCB.SelectedIndex == 3)
                filteredVisits = filteredVisits.Where(x => x.DateVisit.DayOfWeek == DayOfWeek.Tuesday).ToList();

            if (DayCB.SelectedIndex == 4)
                filteredVisits = filteredVisits.Where(x => x.DateVisit.DayOfWeek == DayOfWeek.Friday).ToList();

            if (DayCB.SelectedIndex == 5)
                filteredVisits = filteredVisits.Where(x => x.DateVisit.DayOfWeek == DayOfWeek.Saturday).ToList();

            if (DayCB.SelectedIndex == 6)
                filteredVisits = filteredVisits.Where(x => x.DateVisit.DayOfWeek == DayOfWeek.Sunday).ToList();

            VisitsDG.ItemsSource = filteredVisits; 
        }
    }
}
