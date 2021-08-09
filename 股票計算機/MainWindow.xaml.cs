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

namespace 股票計算機
{
    static class Constants
    {
        public const float SERVICE_FEE = 0.001425f;
        public const float TAX = 0.003f;

    }

    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {

        public MainWindow()
        {
            InitializeComponent();
            init();
        }

        private void init()
        {
            SellAllCheck();

            if (AutoCount == null) return;
            if ((bool)AutoCount.IsChecked)
                Calculate();
        }

        private void Cal_Click(object sender, RoutedEventArgs e)
        {
            Calculate();
        }

        private void SellAll_Click(object sender, RoutedEventArgs e)
        {
            SellAllCheck();
            
        }

        private void SellAllCheck()
        {
            if ((bool)SellAll.IsChecked)
            {
                OutputNum.SetBinding(TextBox.TextProperty, new Binding { Source = InputNum, Path = new PropertyPath("Text") });
                OutputNum.IsEnabled = false;
            }
            else
            {
                OutputNum.IsEnabled = true;
                BindingOperations.ClearBinding(OutputNum, TextBox.TextProperty);
                OutputNum.Text = InputNum.Text;
            }
        }

        private void AutoCount_Click(object sender, RoutedEventArgs e)
        {
            if ((bool)((CheckBox)sender).IsChecked)
            {
                Cal.IsEnabled = false;
                Calculate();
            }
            else
            {
                Cal.IsEnabled = true;
            }
        }

        private void Detail_Click(object sender, RoutedEventArgs e)
        {
            Calculate();
        }


        private void CheckAutoCal(object sender, RoutedEventArgs e)
        {
            if (AutoCount == null) return;
            if ((bool)AutoCount.IsChecked)
            {
                Calculate();
            }
        }

        private void Calculate()
        {
            try
            {
                float input_num =   float.Parse(InputNum.Text);
                float input_val =   float.Parse(InputVal.Text);
                float output_num =  float.Parse(OutputNum.Text);
                float output_val =  float.Parse(OutputVal.Text);

                float minfee = float.Parse(MinFee.Text);

                float input = input_num * input_val;
                float output = output_num * output_val;

                float ret_input = input + Math.Max(input * Constants.SERVICE_FEE, minfee);
                float ret_output = output - Math.Max(output * Constants.SERVICE_FEE, minfee) - output * Constants.TAX;

                float resultVal = ret_output - ret_input;

                string resultSymbol = (ret_input <= ret_output ? "獲益" : "虧損");

                Result.Text = String.Format("支出：{0:0.##}{4}\n收入：{1:0.##}{4}\n{2}：{3:0.##}{5}({6:0.##%})\n", ret_input, ret_output, resultSymbol, resultVal, "\t元", "元", resultVal/ret_input);


                if ((bool)ShowDetail.IsChecked)
                {
                    Detail.Text = String.Format("{0:0.##}{10}{1:0.##}\n" +
                        "{2:0.##}{11}{3:0.##}({7}{8}){11}{4:0.##}\n" +
                        "{5:0.##}{11}{6:0.##}({9}0)\n",
                        input, input * Constants.SERVICE_FEE,
                        output, output * Constants.SERVICE_FEE, output * Constants.TAX,
                        ret_output, ret_input,
                        (input * Constants.SERVICE_FEE > minfee ? ">" : "<"), minfee,
                        (resultVal > 0 ? ">" : "<"), 
                        "\t＋  ", "\t－  ");

                    DetailTip.Text = String.Format("{0}{7}{1}\n" +
                        "{0}{8}{1}({5}){8}{2}\n" +
                        "{3}{8}{4}({6})\n", 
                        "本金", "手續費", 
                        "稅額", 
                        "收入", "支出", 
                        String.Format("<{0} 以{0}元計", minfee), "<0為虧損",
                        " ＋ ", " － ");


                    //DetailTip.Text = String.Format("{0}x{1}+{0}x{1}x{2:0.####%}\n" +
                    //    "{3}x{4}-{3}x{4}x{2:0.####%}({8}{9})-{3}x{4}x{5:0.####%}\n" +
                    //    "{6:0.##}-{7:0.##}({10}0)\n", 
                    //    input_num, input_val, Constants.SERVICE_FEE, 
                    //    output_num, output_val, Constants.TAX, 
                    //    ret_output, ret_input,
                    //    (input * Constants.SERVICE_FEE > minfee?">": "<"), minfee,
                    //    (resultVal > 0 ? ">" : "<"));
                }

            }
            catch (Exception)
            {
                Result.Text = "Type Errorr";
                Detail.Text = "";
            }
        }

    }
}
