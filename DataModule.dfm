object DataModule1: TDataModule1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 150
  Width = 215
  object FDConnection1: TFDConnection
    ConnectionName = 'MainConnection'
    Params.Strings = (
      'DriverID=SQLite'
      
        'Database=C:\Users\HarrE\Desktop\Delphi Projects\Projects\MiniCRM' +
        '\Win32\Debug\Database\MyDB.s3db')
    Left = 72
    Top = 56
  end
  object OpenDialog: TOpenDialog
    Left = 136
    Top = 56
  end
end
