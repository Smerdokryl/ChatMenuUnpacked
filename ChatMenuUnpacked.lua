local _, ChatFrameMenuButtonMixin_OnLoad = ...

local ChatMenuUnpacked = {
	{ -- Language "Æ"
		"\195\134", {'Fonts\\morpheus.ttf', 18, ''}, nil,
		function(dropdown, rootDescription)
			rootDescription:AddInitializer(ChatFrameMenuButtonMixin_OnLoad.ColorInitializer);

			for i = 1, GetNumLanguages() do
				local language, languageID = GetLanguageByIndex(i);
				local languageData = {language, languageID};
				rootDescription:CreateRadio(language, ChatFrameMenuButtonMixin_OnLoad.IsLanguageSelected, ChatFrameMenuButtonMixin_OnLoad.SetLanguageSelected, languageData);
			end
		end
	},
	{ -- Voice Emote "♫"
		"\226\153\171", {'Fonts\\arialn.ttf',   18, ''}, nil,
		function(dropdown, rootDescription)
			rootDescription:AddInitializer(ChatFrameMenuButtonMixin_OnLoad.ColorInitializer);

			ChatFrameMenuButtonMixin_OnLoad.AddEmotes(rootDescription, TextEmoteSpeechList, function(index)
				local emote = TextEmoteSpeechList[index];
				if (emote == EMOTE454_TOKEN) or (emote == EMOTE455_TOKEN) then
					local faction = UnitFactionGroup("player", true);
					if faction == "Alliance" then
						emote = EMOTE454_TOKEN;
					elseif faction == "Horde" then
						emote = EMOTE455_TOKEN;
					end
				end
				DoEmote(emote);
			end);
		end
	},
	{ -- Emote "☻"
		"\226\152\187", {'Fonts\\arialn.ttf',   22, ''}, {-1.5, 2.25},
		function(dropdown, rootDescription)
			ChatFrameMenuButtonMixin_OnLoad.AddEmotes(rootDescription, EmoteList, function(index)
				DoEmote(EmoteList[index]);
			end);
		end
	}
};

local anchor = ChatFrameMenuButton;
for _, entry in ipairs(ChatMenuUnpacked) do
	local text, font, textPos, setupMenu = unpack(entry);
	local button = CreateFrame("DropdownButton", nil, ChatFrame1ButtonFrame, 'ChatMenuUnpacked_ButtonTemplate');

	button:SetText(text);
	button.Text:SetTextColor(207/255, 175/255, 16/255);
	button.Text:SetFont(unpack(font));
	if textPos then button.Text:SetPoint('CENTER', button, 'CENTER', unpack(textPos)) end

	button:SetPoint('BOTTOM', anchor, 'TOP', 0, 2);
	anchor = button;

	button:SetupMenu(setupMenu);
end
