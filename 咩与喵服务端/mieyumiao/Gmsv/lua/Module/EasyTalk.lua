--�ű�����
if type(Players)~="table" then Players={} end
if type(tab_laba)~="table" then tab_laba={} end
if type(tab_siliao)~="table" then tab_siliao={} end
if type(tab_msg)~="table" then tab_msg={} end
if type(tab_return)~="table" then tab_return={} end
if type(tab_fastlaba)~="table" then tab_fastlaba={} end
if type(tab_stoplaba)~="table" then tab_stoplaba={} end
if type(tab_talkhistory)~="table" then tab_talkhistory={} end
if type(tab_silencedtime)~="table" then tab_silencedtime={} end
if type(tab_battlehelp)~="table" then tab_battlehelp={} end
local laba_stopcount = 3		--��ֹ���ȴ���
local laba_stoptime = 60		--��ֹ����ʱ��
local battle_remotepk = -2
local battle_watchpkA = -2
local battle_watchpkB = -2
tbl_joinPlayer={};
pvp_watch_status=0;
local LuaTalkList = {
			{"/ָ�� /���� /help���г����п��õ�LuaTalkָ��", 0},
			{"/ʱ�� /time����ʾ��ǰ����������ʱ��", 0},
			{"/���� /fame����ʾ��ҵ�ǰ����ֵ", 0},
			{"/�㵵 /petc�������������г���ĵ���", 0},
			{"/ι�� /ιʳ /pete���򿪳���ιʳ������ǿ��������", 0},
			{"/ǩ�� /sign����ÿ��ǩ���˵�", 1},
			{"/���� /bank������ҵ���в˵�", 1},
			{"/ս�� /dp����DPս���̵�˵�", 1},
			{"/���� /football��������˵�", 1},
			{"/���� /laba������ȫ�����ȹ���", 0},
			{"/˽�� /m������ҷ���˽����Ϣ", 0},
			{"/������ /1�������п���", 0},
			{"/���� /2���������н���ս��", 0},
			{"/���ȿ��� /3���������ر�����Ƶ�����رպ��޷�ʹ�ã�", 0},
			{"/���濪�� /5���������رջ����Ƶ��", 0},
			{"/˽�Ŀ��� /4���������ر�˽��Ƶ�����رպ��޷�ʹ�ã�", 0},
			{"/������� /list���г����е�ǰ������ҵ����֡�����", 0},
			{"/������������������������������10���ڵǳ�", 1},
			{"/�س� /home���������ط����Ƕ��ţ����������꣨�޷���ӣ�", 0},
			{"/���� /back���������ػس�֮ǰ�����꣨����޷�ʹ�ã�", 0},
			{"/��ս������һ��ȫ����ս�������һ�α��˷����ȫ����ս", 0},
			{"/��ս���ۿ����ڽ��е�ȫ����ս", 0}
			}

--ע��ȫ��˵��ί��
Delegate.RegDelTalkEvent("EasyTalkEvent");

--
function EasyTalkEvent(_PlayerIndex,_msg,_color,_range,_size)
	

	print(Char.GetData(_PlayerIndex, %����_����%) .. Char.GetData(_PlayerIndex, %����_GM%) .. "��" .. _msg)
	--TalkMsg = string.sub(_msg,3)
	local TalkMsg = _msg
	local TalkColor = _color
	local TalkRange = _range
	local TalkSize = _size
	local toStr = ""
----------------------
--TalkSilenced Start--
----------------------
	if (Char.GetData(_PlayerIndex,%����_GM%)<100) then
		local tKey = getTabKey(_PlayerIndex)
		if tab_silencedtime[tKey]~=nil and tab_silencedtime[tKey]>=os.time() then
			NLG.TalkToCli(_PlayerIndex, nil, "[ϵͳ] ��˵��̫���ˣ�����Ϣ " .. tab_silencedtime[tKey]-os.time() .. " �롣", 4, 1);
			--NLG.TalkToCli(_PlayerIndex, nil, "[ϵͳ] ��˵��̫���ˣ�����Ϣһ�¡�", 4, 1);
			return 0
		end
		if type(tab_talkhistory[tKey])~="table" then tab_talkhistory[tKey]={} end
		tab_talkhistory[tKey].TalkD = tab_talkhistory[tKey].TalkC
		tab_talkhistory[tKey].TimeD = tab_talkhistory[tKey].TimeC
		tab_talkhistory[tKey].TalkC = tab_talkhistory[tKey].TalkB
		tab_talkhistory[tKey].TimeC = tab_talkhistory[tKey].TimeB
		tab_talkhistory[tKey].TalkB = tab_talkhistory[tKey].TalkA
		tab_talkhistory[tKey].TimeB = tab_talkhistory[tKey].TimeA
		tab_talkhistory[tKey].TalkA = TalkMsg
		tab_talkhistory[tKey].TimeA = os.time()
		--5���ڣ�������4����ͬ�����ݣ�����60��
		--3���ڣ�����˵��4�Σ�����10��
		--1���ڣ�����˵��3����ͬ�����ݣ�����3��
		if tab_talkhistory[tKey].TimeB~=nil and os.time()-tab_talkhistory[tKey].TimeB<=1 and tab_talkhistory[tKey].TalkA==TalkMsg and tab_talkhistory[tKey].TalkB==TalkMsg then
			tab_silencedtime[tKey] = os.time() + 3
		elseif tab_talkhistory[tKey].TimeC~=nil and os.time()-tab_talkhistory[tKey].TimeC<=3 then
			tab_silencedtime[tKey] = os.time() + 10
		elseif tab_talkhistory[tKey].TimeC~=nil and os.time()-tab_talkhistory[tKey].TimeC<=5 and tab_talkhistory[tKey].TalkA==TalkMsg and tab_talkhistory[tKey].TalkB==TalkMsg and  tab_talkhistory[tKey].TalkC==TalkMsg then
			tab_silencedtime[tKey] = os.time() + 60
		end
	end
--------------------
--TalkSilenced End--
--------------------	
	
-----------------
--LuaTalk Start--
-----------------
	if TalkMsg=="/gm" or TalkMsg=="/ducky" then	
		if (Char.GetData(_PlayerIndex,%����_GM%)<100) then
			NLG.SystemMessage(_PlayerIndex, "[ϵͳ] �㲻��GM���޷�ʹ�ô˹���")
			return 0
		end
	
		return 0
	elseif string.find(TalkMsg, "/lua ")~=nil or string.find(TalkMsg, "/���� ")~=nil then	
		if (Char.GetData(_PlayerIndex,%����_GM%)<100) then
			NLG.SystemMessage(_PlayerIndex, "[ϵͳ] �㲻��GM���޷�ʹ�ô˹���")
			return 0
		end
		if string.find(TalkMsg, "/lua ")~=nil then
			toStr = string.sub(TalkMsg,string.len("/lua ")+1)
		else
			toStr = string.sub(TalkMsg,string.len("/���� ")+1)
		end
		f = loadstring(toStr)
		print("Lua�ű�������䣺 " .. toStr)
		print("Lua�ű����Խ����")
		f()
		print("Lua�ű����Խ�����")
		
		return 0
	elseif TalkMsg== "/help" or TalkMsg== "/h" or TalkMsg=="/ָ��" or TalkMsg=="/����" then
		local MyLuaTalkLevel = Char.GetData(_PlayerIndex,%����_GM%)
		NLG.TalkToCli(_PlayerIndex, -1, "[ϵͳ] �����㹻Ȩ��ʹ�õ�LuaTalkָ�����£�", 4, 1)
		for i = 1, table.getn(LuaTalkList) do
			if LuaTalkList[i][2]<=MyLuaTalkLevel then
				NLG.TalkToCli(_PlayerIndex, nil, LuaTalkList[i][1], 4, 1)
			end
		end
		return 0
	elseif TalkMsg=="/ʱ��" or TalkMsg=="/time" then
		NLG.TalkToCli(_PlayerIndex, nil, "[ϵͳ] ��ǰϵͳʱ�䣺" ..os.date("%Y��%m��%d�� %X"), 4, 1);
		return 0
	elseif TalkMsg=="/����" or TalkMsg=="/fame" then
		local tFame = Char.GetData(_PlayerIndex, %����_����%)
		local tFameMax = Char.GetData(_PlayerIndex, %����_����������%)
		NLG.TalkToCli(_PlayerIndex, nil, "[ϵͳ] �㵱ǰ����Ϊ[" .. tFame .. "]�㣬����������ȡ����[" .. tFameMax .. "]�㡣", 4, 1)
		return 0
	elseif TalkMsg=="/�㵵" or TalkMsg=="/petc" then
		PetPlus_ShowCalc(_PlayerIndex)
		return 0
	elseif TalkMsg=="/ιʳ" or TalkMsg=="/ι��" or TalkMsg=="/ι��" or TalkMsg=="/����" or TalkMsg=="/pete" or TalkMsg=="/peteat" or TalkMsg=="/eatpet" then
		PetPlus_Talked( CastleAttackNPC, _PlayerIndex)
		return 0
	elseif TalkMsg=="/ǩ��" or TalkMsg=="/sign" then
		NLG.SystemMessage(_PlayerIndex,"[ϵͳ] ���޴˹��ܡ���");
		return 0
	elseif TalkMsg=="/����" or TalkMsg=="/bank" then
		NLG.SystemMessage(_PlayerIndex,"[ϵͳ] ���޴˹��ܡ���");
		return 0
	elseif TalkMsg=="/����" or TalkMsg=="/football" then
		NLG.SystemMessage(_PlayerIndex,"[ϵͳ] ���޴˹��ܡ���");
		return 0
	elseif TalkMsg=="/ս��" or TalkMsg=="/dp" then
		NLG.SystemMessage(_PlayerIndex,"[ϵͳ] ���޴˹��ܡ���");
		return 0
	elseif TalkMsg=="/����" or TalkMsg=="/judge" or TalkMsg=="/ju" then
		local Count = 0
		for ItemSlot = 8,27 do
			local ItemIndex = Char.GetItemIndex(_PlayerIndex, ItemSlot)
			if Item.GetData(ItemIndex, %����_�Ѽ���%)==0 then
				Count = Count + 1
				Item.SetData(ItemIndex, %����_�Ѽ���%, 1)
				NLG.SystemMessage(_PlayerIndex,"[ϵͳ] �����ϵ� " .. Item.GetData(ItemIndex, %����_��ǰ��%) .. "�Ѽ���Ϊ " .. Item.GetData(ItemIndex, %����_����%))
				Item.UpItem(_PlayerIndex, ItemSlot)
			end
		end
		if Count==0 then
			NLG.SystemMessage(_PlayerIndex,"[ϵͳ] ������û����Ҫ��������Ʒ")
		end
		return 0
	elseif TalkMsg=="/����" then
		NLG.SystemMessage(_PlayerIndex,"[ϵͳ] ���޴˹��ܡ���");
		return 0
	elseif TalkMsg=="/�˳�ս��" or TalkMsg=="/exitbattle" then
		Battle.ExitBattle(_PlayerIndex);
		return 0
	elseif TalkMsg=="/�������"or TalkMsg=="/list" then
		NLG.SystemMessage(_PlayerIndex, "[��������б�] �嵥���£�");
		for Key,Value in pairs(Players) do
			local tName = Char.GetData(Value.Index, %����_ԭ��%)
			local tLv = Char.GetData(Value.Index, %����_�ȼ�%)
			--NLG.SystemMessage(_PlayerIndex, "[" .. Value.Index .. "]" .. tName .. "(Lv." .. tLv .. ") At " .. Char.GetData(Value.Index, %����_��ͼ%) .. "." .. Char.GetData(Value.Index, %����_X%) .. "." .. Char.GetData(Value.Index, %����_Y%));
			NLG.SystemMessage(_PlayerIndex, "[" .. Value.Index .. "]" .. tName .. "(Lv." .. tLv .. ") At " .. NLG.GetMapName(Char.GetData(Value.Index, %����_MAP%),Char.GetData(Value.Index, %����_��ͼ%)));
		end
		return 0
	elseif TalkMsg=="/����" or TalkMsg=="/lists" or TalkMsg=="/l" then
		if (Char.GetData(_PlayerIndex,%����_GM%)<100) then
			NLG.SystemMessage(_PlayerIndex, "[ϵͳ] �㲻��GM���޷�ʹ�ô˹���")
			return 0
		end
		NLG.SystemMessage(_PlayerIndex, "[�߼���������б�] �嵥���£�");
		--123
		--456
		for Key,Value in pairs(Players) do
			local tName = Char.GetData(Value.Index, %����_ԭ��%)   --Name
			local tLv = Char.GetData(Value.Index, %����_�ȼ�%)    --Lv
			local BattleStat = " [B" .. Char.GetData(Value.Index, %����_ս����%) .. "]"
			if Char.GetData(Value.Index, %����_ս����%)<=0 then BattleStat = "" end
			--123
			--456
			NLG.SystemMessage(_PlayerIndex, "[" .. Value.Index .. "][" .. Value.CdKey .. "]" .. tName .. "(Lv." .. tLv .. ") At " .. NLG.GetMapName(Char.GetData(Value.Index, %����_MAP%),Char.GetData(Value.Index, %����_��ͼ%)) .. " [" .. Char.GetData(Value.Index, %����_MAP%) .. "]" .. Char.GetData(Value.Index, %����_��ͼ%) .. "." .. Char.GetData(Value.Index, %����_X%) .. "." .. Char.GetData(Value.Index, %����_Y%) .. BattleStat);
		end
		return 0
	elseif string.find(TalkMsg, "/��� ")~=nil or string.find(TalkMsg, "/join ")~=nil or string.find(TalkMsg, "/j ")~=nil then
		NLG.SystemMessage(_PlayerIndex,"[ϵͳ] ���޴˹��ܡ���");
		return 0
	elseif string.find(TalkMsg, "/�Ӷ� ")~=nil or string.find(TalkMsg, "/���� ")~=nil or string.find(TalkMsg, "/tojoin ")~=nil or string.find(TalkMsg, "/tj ")~=nil then
		NLG.SystemMessage(_PlayerIndex,"[ϵͳ] ���޴˹��ܡ���");
		return 0
	elseif string.find(TalkMsg, "/�ٻ� ")~=nil or string.find(TalkMsg, "/call ")~=nil or string.find(TalkMsg, "/c ")~=nil then
		NLG.SystemMessage(_PlayerIndex,"[ϵͳ] ���޴˹��ܡ���");
		return 0
	elseif string.find(TalkMsg, "/���� ")~=nil or string.find(TalkMsg, "/follow ")~=nil or string.find(TalkMsg, "/f ")~=nil then
		NLG.SystemMessage(_PlayerIndex,"[ϵͳ] ���޴˹��ܡ���");
		return 0
	elseif TalkMsg=="/����" or TalkMsg=="/sos" or TalkMsg=="/s" then
		NLG.SystemMessage(_PlayerIndex,"[ϵͳ] ���޴˹��ܡ���");
		return 0
	elseif string.find(TalkMsg, "/��ս ")~=nil or string.find(TalkMsg, "/joinbattle ")~=nil or string.find(TalkMsg, "/tobattle ")~=nil or string.find(TalkMsg, "/jb ")~=nil or string.find(TalkMsg, "/tb ")~=nil then
		--123
		--456
		local CdKey = Char.GetData(_PlayerIndex,%����_CDK%);
		local toStr = ""
		if string.find(TalkMsg, "/��ս ")~=nil then
			toStr = string.sub(TalkMsg,string.len("/��ս ")+1)
		elseif string.find(TalkMsg, "/joinbattle ")~=nil then
			toStr = string.sub(TalkMsg,string.len("/joinbattle ")+1)
		elseif string.find(TalkMsg, "/tobattle ")~=nil then
			toStr = string.sub(TalkMsg,string.len("/tobattle ")+1)
		elseif string.find(TalkMsg, "/jb ")~=nil then
			toStr = string.sub(TalkMsg,string.len("/jb ")+1)
		elseif string.find(TalkMsg, "/tb ")~=nil then
			toStr = string.sub(TalkMsg,string.len("/tb ")+1)
		end
		local toPlayer = toStr
		local toCdKey = -1
		for k,v in pairs(Players) do
			if v.Index==tonumber(toPlayer) or v.Name==toPlayer or k==toPlayer then 
				toCdKey=k
			end
		end
		if toCdKey~=-1 then
			if toCdKey==Char.GetData(_PlayerIndex,%����_CDK%) then
				NLG.SystemMessage(_PlayerIndex,"[ϵͳ] �����Լ������Լ���ս����")
				return 0
			end
			--123
			--456
			if Char.GetData(_PlayerIndex,%����_GM%)<=0 and tab_battlehelp[toCdKey]~=nil then
				NLG.SystemMessage(_PlayerIndex,"[ϵͳ] �Է�û�п���ս���������޷�ʹ�ò�ս���ܡ�")
				return 0
			end
			if Char.GetData(Players[toCdKey]["Index"], %����_ս����%)~=2 then
				NLG.SystemMessage(_PlayerIndex,"[ϵͳ] �Է�����ս���У��޷�ʹ�ò�ս���ܡ�")
				return 0
			end

			--Char.Warp( _PlayerIndex, Char.GetData(Players[toCdKey]["Index"], %����_MAP%), Char.GetData(Players[toCdKey]["Index"], %����_��ͼ%), Char.GetData(Players[toCdKey]["Index"], %����_X%), Char.GetData(Players[toCdKey]["Index"], %����_Y%))
			--Char.JoinParty(_PlayerIndex, Players[toCdKey]["Index"])
			
			Battle.JoinBattle(Players[toCdKey]["Index"], _PlayerIndex)
			
			NLG.SystemMessage(Players[toCdKey]["Index"], "[ϵͳ] " .. Char.GetData(_PlayerIndex, 2000) .. " �Ѳμ�ս��")
			NLG.SystemMessage(_PlayerIndex, "[ϵͳ] ���Ѽ��� " .. Players[toCdKey]["Name"] .. " ��ս��")
		else
			NLG.SystemMessage(_PlayerIndex,"[ϵͳ] û���ҵ�����һ����Ҳ����ߡ�")
		end
		return 0
	elseif string.find(TalkMsg, "/���� ")~=nil or string.find(TalkMsg, "/gift ")~=nil or string.find(TalkMsg, "/g ")~=nil then
		NLG.SystemMessage(_PlayerIndex,"[ϵͳ] ���޴˹��ܡ���");	
		return 0
	elseif string.find(TalkMsg, "/���� ")~=nil or string.find(TalkMsg, "/silence ")~=nil or string.find(TalkMsg, "/s ")~=nil then
		if (Char.GetData(_PlayerIndex,%����_GM%)<100) then
			NLG.SystemMessage(_PlayerIndex,"[ϵͳ] �㲻��GM���޷�ʹ�ô˹���")
			return 0
		end
		local CdKey = Char.GetData(_PlayerIndex,%����_CDK%);
		local toStr = ""
		if string.find(TalkMsg, "/���� ")~=nil then
			toStr = string.sub(TalkMsg,string.len("/���� ")+1)
		elseif string.find(TalkMsg, "/silence ")~=nil then
			toStr = string.sub(TalkMsg,string.len("/silence ")+1)
		elseif string.find(TalkMsg, "/s ")~=nil then
			toStr = string.sub(TalkMsg,string.len("/s ")+1)
		end
		local toSplit = string.find(toStr, " ")
		local toPlayer = string.sub(toStr,1,toSplit-1)
		local toMsg = string.sub(toStr,toSplit+1)
		local toCdKey = -1
		for k,v in pairs(Players) do
			if v.Index==tonumber(toPlayer) or v.Name==toPlayer or k==toPlayer then 
				toCdKey=k
			end
		end
		if toCdKey~=-1 then
			local sTime = tonumber(toMsg)
			local tKey = getTabKey(Players[toCdKey]["Index"])
			tab_silencedtime[tKey] = os.time() + sTime
			NLG.SystemMessage(Players[toCdKey]["Index"], "[ϵͳ] �㱻������ " .. sTime .. " �롣")
			NLG.SystemMessage(_PlayerIndex,"[ϵͳ] ���[" .. Players[toCdKey]["Index"] .."]" .. Players[toCdKey]["Name"] .. "�������� " .. sTime .. " �롣")
		elseif toPlayer=="all" or toPlayer=="All" or toPlayer=="ȫ��" or toPlayer=="ȫ" then
			for k,v in pairs(Players) do
				local sTime = tonumber(toMsg)
				local tKey = getTabKey(Players[toCdKey]["Index"])
				tab_silencedtime[tKey] = os.time() + sTime
				NLG.SystemMessage(v.Index, "[ϵͳ] �㱻������ " .. sTime .. "�롣")
			end
			NLG.SystemMessage(_PlayerIndex,"[ϵͳ] �Ѹ�����������ҽ����� " .. sTime .. " �롣")
		else
			NLG.SystemMessage(_PlayerIndex,"[ϵͳ] û���ҵ�����һ����Ҳ����ߡ�")
		end
		return 0
	elseif TalkMsg=="/�س�" or TalkMsg=="/home" then
		Char.DischargeParty(_PlayerIndex)
		local CdKey = Char.GetData(_PlayerIndex,2002);
		tab_return[CdKey] = {MapType = Char.GetData(_PlayerIndex, %����_MAP%), MapId = Char.GetData(_PlayerIndex, %����_��ͼ%), PosX = Char.GetData(_PlayerIndex,%����_X%), PosY = Char.GetData(_PlayerIndex, %����_Y%)}
		NLG.SystemMessage(_PlayerIndex,"[ϵͳ] �������뿪��ǧ��֮�⡭���ص������桭��")
		Char.Warp(_PlayerIndex, 0, 1000, 242, 88)
		return 0
	elseif TalkMsg=="/����"or TalkMsg=="/back" then
		Char.DischargeParty(_PlayerIndex)
		--123
		--456
		--789
		local CdKey = Char.GetData(_PlayerIndex,%����_CDK%);
		if tab_return[CdKey]~=nil then
			local r = tab_return[CdKey]
			NLG.SystemMessage(_PlayerIndex,"[ϵͳ] ���硭��ʱ�������ת�����Ϳ��Կ��ٷ���ԭ�ء���")
			Char.Warp(_PlayerIndex, r.MapType, r.MapId, r.PosX, r.PosY)
			tab_return[CdKey]=nil
		end
		return 0
	elseif TalkMsg=="/��ս" or TalkMsg=="/��ս" or TalkMsg=="/pk" then
		local CdKey = Char.GetData(_PlayerIndex,%����_CDK%)
		local Name = Char.GetData(_PlayerIndex,%����_ԭ��%)
		local Lv = Char.GetData(_PlayerIndex,%����_�ȼ�%)
		if battle_remotepk==CdKey then
			battle_remotepk=-2
			MSG("[ȫ����սϵͳ] ��� " .. Name .. "(Lv." .. Lv .. ") ȡ����ȫ����ս��")
			return 0
		elseif battle_remotepk==-2 then
			battle_remotepk = CdKey
			MSG("[ȫ����սϵͳ] ��� " .. Name .. "(Lv." .. Lv .. ") ������ȫ����ս��")
			MSG("[ȫ����սϵͳ] ������ /��ս ָ���Ӧ����ս��һ�����ۣ�")
		else
			local tName = Char.GetData(Players[battle_remotepk].Index,%����_ԭ��%)
			local tLv = Char.GetData(Players[battle_remotepk].Index,%����_�ȼ�%)
			Char.DischargeParty(Players[battle_remotepk].Index)
			Char.DischargeParty(_PlayerIndex)
			local BattleIndex = Battle.PVP(Players[battle_remotepk].Index, _PlayerIndex)
			Battle.SetType(BattleIndex, %ս��_��ͨ%)
			Battle.SetGainMode(BattleIndex, %ս��_��ͨ%)
			Battle.SetNORisk(BattleIndex, 1)
			MSG("[ȫ����սϵͳ] ��� " .. Name .. "(Lv." .. Lv .. ") ��Ӧ��" .. tName .. "(Lv." .. tLv .. ")��ȫ����ս��")
			MSG("[ȫ����սϵͳ] ������ҿ����� /��ս ָ��ۿ��ⳡ���ʹ�ս��")
			--MSG("[ȫ����սϵͳ] ������ҿ����� /��ս " .. CdKey .. " ָ��ۿ��ⳡ���ʹ�ս��")
			battle_watchpkA = Players[battle_remotepk].Index
			battle_watchpkB = _PlayerIndex
			battle_remotepk = -2
		end
		return 0
		--123
		--456
	elseif string.find(TalkMsg, "/��ս")~=nil then
		if TalkMsg=="/��ս" then
			if Char.GetData(_PlayerIndex, %����_���ģʽ%)>0 then
				NLG.SystemMessage(_PlayerIndex,"[ϵͳ] ����޷�ʹ�ô˹���")
				return
			end
			NLG.WatchBattle( _PlayerIndex, battle_watchpkA)
			NLG.WatchBattle( _PlayerIndex, battle_watchpkB)
			--123
			--456
			local Name = Char.GetData(_PlayerIndex,%����_ԭ��%)
			local Lv = Char.GetData(_PlayerIndex,%����_�ȼ�%)
			NLG.TalkToCli(battle_watchpkA, nil, "[ȫ����սϵͳ] ��� " .. Name .. "(Lv." .. Lv .. ") ���ڹۿ����ȫ����ս��",4,1)
			NLG.TalkToCli(battle_watchpkB, nil, "[ȫ����սϵͳ] ��� " .. Name .. "(Lv." .. Lv .. ") ���ڹۿ����ȫ����ս��",4,1)
		elseif string.find(TalkMsg, "/��ս ")~=nil then
			if string.find(TalkMsg, "/��ս ")~=nil then
				toStr = string.sub(TalkMsg,string.len("/��ս ")+1)
			elseif string.find(TalkMsg, "/watch ")~=nil then
				toStr = string.sub(TalkMsg,string.len("/watch ")+1)
			elseif string.find(TalkMsg, "/w ")~=nil then
				toStr = string.sub(TalkMsg,string.len("/w ")+1)
			end
			--local toSplit = string.find(toStr, " ")
			--local toPlayer = string.sub(toStr,1,toSplit-1)
			local toPlayer = toStr
			local toCdKey = -1
			for k,v in pairs(Players) do
				if v.Index==tonumber(toPlayer) or v.Name==toPlayer or k==toPlayer then 
					toCdKey=k
				end
			end
			if toCdKey~=-1 then
				rt = NLG.WatchBattle(_PlayerIndex, Players[toCdKey].Index)
				if rt==1 then
					--123
					--454
					NLG.SystemMessage(Players[toCdKey].Index, "[ϵͳ] ��� " .. Name .. "(Lv." .. Lv .. ") ���ڹۿ����ս����")
					NLG.SystemMessage(_PlayerIndex,"[ϵͳ] �����ڹۿ���� " .. Char.GetData(Players[toCdKey].Index,%����_ԭ��%) .. "(Lv." .. Char.GetData(Players[toCdKey].Index,%����_�ȼ�%) .. ") ��ս��")
				end
			else
				NLG.SystemMessage(_PlayerIndex,"[ϵͳ] û�иñ�Ż��ʺŵ������ս���У��޷���ս��")
			end
		end
		return 0
	elseif string.find(TalkMsg, "/˽�� ")~=nil or string.find(TalkMsg, "/m ")~=nil then
		--123
		--456
		local CdKey = Char.GetData(_PlayerIndex,%����_CDK%);
		if tab_laba[CdKey]==nil then
			NLG.SystemMessage(_PlayerIndex,"[ϵͳ] ���˽��Ƶ���ѹرգ��޷�ʹ��˽�Ĺ��ܡ����� /˽�Ŀ��� ���´򿪡�")
			return 0			
		end
		local toStr = ""
		if string.find(TalkMsg, "/˽�� ")~=nil then
			toStr = string.sub(TalkMsg,string.len("/˽�� ")+1)
		elseif string.find(TalkMsg, "/m ")~=nil then
			toStr = string.sub(TalkMsg,string.len("/m ")+1)
		end
		local toSplit = string.find(toStr, " ")
		local toPlayer = string.sub(toStr,1,toSplit-1)
		local toMsg = string.sub(toStr,toSplit+1)
		local toCdKey = -1
		for k,v in pairs(Players) do
			if v.Index==tonumber(toPlayer) or v.Name==toPlayer or k==toPlayer then 
				toCdKey=k
			end
		end
		if toCdKey~=-1 then
			if tab_siliao[toCdKey]~=nil then
				NLG.SystemMessage(Players[toCdKey]["Index"], "[˽��] " .. Char.GetData(_PlayerIndex,%����_ԭ��%) .. "��" .. toMsg)
				NLG.SystemMessage(_PlayerIndex,"[˽��] ��Ϣ�ѷ���")
			else
				NLG.SystemMessage(_PlayerIndex,"[ϵͳ] �Է�û�п���˽��Ƶ����")
			end
		elseif toCdKey==Char.GetData(_PlayerIndex,%����_CDK%) then
			NLG.SystemMessage(_PlayerIndex,"[ϵͳ] ���ܸ��Լ�����˽����Ϣ��")
		else
			NLG.SystemMessage(_PlayerIndex,"[ϵͳ] û���ҵ�����һ����Ҳ����ߡ�")
		end
		return 0
	elseif string.find(TalkMsg, "/���� ")~=nil or string.find(TalkMsg, "/laba ")~=nil then
		local m = ""
		local CdKey = Char.GetData(_PlayerIndex,%����_CDK%);
		if tab_laba[CdKey]==nil then
			NLG.SystemMessage(_PlayerIndex,"[ϵͳ] �������Ƶ���ѹرգ��޷�ʹ�����ȹ��ܡ����� /���ȿ��� ���´򿪡�")
			return 0
		end
		if string.find(TalkMsg, "/���� ")~=nil then
			m = string.gsub(TalkMsg, "/���� ", 1)
		elseif string.find(TalkMsg, "/laba ")~=nil then
			m = string.gsub(TalkMsg, "/laba ", 1)
		end
		m = string.sub(m,2)
		for k,v in pairs(tab_laba) do
			NLG.SystemMessage(v, "[����] " .. Char.GetData(_PlayerIndex, %����_ԭ��%) .. "��" .. m)
		end
		return 0
	elseif TalkMsg=="/1" or TalkMsg=="/������" then
		--123
		--456
		if (Char.GetData(_PlayerIndex, %����_�����п���%)==1) then
			Char.SetData(_PlayerIndex, %����_�����п���%, 0)
			NLG.SystemMessage(_PlayerIndex,"[ϵͳ] �������Ѿ��ر�")
		elseif (Char.GetData(_PlayerIndex, %����_�����п���%)==0) then
			Char.SetData(_PlayerIndex, %����_�����п���%, 1)
			NLG.SystemMessage(_PlayerIndex,"[ϵͳ] �������Ѿ���")
		end
		return 0
	elseif TalkMsg=="/2" or TalkMsg=="/����" then
		local rt = Battle.Encount(_PlayerIndex,_PlayerIndex)
		if rt > 0 then
			NLG.SystemMessage(_PlayerIndex,"[ϵͳ] ս���ɣ��ŵ��ȵ�ʥ��ʿ����")
		else
			NLG.SystemMessage(_PlayerIndex,"[ϵͳ] �˴��о������������Ϣ����")
		end
		return 0
	elseif TalkMsg=="/3" or TalkMsg=="/���ȿ���" then
		local CdKey = Char.GetData(_PlayerIndex,%����_CDK%);
		if tab_laba[CdKey]==nil then
			tab_laba[CdKey]=_PlayerIndex
			NLG.SystemMessage(_PlayerIndex,"[ϵͳ] ����Ƶ���Ѵ�")
		elseif tab_laba[CdKey]~=nil then
			tab_laba[CdKey]=nil
			NLG.SystemMessage(_PlayerIndex,"[ϵͳ] ����Ƶ���ѹر�")
		end
		return 0
	elseif TalkMsg=="/4" or TalkMsg=="/˽�Ŀ���" then
		local CdKey = Char.GetData(_PlayerIndex,%����_CDK%);
		if tab_siliao[CdKey]==nil then
			tab_siliao[CdKey]=_PlayerIndex
			NLG.SystemMessage(_PlayerIndex,"[ϵͳ] ˽��Ƶ���Ѵ�")
		elseif tab_siliao[CdKey]~=nil then
			tab_siliao[CdKey]=nil
			NLG.SystemMessage(_PlayerIndex,"[ϵͳ] ˽��Ƶ���ѹر�")
		end
		return 0
	elseif TalkMsg=="/5" or TalkMsg=="/���濪��" then
		local CdKey = Char.GetData(_PlayerIndex,2002);
		if tab_msg[CdKey]==nil then
			tab_msg[CdKey]=_PlayerIndex
			NLG.SystemMessage(_PlayerIndex,"[ϵͳ] �����Ƶ���Ѵ�")
		elseif tab_msg[CdKey]~=nil then
			tab_msg[CdKey]=nil
			NLG.SystemMessage(_PlayerIndex,"[ϵͳ] �����Ƶ���ѹر�")
		end
		return 0
	elseif TalkMsg=="/ԭ�ؿ���" or TalkMsg=="/ԭ�ص���" or TalkMsg=="/ԭ�ص���" then
		if (Char.GetData(_PlayerIndex,%����_GM%)<100) then
			NLG.SystemMessage(_PlayerIndex,"[ϵͳ] �㲻��GM���޷�ʹ�ô˹���")
			return 0
		end
		if setting_yd==0 then
			setting_yd=1
			NLG.SystemMessage(_PlayerIndex,"[ϵͳ] ԭ�ص���ϵͳ�Ѵ�")
		elseif setting_yd==1 then
			setting_yd=0
			NLG.SystemMessage(_PlayerIndex,"[ϵͳ] ԭ�ص���ϵͳ�ѹر�")
		end
		return 0
	end
end
--------------	
--LuaTalk End
--------------

function GetMyIndex(Index)
	return Index
end

function TableListAll(sTable, sTitle, sMode)
	--if type(sTable)~="table" then return sTable end
	local TM = ""
	if sTitle==nil then sTitle="" end
	for Key,Value in pairs(sTable) do
		if type(Value)=="table" then
			TM = TM .. TableListAll(Value,sTitle .. "." .. Key,sMode)
		else
			if type(Value)=="nil" then
				Value="nil"
			elseif type(Value)=="function" then
				Value="function"
			elseif type(Value)=="boolean" then
				Value=tonumber(Value)
			end
			--Log(TM .. sTitle .. "." .. Key .. "[" .. type(Value) .. "]=" .. Value .. "\n")
		end
	end
	return 
end

function func_test(...)
	print(...)
	return
end