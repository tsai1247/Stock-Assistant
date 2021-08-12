using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace 股票助手
{
    /// <summary>
    /// StockList.xaml 的互動邏輯
    /// </summary>
    public partial class StockList : UserControl
    {
        ArrayList SelectData = new ArrayList();
        ArrayList InputData = new ArrayList();
        ArrayList TipData = new ArrayList();
        ArrayList NameList = new ArrayList();

        public StockList()
        {
            InitializeComponent();
            Init();
        }

        private void Init()
        {
            InputData.Add(new ArrayList());
            SelectData.Add(select_0);
            TipData.Add(tip_0);
            NameList.Add(data_name0);
            ((ArrayList)InputData[0]).Add(data_00);
            ((ArrayList)InputData[0]).Add(data_01);
            ((ArrayList)InputData[0]).Add(data_02);
            ((ArrayList)InputData[0]).Add(data_03);
            
            Calculate();
        }

        private void InputChange(object sender, TextChangedEventArgs e)
        {
            SetInputTable();

            Calculate();

        }
        private void Calculate()
        {
            float[] data = {0f, 0f, 0f, 0f};
            
            for(int i=0; i<SelectData.Count; i++)
            {
                string tipText = "";
                if ((bool)((CheckBox)SelectData[i]).IsChecked)
                {
                    for(int j=0; j<4; j+=2)
                    {
                        float eachVal = 0;
                        if (data[j] == float.MinValue)
                            continue;

                        string tmp = (((ArrayList)InputData[i])[j] as TextBox).Text;
                        string tmp2 = (((ArrayList)InputData[i])[j+1] as TextBox).Text;
                        if (tmp == "")
                            tmp = "0"; 
                        if (tmp2 == "")
                            tmp2 = "0";

                        try
                        {
                            float curVal = float.Parse(tmp) * float.Parse(tmp2);
                            eachVal += curVal;
                            if (curVal != 0)
                            {
                                if ((bool)cal_FEE.IsChecked)
                                {
                                    float minFEE;
                                    try
                                    {
                                        minFEE = float.Parse(cal_MinFEE.Text);
                                    }
                                    catch (Exception)
                                    {
                                        minFEE = 1;
                                        cal_MinFEE.Text = "1";
                                    }
                                    if (j == 0)
                                        eachVal += MathF.Max(float.Parse(tmp) * float.Parse(tmp2) * Constants.SERVICE_FEE, minFEE);
                                    else
                                        eachVal -= MathF.Max(float.Parse(tmp) * float.Parse(tmp2) * Constants.SERVICE_FEE, minFEE);


                                }
                                if ((bool)cal_TAX.IsChecked && j == 2)
                                {
                                    eachVal -= float.Parse(tmp) * float.Parse(tmp2) * Constants.TAX;
                                }
                            }
                            data[j] += eachVal;
                            if (j == 0)
                                tipText += String.Format("{1}單筆支出：{0:0.##}", eachVal, tipText == "" ? "" : "  ");
                            else
                                tipText += String.Format("{1}單筆收入：{0:0.##}", eachVal, tipText == "" ? "" : "  ");

                        }
                        catch (Exception)
                        {
                            data[j] = float.MinValue;
                        }

                        try
                        {
                            data[j + 1] += float.Parse(tmp2);
                        }
                        catch (Exception)
                        {
                            data[j+1] = float.MinValue;
                        }
                    }
                }
                try
                {
                    ((TextBlock)TipData[i]).Text = tipText;
                }
                catch (Exception)
                {
                    ((TextBlock)TipData[i]).Text = "無單筆資料";
                }
            }
            if (data[0] != float.MinValue && data[1] != 0 && data[1] != float.MinValue)
                Aver_buy_price.Text = String.Format("{0:0.##}", data[0]/data[1]);
            else
                Aver_buy_price.Text = "0";


            if (data[1] != float.MinValue)
                Aver_buy_num.Text = String.Format("{0:0.##}", data[1]);
            else
                Aver_buy_num.Text = "0";


            if (data[2] != float.MinValue && data[3] != 0 && data[3] != float.MinValue)
                Aver_sell_price.Text = String.Format("{0:0.##}", data[2] / data[3]);
            else
                Aver_sell_price.Text = "0";


            if (data[3] != float.MinValue)
                Aver_sell_num.Text = String.Format("{0:0.##}", data[3]);
            else
                Aver_sell_num.Text = "0";

            if (data[0] != float.MinValue)
                Total_buy_val.Text = String.Format("{0:0.##}", data[0]);
            else
                Total_buy_val.Text = "0";

            if (data[2] != float.MinValue)
                Total_sell_val.Text = String.Format("{0:0.##}", data[2]);
            else
                Total_sell_val.Text = "0";

            float earnPercent = (data[2] - data[0]) / data[0];

            tip_diff.Text = String.Format("{2} {0:0.##} 元({1:0.##%})", Math.Abs(data[2]-data[0]), data[0]==0?0:earnPercent, data[2]-data[0]>=0?"獲益":"損失");

        }

        private void SetInputTable()
        {
            int curIndex = InputData.Count-1;
            while (curIndex >= 0)
            {
                foreach (TextBox tb in InputData[curIndex] as ArrayList)
                {
                    if (tb.Text != "")
                    {
                        if(curIndex == InputData.Count - 1)
                            AddRow();
                        return;
                    }
                }

                if (curIndex + 1 < InputData.Count)
                {
                    RemoveRow(curIndex + 1);
                }

                curIndex--;

            }
        }

        private void RemoveRow(int curIndex)
        {
            while (grid_stocklist.RowDefinitions.Count - 1 >= InputData.Count)
            {
                grid_stocklist.RowDefinitions.RemoveAt(grid_stocklist.RowDefinitions.Count - 1);
            }

            grid_stocklist.Children.Remove(SelectData[curIndex] as CheckBox);
            SelectData.RemoveAt(curIndex);

            foreach (TextBox tb in InputData[curIndex] as ArrayList)
            {
                grid_stocklist.Children.Remove(tb);
            }
            InputData.RemoveAt(curIndex);


            grid_stocklist.Children.Remove(NameList[curIndex] as TextBox);
            NameList.RemoveAt(curIndex);

        }

        private void AddRow()
        {
            while (grid_stocklist.RowDefinitions.Count - 1 <= InputData.Count)
            {
                RowDefinition tmp = new RowDefinition();
                tmp.Height = new GridLength(45);
                tmp.MinHeight = 45;
                grid_stocklist.RowDefinitions.Add(tmp);
            }

            CheckBox checkBox = new CheckBox();
            checkBox.Name = String.Format("select_{0}", InputData.Count);
            checkBox.SetValue(CheckBox.IsCheckedProperty, title_select.IsChecked);

            TextBlock tipBlock = new TextBlock();
            tipBlock.Name = string.Format("tip_{0}", InputData.Count);
            tipBlock.Text = "";

            ToolTip tip = new ToolTip();
            tip.Placement = PlacementMode.MousePoint;
            tip.Content = tipBlock;

            checkBox.ToolTip = tip;
            TipData.Add(tipBlock);

            Grid.SetRow(checkBox, InputData.Count);
            Grid.SetColumn(checkBox, 0);

            checkBox.Click += new RoutedEventHandler(select_Click);
            checkBox.HorizontalAlignment = HorizontalAlignment.Center;
            checkBox.VerticalAlignment = VerticalAlignment.Center;


            ArrayList textboxList = new ArrayList();
            grid_stocklist.Children.Add(checkBox);


            TextBox textName = new TextBox();
            textName.Name = String.Format("data_name{0}", InputData.Count);

            Grid.SetRow(textName, InputData.Count);
            Grid.SetColumn(textName, 1);


            textName.Background = data_name0.Background;
            textName.Style = data_name0.Style;

            grid_stocklist.Children.Add(textName);
            NameList.Add(textName);

            for (int i = 0; i < 4; i++)
            {
                TextBox textBox = new TextBox();
                textBox.Name = String.Format("data_{0}{1}", InputData.Count, i);

                Grid.SetRow(textBox, InputData.Count);
                Grid.SetColumn(textBox, i + 2);


                textBox.Background = data_00.Background;
                textBox.Style = data_00.Style;
                textBox.TextChanged += new TextChangedEventHandler(InputChange);

                grid_stocklist.Children.Add(textBox);
                textboxList.Add(textBox);

            }

            SelectData.Add(checkBox);
            InputData.Add(textboxList);


        }

        private void select_Click(object sender, RoutedEventArgs e)
        {
            //if (!(bool)((CheckBox)sender).IsChecked)
            //    title_select.IsChecked = false;
            Calculate();
            title_select.IsChecked = true;

            foreach (CheckBox checkBox in SelectData)
            {
                if(!(bool)checkBox.IsChecked)
                {
                    title_select.IsChecked = false;
                    return;
                }
            }

        }

        private void title_select_Click(object sender, RoutedEventArgs e)
        {
            foreach(CheckBox checkBox in SelectData)
            {
                checkBox.IsChecked = title_select.IsChecked;
            }

            Calculate();
        }

      
    }
}
