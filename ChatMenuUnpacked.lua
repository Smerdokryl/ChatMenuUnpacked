ChatMenuUnpackedMixin = {};

function ChatMenuUnpackedMixin:OnLeaveMenu()
	local menu = _G[self.nested];
	menu:Hide();
	menu:ClearAllPoints();
	menu:SetParent(self.restore.parent);
	menu:SetScript('OnLeave', self.restore.OnLeave);
end

function ChatMenuUnpackedMixin:OnClick()
	PlaySound(SOUNDKIT.IG_CHAT_EMOTE_BUTTON);

	local menu = _G[self.nested];
	if menu:IsShown() then
		self:OnLeaveMenu();
		return;
	end

	-- Little hack to hide all other menus
	ChatMenu:Show();
	ChatMenu:Hide();

	menu:ClearAllPoints();
	menu:SetParent(self);
	menu:SetPoint('BOTTOMLEFT', self, 'TOPRIGHT');
	menu:SetScript('OnLeave', function(self, motion)
		if motion and not self:IsMouseOver() then
			self:GetParent():OnLeaveMenu()
		end
	end);
	menu:Show();
end

local ChatMenuUnpacked = {
	{ ChatMenuButton12, "\195\134",     {'Fonts\\morpheus.ttf', 18, ''}               }, -- Language "Æ"
	{ ChatMenuButton11, "\226\153\171", {'Fonts\\arialn.ttf',   18, ''}               }, -- Voice Emote "♫"
	{ ChatMenuButton10, "\226\152\187", {'Fonts\\arialn.ttf',   22, ''}, {-1.5, 2.25} }  -- Emote "☻"
};

local anchor = ChatFrameMenuButton;
for _, entry in ipairs(ChatMenuUnpacked) do
	local ChatMenuButton, text, font, textPos = unpack(entry);
	local button = CreateFrame("Button", nil, ChatFrame1ButtonFrame, 'ChatFrameUnpackedMenuButtonTemplate');
	button.chatFrame = ChatMenu.chatFrame;
	button.nested = ChatMenuButton.nested;

	local menu = _G[button.nested];
	button.restore = {
		parent  = menu:GetParent(),
		OnLeave = menu:GetScript('OnLeave')
	};

	button:SetText(text);
	button.Text:SetTextColor(207/255, 175/255, 16/255);
	if font then button.Text:SetFont(unpack(font)) end
	if textPos then button.Text:SetPoint('CENTER', button, 'CENTER', unpack(textPos)) end

	button:SetPoint('BOTTOM', anchor, 'TOP', 0, 2);
	anchor = button;
end
