local function SubmenuItemsSetOnClick(submenu, func)
	for i=1,submenu.numButtons do
		_G[submenu:GetName()..'Button'..i]:SetScript('OnClick', func);
	end
end

function ChatFrame_ToggleSubMenu(button, submenu, onclick, onclick_override)
	local isShown = submenu:IsShown();

	ChatMenu:Hide();
	LanguageMenu:Hide();
	EmoteMenu:Hide();
	VoiceMacroMenu:Hide();

	if isShown then
		submenu:Hide();
		submenu:SetParent(ChatMenu);
		SubmenuItemsSetOnClick(submenu, onclick);
	else
		submenu:SetParent(button);
		submenu:ClearAllPoints();
		submenu:SetPoint('BOTTOMLEFT', button, 'BOTTOMRIGHT');
		SubmenuItemsSetOnClick(submenu, onclick_override);
		submenu:Show();
	end
end


-- LanguageMenu
function UnpackedLanguageMenu_Click(self)
	ChatMenu.chatFrame.editBox.language, ChatMenu.chatFrame.editBox.languageID = GetLanguageByIndex(self:GetID());
	LanguageMenu:Hide();
end

-- EmoteMenu
function UnpackedEmoteMenu_Click(self)
	DoEmote(EmoteList[self:GetID()]);
	EmoteMenu:Hide();
end

-- VoiceMacroMenu
function UnpackedVoiceMacroMenu_Click(self)
	local emote = TextEmoteSpeechList[self:GetID()];
	if (emote == EMOTE454_TOKEN or emote == EMOTE455_TOKEN) then
		local faction = UnitFactionGroup("player", true);
		if (faction == "Alliance") then
			emote = EMOTE454_TOKEN;
		elseif (faction == "Horde") then
			emote = EMOTE455_TOKEN;
		end
	end

	DoEmote(emote);
	VoiceMacroMenu:Hide();
end

-- Adjust minimum height of chat window
local w, h = ChatMenu.chatFrame:GetResizeBounds();
ChatMenu.chatFrame:SetResizeBounds(w, h + 38);
