function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
  AddTextEntry('PM_SCR_MAP', '~y~<font face="sarabun">แผนที่</font>')
  AddTextEntry('PM_SCR_GAM', '~y~<font face="sarabun">เกม</font>')
  AddTextEntry('PM_SCR_INF', '~y~<font face="sarabun">สถานะ</font>')
  AddTextEntry('PM_SCR_STA', '~y~<font face="sarabun">รายละเอียด</font>')
  AddTextEntry('PM_SCR_SET', '~y~<font face="sarabun">ตั้งค่า</font>')
  AddTextEntry('PM_SCR_GAL', '~y~<font face="sarabun">แกลลอรี่</font>')
  AddTextEntry('PM_SCR_RPL', '~y~<font face="sarabun">Rockstar</font>')
end)

Citizen.CreateThread(function()
  while Config.HideHud do
    Wait(0)
    HideHudComponentThisFrame( 6 )
		HideHudComponentThisFrame( 7 )
		HideHudComponentThisFrame( 8 )
		HideHudComponentThisFrame( 9 )
  end
end)