
_G.RegisteredKeys = {}

AddEventHandler('key:register', function(layout, keyname)
	if RegisteredKeys[layout] == nil then RegisteredKeys[layout] = {} end
	if RegisteredKeys[layout][keyname] == nil then
		RegisteredKeys[layout][keyname] = true
		RegisterKeyMapping(('+keypress %s %s'):format(layout, keyname), 'Binded '..keyname, layout:upper(), keyname:upper())
	end
end)

RegisterCommand('+keypress', function(s, args)
	local layout = args[1]
	local keyname = args[2]
	if layout and keyname then
		layout, keyname = layout:lower(), keyname:lower()
		if RegisteredKeys[layout] ~= nil and RegisteredKeys[layout][keyname] ~= nil then
			TriggerEvent(('key:press:%s:%s'):format(layout, keyname))
		end
	end
end, false)

RegisterCommand('-keypress', function(s, args)
	local layout = args[1]
	local keyname = args[2]
	if layout and keyname then
		layout, keyname = layout:lower(), keyname:lower()
		if RegisteredKeys[layout] ~= nil and RegisteredKeys[layout][keyname] ~= nil then
			TriggerEvent(('key:release:%s:%s'):format(layout, keyname))
		end
	end
end, false)

_G._KEY_BINDS = {

	KEYBOARD = {
		BACK = true,
		TAB = true,
		RETURN = true,
		PAUSE = true,
		CAPITAL = true,
		ESCAPE = true,
		SPACE = true,
		PAGEUP = true,
		PRIOR = true,
		PAGEDOWN = true,
		NEXT = true,
		END = true,
		HOME = true,
		LEFT = true,
		UP = true,
		RIGHT = true,
		DOWN = true,
		SNAPSHOT = true,
		SYSRQ = true,
		INSERT = true,
		DELETE = true,
		['0'] = true,
		['1'] = true,
		['2'] = true,
		['3'] = true,
		['4'] = true,
		['5'] = true,
		['6'] = true,
		['7'] = true,
		['8'] = true,
		['9'] = true,
		A = true,
		B = true,
		C = true,
		D = true,
		E = true,
		F = true,
		G = true,
		H = true,
		I = true,
		J = true,
		K = true,
		L = true,
		M = true,
		N = true,
		O = true,
		P = true,
		Q = true,
		R = true,
		S = true,
		T = true,
		U = true,
		V = true,
		W = true,
		X = true,
		Y = true,
		Z = true,
		LWIN = true,
		RWIN = true,
		APPS = true,
		NUMPAD0 = true,
		NUMPAD1 = true,
		NUMPAD2 = true,
		NUMPAD3 = true,
		NUMPAD4 = true,
		NUMPAD5 = true,
		NUMPAD6 = true,
		NUMPAD7 = true,
		NUMPAD8 = true,
		NUMPAD9 = true,
		MULTIPLY = true,
		ADD = true,
		SUBTRACT = true,
		DECIMAL = true,
		DIVIDE = true,
		F1 = true,
		F2 = true,
		F3 = true,
		F4 = true,
		F5 = true,
		F6 = true,
		F7 = true,
		F8 = true,
		F9 = true,
		F10 = true,
		F11 = true,
		F12 = true,
		F13 = true,
		F14 = true,
		F15 = true,
		F16 = true,
		F17 = true,
		F18 = true,
		F19 = true,
		F20 = true,
		F21 = true,
		F22 = true,
		F23 = true,
		F24 = true,
		NUMLOCK = true,
		SCROLL = true,
        NUMPADEQUALS = true,
		LSHIFT = true,
		RSHIFT = true,
		LCONTROL = true,
		RCONTROL = true,
		LMENU = true,
		RMENU = true,
		SEMICOLON = true,
		OEM_1 = true,
		PLUS = true,
		EQUALS = true,
		COMMA = true,
		MINUS = true,
		PERIOD = true,
		SLASH = true,
		OEM_2 = true,
		GRAVE = true,
		OEM_3 = true,
		LBRACKET = true,
		OEM_4 = true,
		BACKSLASH = true,
		OEM_5 = true,
		RBRACKET = true,
		OEM_6 = true,
		APOSTROPHE = true,
		OEM_7 = true,
		OEM_102 = true,
		RAGE_EXTRA1 = true,
		RAGE_EXTRA2 = true,
		RAGE_EXTRA3 = true,
		RAGE_EXTRA4 = true,
		NUMPADENTER = true,
	},
}
	
function RegisterKey(layout, keyname, onpress, onrelease)
	assert(type(layout) == 'string', 'Invalid Lua type, #1 argument expected string')
	assert(type(keyname) == 'string', 'Invalid Lua type, #2 argument expected string')
	assert(type(onpress) == 'function', 'Invalid Lua type, #3 argument expected function')
	assert(onrelease ~= nil and type(onpress) == 'function' or true, 'Invalid Lua type, #4 argument expected function')

	if _KEY_BINDS[layout:upper()] ~= nil and _KEY_BINDS[layout:upper()][keyname:upper()] ~= nil then
		layout, keyname = layout:lower(), keyname:lower()
		TriggerEvent('key:register', layout, keyname)
		AddEventHandler(('key:press:%s:%s'):format(layout, keyname), onpress)
		AddEventHandler(('key:release:%s:%s'):format(layout, keyname), onrelease)
	else
		error"Layour or keyname doesn't exist!"
	end
end