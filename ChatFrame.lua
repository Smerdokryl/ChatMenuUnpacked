local _, ChatFrameMenuButtonMixin_OnLoad = ...

local function GetSelectedLanguageID()
	return DEFAULT_CHAT_FRAME.editBox.languageID;
end

ChatFrameMenuButtonMixin_OnLoad.AddEmotes =
function (description, list, func)
	for index, value in ipairs(list) do
		local i = 1;
		local token = _G["EMOTE"..i.."_TOKEN"];
		while ( i < MAXEMOTEINDEX ) do
			if ( token == value ) then
				break;
			end
			i = i + 1;
			token = _G["EMOTE"..i.."_TOKEN"];
		end

		local label = _G["EMOTE"..i.."_CMD1"] or value;
		description:CreateButton(label, function(...)
			func(index);
		end);
	end
end

ChatFrameMenuButtonMixin_OnLoad.IsLanguageSelected =
function (language)
	return GetSelectedLanguageID() == language[2];
end

ChatFrameMenuButtonMixin_OnLoad.SetLanguageSelected =
function (languageData)
	ChatEdit_SetGameLanguage(DEFAULT_CHAT_FRAME.editBox, languageData[1], languageData[2]);
end

ChatFrameMenuButtonMixin_OnLoad.ColorInitializer =
function (button, description, menu)
	button.fontString:SetTextColor(NORMAL_FONT_COLOR:GetRGB());
end
