using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Hermes.MyTools
{
    class Tools
    {
        public static List<T> CreateComboBox<T>(List<T> source, T item)
        {
            var result = source.ToList();
            result.Insert(0, item);

            return result;
        }
    }
}
