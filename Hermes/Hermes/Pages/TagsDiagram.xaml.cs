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
    /// Логика взаимодействия для TagsDiagram.xaml
    /// </summary>
    public partial class TagsDiagram : Page
    {
        public TagsDiagram()
        {
            InitializeComponent();
        }

        private void Page_Loaded(object sender, RoutedEventArgs e)
        {
            var legend = ChTag.Legends.Add("Legend1");
            legend.Title = "Теги";
            //var dict = VideoRentalEntities.GetContext().ClientTag.GroupBy(x => x.Tag.TagName).ToDictionary(d => d.Key, d => d.ToList().Count());
            var dict = VideoRentalEntities.GetContext().ClientTag.Where(x => x.Tag.TagName == "Др").Count();
            List<int> k = new List<int>();
            k.Add(dict);
           
            var a = ChTag.ChartAreas.Add("a");
            a.AxisY.Maximum = 50;

            ChTag.ChartAreas[0].AxisX.MajorGrid.Enabled = false;
            ChTag.ChartAreas[0].AxisX.MinorGrid.Enabled = false;
            ChTag.ChartAreas[0].AxisY.MajorGrid.Enabled = false;
            ChTag.ChartAreas[0].AxisY.MinorGrid.Enabled = false;

            var s = ChTag.Series.Add("Байопик");
            s = ChTag.Series.Add("Боевик");
            s = ChTag.Series.Add("Драма");
            s = ChTag.Series.Add("Комедия");
            s = ChTag.Series.Add("Приключение");

            s.ChartArea = a.Name;
            //ChTag.Series["Байопик"].Points.DataBindXY(dict.Keys, dict.Values);
            //ChTag.Series["Боевик"].Points.DataBindXY(dicta.Keys, dicta.Values);
             s.LabelForeColor = System.Drawing.Color.DarkCyan;
            s.IsValueShownAsLabel = true;
            ChTag.Series["Байопик"].Points.DataBindY(k);
            //ChTag.Series["Боевик"].Points.AddXY(dict./*Values*/);
            ////ChTag.Series["Драма"].Points.AddXY(1, 200);
            //ChTag.Series["Комедия"].Points.AddXY(1, 200);
            //ChTag.Series["Приключение"].Points.AddXY(1, 200);
        }
    }
}
