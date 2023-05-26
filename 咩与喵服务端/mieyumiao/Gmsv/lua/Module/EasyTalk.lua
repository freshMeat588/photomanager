--脚本配置
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
local laba_stopcount = 3		--禁止喇叭次数
local laba_stoptime = 60		--禁止喇叭时间
local battle_remotepk = -2
local battle_watchpkA = -2
local battle_watchpkB = -2
tbl_joinPlayer={};
pvp_watch_status=0;
local LuaTalkList = {
			{"/指令 /帮助 /help：列出所有可用的LuaTalk指令", 0},
			{"/时间 /time：显示当前服务器日期时间", 0},
			{"/声望 /fame：显示玩家当前声望值", 0},
			{"/算档 /petc：计算身上所有宠物的档数", 0},
			{"/喂宠 /喂食 /pete：打开宠物喂食（宠物强化）界面", 0},
			{"/签到 /sign：打开每日签到菜单", 1},
			{"/银行 /bank：打开商业银行菜单", 1},
			{"/战绩 /dp：打开DP战绩商店菜单", 1},
			{"/足球 /football：打开足球菜单", 1},
			{"/喇叭 /laba：发放全服喇叭公告", 0},
			{"/私聊 /m：对玩家发送私聊信息", 0},
			{"/不遇敌 /1：不遇敌开关", 0},
			{"/遇敌 /2：立即遇敌进入战斗", 0},
			{"/喇叭开关 /3：开启、关闭喇叭频道（关闭后无法使用）", 0},
			{"/公告开关 /5：开启、关闭活动公告频道", 0},
			{"/私聊开关 /4：开启、关闭私聊频道（关闭后无法使用）", 0},
			{"/在线玩家 /list：列出所有当前在线玩家的名字、坐标", 0},
			{"/修炼：立即进行离线修炼，必须在10秒内登出", 1},
			{"/回城 /home：立即返回法兰城东门，并记下坐标（无法组队）", 0},
			{"/返回 /back：立即返回回城之前的坐标（组队无法使用）", 0},
			{"/对战：发起一次全服挑战，或参与一次别人发起的全服挑战", 0},
			{"/观战：观看正在进行的全服挑战", 0}
			}

--注册全局说话委托
Delegate.RegDelTalkEvent("EasyTalkEvent");

--
function EasyTalkEvent(_PlayerIndex,_msg,_color,_range,_size)
	

	print(Char.GetData(_PlayerIndex, %对象_名字%) .. Char.GetData(_PlayerIndex, %对象_GM%) .. "：" .. _msg)
	--TalkMsg = string.sub(_msg,3)
	local TalkMsg = _msg
	local TalkColor = _color
	local TalkRange = _range
	local TalkSize = _size
	local toStr = ""
----------------------
--TalkSilenced Start--
----------------------
	if (Char.GetData(_PlayerIndex,%对象_GM%)<100) then
		local tKey = getTabKey(_PlayerIndex)
		if tab_silencedtime[tKey]~=nil and tab_silencedtime[tKey]>=os.time() then
			NLG.TalkToCli(_PlayerIndex, nil, "[系统] 你说话太快了，请休息 " .. tab_silencedtime[tKey]-os.time() .. " 秒。", 4, 1);
			--NLG.TalkToCli(_PlayerIndex, nil, "[系统] 你说话太快了，请休息一下。", 4, 1);
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
		--5秒内，连续发4次相同的内容，禁言60秒
		--3秒内，连续说话4次，禁言10秒
		--1秒内，连续说话3次相同的内容，禁言3秒
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
		if (Char.GetData(_PlayerIndex,%对象_GM%)<100) then
			NLG.SystemMessage(_PlayerIndex, "[系统] 你不是GM，无法使用此功能")
			return 0
		end
	
		return 0
	elseif string.find(TalkMsg, "/lua ")~=nil or string.find(TalkMsg, "/调试 ")~=nil then	
		if (Char.GetData(_PlayerIndex,%对象_GM%)<100) then
			NLG.SystemMessage(_PlayerIndex, "[系统] 你不是GM，无法使用此功能")
			return 0
		end
		if string.find(TalkMsg, "/lua ")~=nil then
			toStr = string.sub(TalkMsg,string.len("/lua ")+1)
		else
			toStr = string.sub(TalkMsg,string.len("/调试 ")+1)
		end
		f = loadstring(toStr)
		print("Lua脚本调试语句： " .. toStr)
		print("Lua脚本调试结果：")
		f()
		print("Lua脚本调试结束。")
		
		return 0
	elseif TalkMsg== "/help" or TalkMsg== "/h" or TalkMsg=="/指令" or TalkMsg=="/帮助" then
		local MyLuaTalkLevel = Char.GetData(_PlayerIndex,%对象_GM%)
		NLG.TalkToCli(_PlayerIndex, -1, "[系统] 你有足够权限使用的LuaTalk指令如下：", 4, 1)
		for i = 1, table.getn(LuaTalkList) do
			if LuaTalkList[i][2]<=MyLuaTalkLevel then
				NLG.TalkToCli(_PlayerIndex, nil, LuaTalkList[i][1], 4, 1)
			end
		end
		return 0
	elseif TalkMsg=="/时间" or TalkMsg=="/time" then
		NLG.TalkToCli(_PlayerIndex, nil, "[系统] 当前系统时间：" ..os.date("%Y年%m月%d日 %X"), 4, 1);
		return 0
	elseif TalkMsg=="/声望" or TalkMsg=="/fame" then
		local tFame = Char.GetData(_PlayerIndex, %对象_声望%)
		local tFameMax = Char.GetData(_PlayerIndex, %对象_日声望上限%)
		NLG.TalkToCli(_PlayerIndex, nil, "[系统] 你当前声望为[" .. tFame .. "]点，今日声望获取上限[" .. tFameMax .. "]点。", 4, 1)
		return 0
	elseif TalkMsg=="/算档" or TalkMsg=="/petc" then
		PetPlus_ShowCalc(_PlayerIndex)
		return 0
	elseif TalkMsg=="/喂食" or TalkMsg=="/喂宠" or TalkMsg=="/喂养" or TalkMsg=="/饲养" or TalkMsg=="/pete" or TalkMsg=="/peteat" or TalkMsg=="/eatpet" then
		PetPlus_Talked( CastleAttackNPC, _PlayerIndex)
		return 0
	elseif TalkMsg=="/签到" or TalkMsg=="/sign" then
		NLG.SystemMessage(_PlayerIndex,"[系统] 暂无此功能……");
		return 0
	elseif TalkMsg=="/银行" or TalkMsg=="/bank" then
		NLG.SystemMessage(_PlayerIndex,"[系统] 暂无此功能……");
		return 0
	elseif TalkMsg=="/足球" or TalkMsg=="/football" then
		NLG.SystemMessage(_PlayerIndex,"[系统] 暂无此功能……");
		return 0
	elseif TalkMsg=="/战绩" or TalkMsg=="/dp" then
		NLG.SystemMessage(_PlayerIndex,"[系统] 暂无此功能……");
		return 0
	elseif TalkMsg=="/鉴定" or TalkMsg=="/judge" or TalkMsg=="/ju" then
		local Count = 0
		for ItemSlot = 8,27 do
			local ItemIndex = Char.GetItemIndex(_PlayerIndex, ItemSlot)
			if Item.GetData(ItemIndex, %道具_已鉴定%)==0 then
				Count = Count + 1
				Item.SetData(ItemIndex, %道具_已鉴定%, 1)
				NLG.SystemMessage(_PlayerIndex,"[系统] 你身上的 " .. Item.GetData(ItemIndex, %道具_鉴前名%) .. "已鉴定为 " .. Item.GetData(ItemIndex, %道具_名字%))
				Item.UpItem(_PlayerIndex, ItemSlot)
			end
		end
		if Count==0 then
			NLG.SystemMessage(_PlayerIndex,"[系统] 你身上没有需要鉴定的物品")
		end
		return 0
	elseif TalkMsg=="/修炼" then
		NLG.SystemMessage(_PlayerIndex,"[系统] 暂无此功能……");
		return 0
	elseif TalkMsg=="/退出战斗" or TalkMsg=="/exitbattle" then
		Battle.ExitBattle(_PlayerIndex);
		return 0
	elseif TalkMsg=="/在线玩家"or TalkMsg=="/list" then
		NLG.SystemMessage(_PlayerIndex, "[在线玩家列表] 清单如下：");
		for Key,Value in pairs(Players) do
			local tName = Char.GetData(Value.Index, %对象_原名%)
			local tLv = Char.GetData(Value.Index, %对象_等级%)
			--NLG.SystemMessage(_PlayerIndex, "[" .. Value.Index .. "]" .. tName .. "(Lv." .. tLv .. ") At " .. Char.GetData(Value.Index, %对象_地图%) .. "." .. Char.GetData(Value.Index, %对象_X%) .. "." .. Char.GetData(Value.Index, %对象_Y%));
			NLG.SystemMessage(_PlayerIndex, "[" .. Value.Index .. "]" .. tName .. "(Lv." .. tLv .. ") At " .. NLG.GetMapName(Char.GetData(Value.Index, %对象_MAP%),Char.GetData(Value.Index, %对象_地图%)));
		end
		return 0
	elseif TalkMsg=="/在线" or TalkMsg=="/lists" or TalkMsg=="/l" then
		if (Char.GetData(_PlayerIndex,%对象_GM%)<100) then
			NLG.SystemMessage(_PlayerIndex, "[系统] 你不是GM，无法使用此功能")
			return 0
		end
		NLG.SystemMessage(_PlayerIndex, "[高级在线玩家列表] 清单如下：");
		--123
		--456
		for Key,Value in pairs(Players) do
			local tName = Char.GetData(Value.Index, %对象_原名%)   --Name
			local tLv = Char.GetData(Value.Index, %对象_等级%)    --Lv
			local BattleStat = " [B" .. Char.GetData(Value.Index, %对象_战斗中%) .. "]"
			if Char.GetData(Value.Index, %对象_战斗中%)<=0 then BattleStat = "" end
			--123
			--456
			NLG.SystemMessage(_PlayerIndex, "[" .. Value.Index .. "][" .. Value.CdKey .. "]" .. tName .. "(Lv." .. tLv .. ") At " .. NLG.GetMapName(Char.GetData(Value.Index, %对象_MAP%),Char.GetData(Value.Index, %对象_地图%)) .. " [" .. Char.GetData(Value.Index, %对象_MAP%) .. "]" .. Char.GetData(Value.Index, %对象_地图%) .. "." .. Char.GetData(Value.Index, %对象_X%) .. "." .. Char.GetData(Value.Index, %对象_Y%) .. BattleStat);
		end
		return 0
	elseif string.find(TalkMsg, "/组队 ")~=nil or string.find(TalkMsg, "/join ")~=nil or string.find(TalkMsg, "/j ")~=nil then
		NLG.SystemMessage(_PlayerIndex,"[系统] 暂无此功能……");
		return 0
	elseif string.find(TalkMsg, "/加队 ")~=nil or string.find(TalkMsg, "/加组 ")~=nil or string.find(TalkMsg, "/tojoin ")~=nil or string.find(TalkMsg, "/tj ")~=nil then
		NLG.SystemMessage(_PlayerIndex,"[系统] 暂无此功能……");
		return 0
	elseif string.find(TalkMsg, "/召唤 ")~=nil or string.find(TalkMsg, "/call ")~=nil or string.find(TalkMsg, "/c ")~=nil then
		NLG.SystemMessage(_PlayerIndex,"[系统] 暂无此功能……");
		return 0
	elseif string.find(TalkMsg, "/跟踪 ")~=nil or string.find(TalkMsg, "/follow ")~=nil or string.find(TalkMsg, "/f ")~=nil then
		NLG.SystemMessage(_PlayerIndex,"[系统] 暂无此功能……");
		return 0
	elseif TalkMsg=="/求助" or TalkMsg=="/sos" or TalkMsg=="/s" then
		NLG.SystemMessage(_PlayerIndex,"[系统] 暂无此功能……");
		return 0
	elseif string.find(TalkMsg, "/参战 ")~=nil or string.find(TalkMsg, "/joinbattle ")~=nil or string.find(TalkMsg, "/tobattle ")~=nil or string.find(TalkMsg, "/jb ")~=nil or string.find(TalkMsg, "/tb ")~=nil then
		--123
		--456
		local CdKey = Char.GetData(_PlayerIndex,%对象_CDK%);
		local toStr = ""
		if string.find(TalkMsg, "/参战 ")~=nil then
			toStr = string.sub(TalkMsg,string.len("/参战 ")+1)
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
			if toCdKey==Char.GetData(_PlayerIndex,%对象_CDK%) then
				NLG.SystemMessage(_PlayerIndex,"[系统] 不能自己加入自己的战斗。")
				return 0
			end
			--123
			--456
			if Char.GetData(_PlayerIndex,%对象_GM%)<=0 and tab_battlehelp[toCdKey]~=nil then
				NLG.SystemMessage(_PlayerIndex,"[系统] 对方没有开启战斗求助，无法使用参战功能。")
				return 0
			end
			if Char.GetData(Players[toCdKey]["Index"], %对象_战斗中%)~=2 then
				NLG.SystemMessage(_PlayerIndex,"[系统] 对方不在战斗中，无法使用参战功能。")
				return 0
			end

			--Char.Warp( _PlayerIndex, Char.GetData(Players[toCdKey]["Index"], %对象_MAP%), Char.GetData(Players[toCdKey]["Index"], %对象_地图%), Char.GetData(Players[toCdKey]["Index"], %对象_X%), Char.GetData(Players[toCdKey]["Index"], %对象_Y%))
			--Char.JoinParty(_PlayerIndex, Players[toCdKey]["Index"])
			
			Battle.JoinBattle(Players[toCdKey]["Index"], _PlayerIndex)
			
			NLG.SystemMessage(Players[toCdKey]["Index"], "[系统] " .. Char.GetData(_PlayerIndex, 2000) .. " 已参加战斗")
			NLG.SystemMessage(_PlayerIndex, "[系统] 你已加入 " .. Players[toCdKey]["Name"] .. " 的战斗")
		else
			NLG.SystemMessage(_PlayerIndex,"[系统] 没有找到该玩家或该玩家不在线。")
		end
		return 0
	elseif string.find(TalkMsg, "/奖励 ")~=nil or string.find(TalkMsg, "/gift ")~=nil or string.find(TalkMsg, "/g ")~=nil then
		NLG.SystemMessage(_PlayerIndex,"[系统] 暂无此功能……");	
		return 0
	elseif string.find(TalkMsg, "/禁言 ")~=nil or string.find(TalkMsg, "/silence ")~=nil or string.find(TalkMsg, "/s ")~=nil then
		if (Char.GetData(_PlayerIndex,%对象_GM%)<100) then
			NLG.SystemMessage(_PlayerIndex,"[系统] 你不是GM，无法使用此功能")
			return 0
		end
		local CdKey = Char.GetData(_PlayerIndex,%对象_CDK%);
		local toStr = ""
		if string.find(TalkMsg, "/禁言 ")~=nil then
			toStr = string.sub(TalkMsg,string.len("/禁言 ")+1)
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
			NLG.SystemMessage(Players[toCdKey]["Index"], "[系统] 你被禁言了 " .. sTime .. " 秒。")
			NLG.SystemMessage(_PlayerIndex,"[系统] 玩家[" .. Players[toCdKey]["Index"] .."]" .. Players[toCdKey]["Name"] .. "被禁言了 " .. sTime .. " 秒。")
		elseif toPlayer=="all" or toPlayer=="All" or toPlayer=="全部" or toPlayer=="全" then
			for k,v in pairs(Players) do
				local sTime = tonumber(toMsg)
				local tKey = getTabKey(Players[toCdKey]["Index"])
				tab_silencedtime[tKey] = os.time() + sTime
				NLG.SystemMessage(v.Index, "[系统] 你被禁言了 " .. sTime .. "秒。")
			end
			NLG.SystemMessage(_PlayerIndex,"[系统] 已给所有在线玩家禁言了 " .. sTime .. " 秒。")
		else
			NLG.SystemMessage(_PlayerIndex,"[系统] 没有找到该玩家或该玩家不在线。")
		end
		return 0
	elseif TalkMsg=="/回城" or TalkMsg=="/home" then
		Char.DischargeParty(_PlayerIndex)
		local CdKey = Char.GetData(_PlayerIndex,2002);
		tab_return[CdKey] = {MapType = Char.GetData(_PlayerIndex, %对象_MAP%), MapId = Char.GetData(_PlayerIndex, %对象_地图%), PosX = Char.GetData(_PlayerIndex,%对象_X%), PosY = Char.GetData(_PlayerIndex, %对象_Y%)}
		NLG.SystemMessage(_PlayerIndex,"[系统] 我送你离开，千里之外……回到城里面……")
		Char.Warp(_PlayerIndex, 0, 1000, 242, 88)
		return 0
	elseif TalkMsg=="/返回"or TalkMsg=="/back" then
		Char.DischargeParty(_PlayerIndex)
		--123
		--456
		--789
		local CdKey = Char.GetData(_PlayerIndex,%对象_CDK%);
		if tab_return[CdKey]~=nil then
			local r = tab_return[CdKey]
			NLG.SystemMessage(_PlayerIndex,"[系统] 假如……时光可以逆转……就可以快速返回原地……")
			Char.Warp(_PlayerIndex, r.MapType, r.MapId, r.PosX, r.PosY)
			tab_return[CdKey]=nil
		end
		return 0
	elseif TalkMsg=="/对战" or TalkMsg=="/挑战" or TalkMsg=="/pk" then
		local CdKey = Char.GetData(_PlayerIndex,%对象_CDK%)
		local Name = Char.GetData(_PlayerIndex,%对象_原名%)
		local Lv = Char.GetData(_PlayerIndex,%对象_等级%)
		if battle_remotepk==CdKey then
			battle_remotepk=-2
			MSG("[全服对战系统] 玩家 " .. Name .. "(Lv." .. Lv .. ") 取消了全服对战！")
			return 0
		elseif battle_remotepk==-2 then
			battle_remotepk = CdKey
			MSG("[全服对战系统] 玩家 " .. Name .. "(Lv." .. Lv .. ") 发起了全服对战！")
			MSG("[全服对战系统] 可输入 /对战 指令，响应其挑战，一决雌雄！")
		else
			local tName = Char.GetData(Players[battle_remotepk].Index,%对象_原名%)
			local tLv = Char.GetData(Players[battle_remotepk].Index,%对象_等级%)
			Char.DischargeParty(Players[battle_remotepk].Index)
			Char.DischargeParty(_PlayerIndex)
			local BattleIndex = Battle.PVP(Players[battle_remotepk].Index, _PlayerIndex)
			Battle.SetType(BattleIndex, %战斗_普通%)
			Battle.SetGainMode(BattleIndex, %战奖_普通%)
			Battle.SetNORisk(BattleIndex, 1)
			MSG("[全服对战系统] 玩家 " .. Name .. "(Lv." .. Lv .. ") 响应了" .. tName .. "(Lv." .. tLv .. ")的全服对战！")
			MSG("[全服对战系统] 其他玩家可输入 /观战 指令，观看这场世纪大战！")
			--MSG("[全服对战系统] 其他玩家可输入 /观战 " .. CdKey .. " 指令，观看这场世纪大战！")
			battle_watchpkA = Players[battle_remotepk].Index
			battle_watchpkB = _PlayerIndex
			battle_remotepk = -2
		end
		return 0
		--123
		--456
	elseif string.find(TalkMsg, "/观战")~=nil then
		if TalkMsg=="/观战" then
			if Char.GetData(_PlayerIndex, %对象_组队模式%)>0 then
				NLG.SystemMessage(_PlayerIndex,"[系统] 组队无法使用此功能")
				return
			end
			NLG.WatchBattle( _PlayerIndex, battle_watchpkA)
			NLG.WatchBattle( _PlayerIndex, battle_watchpkB)
			--123
			--456
			local Name = Char.GetData(_PlayerIndex,%对象_原名%)
			local Lv = Char.GetData(_PlayerIndex,%对象_等级%)
			NLG.TalkToCli(battle_watchpkA, nil, "[全服对战系统] 玩家 " .. Name .. "(Lv." .. Lv .. ") 正在观看你的全服对战！",4,1)
			NLG.TalkToCli(battle_watchpkB, nil, "[全服对战系统] 玩家 " .. Name .. "(Lv." .. Lv .. ") 正在观看你的全服对战！",4,1)
		elseif string.find(TalkMsg, "/观战 ")~=nil then
			if string.find(TalkMsg, "/观战 ")~=nil then
				toStr = string.sub(TalkMsg,string.len("/观战 ")+1)
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
					NLG.SystemMessage(Players[toCdKey].Index, "[系统] 玩家 " .. Name .. "(Lv." .. Lv .. ") 正在观看你的战斗！")
					NLG.SystemMessage(_PlayerIndex,"[系统] 你正在观看玩家 " .. Char.GetData(Players[toCdKey].Index,%对象_原名%) .. "(Lv." .. Char.GetData(Players[toCdKey].Index,%对象_等级%) .. ") 的战斗")
				end
			else
				NLG.SystemMessage(_PlayerIndex,"[系统] 没有该编号或帐号的玩家在战斗中，无法观战！")
			end
		end
		return 0
	elseif string.find(TalkMsg, "/私聊 ")~=nil or string.find(TalkMsg, "/m ")~=nil then
		--123
		--456
		local CdKey = Char.GetData(_PlayerIndex,%对象_CDK%);
		if tab_laba[CdKey]==nil then
			NLG.SystemMessage(_PlayerIndex,"[系统] 你的私聊频道已关闭，无法使用私聊功能。请用 /私聊开关 重新打开。")
			return 0			
		end
		local toStr = ""
		if string.find(TalkMsg, "/私聊 ")~=nil then
			toStr = string.sub(TalkMsg,string.len("/私聊 ")+1)
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
				NLG.SystemMessage(Players[toCdKey]["Index"], "[私聊] " .. Char.GetData(_PlayerIndex,%对象_原名%) .. "：" .. toMsg)
				NLG.SystemMessage(_PlayerIndex,"[私聊] 信息已发送")
			else
				NLG.SystemMessage(_PlayerIndex,"[系统] 对方没有开启私聊频道。")
			end
		elseif toCdKey==Char.GetData(_PlayerIndex,%对象_CDK%) then
			NLG.SystemMessage(_PlayerIndex,"[系统] 不能给自己发送私聊信息。")
		else
			NLG.SystemMessage(_PlayerIndex,"[系统] 没有找到该玩家或该玩家不在线。")
		end
		return 0
	elseif string.find(TalkMsg, "/喇叭 ")~=nil or string.find(TalkMsg, "/laba ")~=nil then
		local m = ""
		local CdKey = Char.GetData(_PlayerIndex,%对象_CDK%);
		if tab_laba[CdKey]==nil then
			NLG.SystemMessage(_PlayerIndex,"[系统] 你的喇叭频道已关闭，无法使用喇叭功能。请用 /喇叭开关 重新打开。")
			return 0
		end
		if string.find(TalkMsg, "/喇叭 ")~=nil then
			m = string.gsub(TalkMsg, "/喇叭 ", 1)
		elseif string.find(TalkMsg, "/laba ")~=nil then
			m = string.gsub(TalkMsg, "/laba ", 1)
		end
		m = string.sub(m,2)
		for k,v in pairs(tab_laba) do
			NLG.SystemMessage(v, "[喇叭] " .. Char.GetData(_PlayerIndex, %对象_原名%) .. "：" .. m)
		end
		return 0
	elseif TalkMsg=="/1" or TalkMsg=="/不遇敌" then
		--123
		--456
		if (Char.GetData(_PlayerIndex, %对象_不遇敌开关%)==1) then
			Char.SetData(_PlayerIndex, %对象_不遇敌开关%, 0)
			NLG.SystemMessage(_PlayerIndex,"[系统] 不遇敌已经关闭")
		elseif (Char.GetData(_PlayerIndex, %对象_不遇敌开关%)==0) then
			Char.SetData(_PlayerIndex, %对象_不遇敌开关%, 1)
			NLG.SystemMessage(_PlayerIndex,"[系统] 不遇敌已经打开")
		end
		return 0
	elseif TalkMsg=="/2" or TalkMsg=="/遇敌" then
		local rt = Battle.Encount(_PlayerIndex,_PlayerIndex)
		if rt > 0 then
			NLG.SystemMessage(_PlayerIndex,"[系统] 战斗吧！雅典娜的圣斗士……")
		else
			NLG.SystemMessage(_PlayerIndex,"[系统] 此处感觉不到怪物的气息……")
		end
		return 0
	elseif TalkMsg=="/3" or TalkMsg=="/喇叭开关" then
		local CdKey = Char.GetData(_PlayerIndex,%对象_CDK%);
		if tab_laba[CdKey]==nil then
			tab_laba[CdKey]=_PlayerIndex
			NLG.SystemMessage(_PlayerIndex,"[系统] 喇叭频道已打开")
		elseif tab_laba[CdKey]~=nil then
			tab_laba[CdKey]=nil
			NLG.SystemMessage(_PlayerIndex,"[系统] 喇叭频道已关闭")
		end
		return 0
	elseif TalkMsg=="/4" or TalkMsg=="/私聊开关" then
		local CdKey = Char.GetData(_PlayerIndex,%对象_CDK%);
		if tab_siliao[CdKey]==nil then
			tab_siliao[CdKey]=_PlayerIndex
			NLG.SystemMessage(_PlayerIndex,"[系统] 私聊频道已打开")
		elseif tab_siliao[CdKey]~=nil then
			tab_siliao[CdKey]=nil
			NLG.SystemMessage(_PlayerIndex,"[系统] 私聊频道已关闭")
		end
		return 0
	elseif TalkMsg=="/5" or TalkMsg=="/公告开关" then
		local CdKey = Char.GetData(_PlayerIndex,2002);
		if tab_msg[CdKey]==nil then
			tab_msg[CdKey]=_PlayerIndex
			NLG.SystemMessage(_PlayerIndex,"[系统] 活动公告频道已打开")
		elseif tab_msg[CdKey]~=nil then
			tab_msg[CdKey]=nil
			NLG.SystemMessage(_PlayerIndex,"[系统] 活动公告频道已关闭")
		end
		return 0
	elseif TalkMsg=="/原地开关" or TalkMsg=="/原地登入" or TalkMsg=="/原地登入" then
		if (Char.GetData(_PlayerIndex,%对象_GM%)<100) then
			NLG.SystemMessage(_PlayerIndex,"[系统] 你不是GM，无法使用此功能")
			return 0
		end
		if setting_yd==0 then
			setting_yd=1
			NLG.SystemMessage(_PlayerIndex,"[系统] 原地登入系统已打开")
		elseif setting_yd==1 then
			setting_yd=0
			NLG.SystemMessage(_PlayerIndex,"[系统] 原地登入系统已关闭")
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