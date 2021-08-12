using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace 股票助手
{
    class MyFunction
    {
    }

    public class FileRW
    {
        public static string[] ReadLineFile(String FilePath)
        {
            try
            {
                StreamReader reader = new StreamReader(FilePath, true);
                string[] ans = reader.ReadToEnd().Split("\r\n");
                reader.Close();
                return ans;
            }
            catch (Exception)
            {
                return new string[] { };
            }

        }

        public static void AppendLineFile(String FilePath, String Data)
        {
            StreamWriter writer = new StreamWriter(FilePath, true);
            writer.WriteLine(Data);
            writer.Close();
        }
        public static void AppendLineFile(String FilePath, String[] SpiltData)
        {
            StreamWriter writer = new StreamWriter(FilePath, true);
            foreach (String str in SpiltData)
                writer.WriteLine(str);
            writer.Close();
        }

        public static string Concat(string[] data, string concatSymbol = "\r\n")
        {
            if (data.Length == 0)
                return "";
            string ret = data[0];
            for (int i = 1; i < data.Length; i++)
            {
                if (data[i] == "") { }
                else if (data[i] == concatSymbol)
                    ret += concatSymbol;
                else
                    ret += concatSymbol + data[i];
            }
            return ret;
        }

        public static void WriteLineFile(String FilePath, String Data)
        {
            StreamWriter writer = new StreamWriter(FilePath, false);
            writer.WriteLine(Data);
            writer.Close();
        }

        public static void WriteLineFile(String FilePath, String[] SpiltData)
        {
            StreamWriter writer = new StreamWriter(FilePath, false);
            foreach (String str in SpiltData)
                writer.WriteLine(str);
            writer.Close();
        }


    }
}
