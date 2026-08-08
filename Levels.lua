local CONTRASENA_CORRECTA = "43 7A 72 30 39"  

local LINK_CREADOR = "http://t.me/Czr09M"
local LINK_GRUPO = "https://t.me/+vb2TQCYreh0xYTU5"

local anioExp = 2026
local mesExp = 08
local diaExp = 22

function obtenerFechaActual()
    local response = gg.makeRequest("https://worldtimeapi.org/api/timezone/Etc/UTC")
    if response and response.content then
        local datetime = response.content:match('"datetime":"([^"]+)"')
        if datetime then
            local y, m, d = datetime:match("(%d+)-(%d+)-(%d+)")
            return tonumber(y), tonumber(m), tonumber(d)
        end
    end
    local fechaLocal = os.date("*t")
    return fechaLocal.year, fechaLocal.month, fechaLocal.day
end

local aActual, mActual, dActual = obtenerFechaActual()
local fechaActualNum = (aActual * 10000) + (mActual * 100) + dActual
local fechaExpNum = (anioExp * 10000) + (mesExp * 100) + diaExp

if fechaActualNum > fechaExpNum then
    local btn = gg.alert("❌ Este script ha expirado.\n\nPara Renovar la Suscripción del Script Contáctame en Telegram:\n" .. LINK_CREADOR, "Copiar Link", "Salir")
    if btn == 1 then
        gg.copyText(LINK_CREADOR)
        gg.toast("📋 Link copiado al portapapeles")
    end
    os.exit()
end

local input = gg.prompt({"🔐 Introduce la contraseña para usar el script:"}, {""}, {"number"})

if not input or input[1] ~= CONTRASENA_CORRECTA then
    local btn = gg.alert("❌ Contraseña incorrecta. Acceso denegado.\n\nLa contraseña estará en este grupo:\n" .. LINK_GRUPO, "Copiar Link", "Salir")
    if btn == 1 then
        gg.copyText(LINK_GRUPO)
        gg.toast("📋 Link copiado al portapapeles")
    end
    os.exit()
end

gg.setVisible(false)

local libName = "libMyGame.so"

function getLibBase(name)
    local ranges = gg.getRangesList(name)
    if ranges == nil or #ranges == 0 then return nil end
    
    for i, v in ipairs(ranges) do
        if v.type:sub(2, 2) == 'x' then 
            return v.start
        end
    end
    
    return ranges[1].start
end

local base = getLibBase(libName)

if not base then
    gg.alert("❌ No se pudo obtener la base de '" .. libName .. "'.")
    os.exit()
end

local patches = {
    { offset = 0x123CD24, hex = "80 2F 80 D2 C0 03 5F D6" }, 
    { offset = 0x123CED8, hex = "C0 03 80 D2 C0 03 5F D6" },
    { offset = 0x1105C84, hex = "00 6C 9C D2 C0 02 A0 F2 C0 03 5F D6" }
}

for _, patch in ipairs(patches) do
    local targetAddr = base + patch.offset
    local bytesToSet = {}
    local index = 0
    
    for hexByte in patch.hex:gmatch("%S+") do
        table.insert(bytesToSet, {
            address = targetAddr + index,
            flags = gg.TYPE_BYTE,
            value = "h " .. hexByte
        })
        index = index + 1
    end
    
    gg.setValues(bytesToSet)
end

gg.clearResults()

local btnExito = gg.alert("✅ ¡El script se ejecutó correctamente!\n\nSe han completado todos los niveles de la Campaña y has obtenido el Rango Divino Bombardero.\n\n📢 Para más Hacks estarán en este grupo:\n" .. LINK_GRUPO, "Copiar Link", "OK")
if btnExito == 1 then
    gg.copyText(LINK_GRUPO)
    gg.toast("📋 Link copiado al portapapeles")
end

gg.toast("Esto fue un script hecho por Czr09")
gg.sleep(3000)
os.exit()
