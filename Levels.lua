local targetLib = gg.getRangesList('libMyGame.so')
local telegramLink = "https://t.me/+vb2TQCYreh0xYTU5" -- Reemplaza con tu enlace de Telegram

if #targetLib == 0 then

    local libErrorText = "❌ ERROR: No se encontró la librería 'libMyGame.so'.\n\n"
        .. "• Asegúrate de tener el juego abierto.\n"
        .. "• Verifica que estés usando el APK correcto \n(Enviado en el grupo de Telegram).\n\n"
        .. "📢 Grupo de Telegram:\n"
        .. telegramLink

    gg.alert(libErrorText, "VALE")
    gg.copyText(telegramLink)
    gg.toast("📋 ¡Enlace de Telegram copiado al portapapeles!")
    os.exit()
end

local base = targetLib[1].start

gg.setValues({
    {address = base + 0x123CD14 + 0, value = '52802F80h', flags = gg.TYPE_DWORD},
    {address = base + 0x123CD14 + 4, value = 'D65F03C0h', flags = gg.TYPE_DWORD},

    {address = base + 0x123CEC8 + 0, value = '528003C0h', flags = gg.TYPE_DWORD},
    {address = base + 0x123CEC8 + 4, value = 'D65F03C0h', flags = gg.TYPE_DWORD},

    {address = base + 0x1105C74 + 0, value = '529CE300h', flags = gg.TYPE_DWORD},
    {address = base + 0x1105C74 + 4, value = 'F2A002C0h', flags = gg.TYPE_DWORD},
    {address = base + 0x1105C74 + 8, value = 'D65F03C0h', flags = gg.TYPE_DWORD}
})

local checkValues = gg.getValues({
    {address = base + 0x123CD14 + 0, flags = gg.TYPE_DWORD},
    {address = base + 0x123CEC8 + 0, flags = gg.TYPE_DWORD},
    {address = base + 0x1105C74 + 0, flags = gg.TYPE_DWORD}
})

local patchSuccess = false
if checkValues[1].value == 0x52802F80 
   and checkValues[2].value == 0x528003C0 
   and checkValues[3].value == 0x529CE300 then
    patchSuccess = true
end

if patchSuccess then
    local alertText = "✅ ¡Se han aplicado todos los parches correctamente!\n\n"
        .. "📢 Para más Hacks, únete a mi grupo de Telegram:\n"
        .. telegramLink

    gg.alert(alertText, "VALE")
else
    local errorText = "❌ ERROR: No se pudieron aplicar los parches.\n\n"
        .. "• Asegúrate de estar utilizando el APK oficial enviado en el grupo de Telegram.\n"
        .. "• Es posible que la función ya esté activa o los offsets hayan cambiado.\n\n"
        .. "📢 Consigue el APK en el grupo de Telegram:\n"
        .. telegramLink

    gg.alert(errorText, "VALE")
end

gg.copyText(telegramLink)
gg.toast("📋 ¡Enlace de Telegram copiado al portapapeles!")

os.exit()
