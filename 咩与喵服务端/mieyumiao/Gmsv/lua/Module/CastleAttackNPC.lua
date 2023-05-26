function CastleAttackNPC_GameInit()
	--活动开始时间（Hour）
	MonsterAttackHour = 21
	--NPC名称
	CastleAttackNPCName = "御前带刀侍卫 韦小宝"
	--NPC图档
	CastleAttackNPCImage = 14077
	--城堡生命数
	MonsterAttackGameLift = 20
	--奖励随机投放量，如此值为-1时，则按在线玩家人数发放奖励
	CastleAttackGift = -1
	--在线玩家人数发放奖励倍数，默认每人5个（在线人数乘与5）
	CastleAttackGiftRank = 15
	--奖品名称
	CastleAttackGiftName = "奖品"
	--奖品图档
	CastleAttackGiftImage = 99029
	--奖品列表，从下列中随机抽一个
	CastleAttackGiftList = {18032,18033,18034,18035,18036,18037,18038,18039,19040,18041,18042,18043,18044,18045,18046,18047,18048,18049,18050,18051,18052,18053,18054,18055,18056,18057,18058,18059,18060,18061,18062,18063,18064,18065,18066,18067,18068,18069,18070,18071,18072,18073,18074,18075,18076,18077,18078,18079,18080,18081,18082,18083,18084,18085,18086,18087,18088,107725,107726,107727,107728,107729,107730,107731,107732,39545,39546,39547,652208,652209,652210,652211,652212,652213,652214,652215,652216,652217,652218,652219,652220,652221,652222,652223};
	--每轮放出怪物数量，如此值为-1时，则按在线玩家人数刷怪
	MonsterAttackPerRound = -1
	--在线玩家人数刷怪倍数，默认每5个人刷1只怪（在线人数除与5）
	MonsterAttackPerRank = 5
	--怪物名称
	CastleAttackMonName = "刺客"
	--怪物图档
	CastleAttackMonImage = {101920,101923}
	--怪物ID
	CastleAttackMonID = {921,924}
	--怪物等级
	CastleAttackMonLv = {40,60}
	--战斗中怪物数量
	CastleAttackMonNum = {3,8}
	--允许存在的最大怪物数
	CastleAttackMonMax = 20

	--以下为控制变量，勿改！
	MonsterAttackMapA = 1000
	MonsterAttackMapB = 1500
	MonsterAttackStart = 0
	MonsterAttackNum = 0
	MonsterAttackWin = 0
	CastleAttackGiftLeft = 0
	--{Ptr,WayMode,DelCount,Level,DP)
	CastleAttackMonPtr = {}
	MonsterAttackKillPlayer = {}
	--{}
	CastleAttackKillCount = {}
end

function CastleAttackNPC_Create()
	CastleAttackNPC = NL.CreateNpc(nil, "CastleAttackNPC_Init");
	Char.SetData(CastleAttackNPC, %对象_形象%, CastleAttackNPCImage);
	Char.SetData(CastleAttackNPC, %对象_原形%, CastleAttackNPCImage); 
	Char.SetData(CastleAttackNPC, %对象_地图%, MonsterAttackMapB);
	Char.SetData(CastleAttackNPC, %对象_X%, 43);
	Char.SetData(CastleAttackNPC, %对象_Y%, 53);
	Char.SetData(CastleAttackNPC, %对象_方向%, 4);
	Char.SetData(CastleAttackNPC, %对象_原名%, CastleAttackNPCName);
	NLG.UpChar(CastleAttackNPC)

	if (Char.SetTalkedEvent(nil, "CastleAttackNPC_Talked", CastleAttackNPC) < 0) then
		print("CastleAttackNPC_Talked 注册事件失败。");
		return false;
	end

	if (Char.SetWindowTalkedEvent(nil, "CastleAttackNPC_WindowTalked", CastleAttackNPC) < 0) then
		print("CastleAttackNPC_WindowTalked 注册事件失败。");
		return false;
	end

	if (Char.SetLoopEvent(nil,"CastleAttackNPC_Loop",CastleAttackNPC,30000) < 0) then
		print("CastleAttackNPC_Loop 注册事件失败。");
		return false;
	end

	return true;
end

function CastleAttackNPC_Init( _MePtr )
	print("CastleAttackNPC.Index = " .. _MePtr)
	return true;
end

function CastleAttackNPC_Talked( _MePtr, _TalkPtr)

	if(NLG.CheckInFront(_TalkPtr, _MePtr, 1) == false) then
		return ;
	end
	
	if (MonsterAttackStart==0 and os.date("%H")==tostring(MonsterAttackHour-1) and os.date("%M")>="30") then
		NLG.TalkToCli( _TalkPtr, _MePtr, "马上就有" .. CastleAttackMonName .."来了，还站在这干嘛？还不赶紧去做准备？  by Duckyの復活", 1, 3);
	elseif (MonsterAttackStart==0 and os.date("%H")<tostring(MonsterAttackHour) and os.date("%H")>tostring(MonsterAttackHour-5)) then
		NLG.TalkToCli( _TalkPtr, _MePtr, "根据密探汇报，今晚" .. MonsterAttackHour .. "点会有" .. CastleAttackMonName .."偷袭法兰城，有勇士可以帮我们把怪物消灭吗？  by Duckyの復活", 1, 3);
	elseif (MonsterAttackStart==1) then
		NLG.TalkToCli( _TalkPtr, _MePtr, table.getn(CastleAttackMonPtr) .. "有" .. CastleAttackMonName .."！保护国王！护驾~~~~~~~护驾！  by Duckyの復活", 1, 3);
	else
		NLG.TalkToCli( _TalkPtr, _MePtr, "凉风有信，秋月无边，亏我思娇嘅情绪好比度日如年，虽则我唔喺玉树临风，潇洒倜傥，但喺我有广阔嘅胸襟，加强劲嘅臂弯！  by Duckyの復活", 1, 3);
	end
	local TM_buff = ""
	for i = 1,table.getn(CastleAttackMonPtr) do
		--MSG(i .. "：" .. CastleAttackMonPtr[i][1] .. "," .. CastleAttackMonPtr[i][2] .. "," .. CastleAttackMonPtr[i][3] .. "," .. CastleAttackMonPtr[i][4] .. "," .. CastleAttackMonPtr[i][5] .. "Map:" .. Char.GetData(CastleAttackMonPtr[i][1], 4) .. "," .. Char.GetData(CastleAttackMonPtr[i][1], 5) .. "," .. Char.GetData(CastleAttackMonPtr[i][1], 6));
	end
	
	return ;
end

function CastleAttackNPC_WindowTalked( _MePtr, _TalkPtr, _Seqno, _Select, _Data)
	return ;
end

function CastleAttackNPC_Loop(_MePtr)
	if (os.date("%H")==tostring(MonsterAttackHour-1) and os.date("%M")>="50") then
		local TM_RND = math.random(1,3);
		if (TM_RND==1) then
			MSG("[保卫皇城]据探子回报，有" .. CastleAttackMonName .."正在法兰城周边潜伏，几分钟后即将到达法兰城，请各位勇士做好准备！  by Duckyの復活");
		end
	elseif (os.date("%H")==tostring(MonsterAttackHour) and os.date("%M")=="00") then
		--GetTopLv("TopLv5")
		MonsterAttackStart = 1
		MSG("[保卫皇城]发现" .. CastleAttackMonName .."！请各位勇士尽快把刺客消灭，保卫皇城的安全！  by Duckyの復活");
	elseif (os.date("%H")==tostring(MonsterAttackHour) and os.date("%M")>"00" and os.date("%M")<="25" and MonsterAttackStart==1) then
		local TM_RND = math.random(1,8);
		if (TM_RND==2) then
			CastleAttackNPC_CheckMonster();
		end
		if (table.getn(CastleAttackMonPtr)>=CastleAttackMonMax) then
			return;
		end
		if (MonsterAttackPerRound>=0) then
			for i = 1,tonumber(MonsterAttackPerRound) do
				CastleAttackNPC_CreateMonster()
			end
		elseif (MonsterAttackPerRound==-1) then
			for i = 1,tonumber(math.floor((NLG.GetOnLinePlayer()+4)/MonsterAttackPerRank)) do
				CastleAttackNPC_CreateMonster()
			end
		end
	elseif (os.date("%H")==tostring(MonsterAttackHour) and MonsterAttackStart==1 and MonsterAttackGameLift<=0) then
		CastleAttackNPC_GameOver()
	elseif (os.date("%H")==tostring(MonsterAttackHour) and os.date("%M")>="45" and MonsterAttackStart==1 and table.getn(CastleAttackMonPtr)~=0 and MonsterAttackWin==0) then
		CastleAttackNPC_GameOver()
	elseif (os.date("%H")==tostring(MonsterAttackHour) and MonsterAttackStart==1 and MonsterAttackWin==0 and table.getn(CastleAttackMonPtr)==0) then
		MonsterAttackWin = 1;
		MSG("[保卫皇城]所有" .. CastleAttackMonName .."已被清除，等待国王发放奖品！！  by Duckyの復活");
	elseif (os.date("%H")==tostring(MonsterAttackHour) and os.date("%M")>"00" and MonsterAttackStart==1 and MonsterAttackWin==0) then
		local TM_RND = math.random(1,4);
		if (TM_RND==2) then
			CastleAttackNPC_CheckMonster();
		end
	elseif (os.date("%H")==tostring(MonsterAttackHour) and os.date("%M")>"00" and MonsterAttackStart==1 and MonsterAttackWin==1) then
		MonsterAttackStart=0
		MSG("[保卫皇城]所有" .. CastleAttackMonName .."已被歼灭，国王为答谢各位勇士，特向全法兰城随机投放[" ..CastleAttackGift.. "]个" .. CastleAttackGiftName .. "。（数量与当前在线人数有关）  by Duckyの復活");
		MSG("[保卫皇城]请各位勇士于" .. tostring(MonsterAttackHour+1) .. "点前，在法兰城内寻找" .. CastleAttackGiftName .. "。（由于是空中投放，部分证书可能会掉落在屋顶、水面，请各位见谅）  by Duckyの復活");
		CastleAttackNPC_SendGift()
	elseif (os.date("%H")==tostring(MonsterAttackHour) and os.date("%M")>"00" and os.date("%M")<"45" and MonsterAttackStart==0 and MonsterAttackWin==1) then
		local TM_RND = math.random(1,4);
		if (TM_RND==2) then
			MSG("[保卫皇城]全法兰城现有[" .. CastleAttackGiftLeft .. "]个" .. CastleAttackGiftName .. "，请各位勇士尽快拾取。（由于是空中投放，部分奖品可能会掉落在屋顶、水面，请各位见谅）  by Duckyの復活");
		end
	elseif (os.date("%H")==tostring(MonsterAttackHour+1) and os.date("%M")=="00" and MonsterAttackStart==0 and MonsterAttackWin==1) then
		MSG("[保卫皇城]法兰城清洁队出动，把地上所有" .. CastleAttackGiftName .. "当垃圾清理干净了。。。  by Duckyの復活");
	elseif (os.date("%H")==tostring(MonsterAttackHour+1) and os.date("%M")<="10") then
		CastleAttackNPC_GameInit()
		print("[保卫皇城]活动结束！");
	end
	return;
end

function CastleAttackNPC_CreateMonster()
	local NewMonsterPtr = -1;
	local NewMonsterPtr = NL.CreateNpc(nil, "CastleAttackMon_Init");
	NLG.UpChar(NewMonsterPtr);
											--{Ptr,WayMode,DelCount,Level,DP)
	if (NewMonsterPtr>0) then table.insert(CastleAttackMonPtr , {NewMonsterPtr,0,0,0,0}) end
	return;
end

function CastleAttackNPC_KillMonster(intMonPtr)
	for i=1,table.getn(CastleAttackMonPtr) do
		if (intMonPtr==CastleAttackMonPtr[i][1]) then
			table.remove(CastleAttackMonPtr,i);
			NL.DelNpc(intMonPtr);
			break;
		end
	end
	return;
end

function CastleAttackNPC_CheckMonster()
	MSG("[保卫皇城]现在有[" ..table.getn(CastleAttackMonPtr).. "]个" .. CastleAttackMonName .."在法兰城，请各位勇者尽快把刺客铲除！  by Duckyの復活");
	return;
end

function CastleAttackNPC_SendGift()
	if (CastleAttackGift>0) then
		for i = 1,CastleAttackGift do
			local NewGiftPtr = NL.CreateNpc(nil, "CastleAttackGift_Init");
			NLG.UpChar(NewGiftPtr);
		end
	elseif (CastleAttackGift==-1) then
		local TM_GiftNum = NLG.GetOnLinePlayer()*CastleAttackGiftRank
		MSG("即将投放[" .. TM_GiftNum .. "]个奖品。  by Duckyの復活");
		for i = 1, TM_GiftNum do
			local NewGiftPtr = NL.CreateNpc(nil, "CastleAttackGift_Init");
			NLG.UpChar(NewGiftPtr);
		end
	end
	return;
end

function CastleAttackNPC_KillGift()
	CastleAttackGiftLeft=CastleAttackGiftLeft-1
	return;
end

function CastleAttackNPC_CheckGift()
	MSG("[保卫皇城]全法兰城现有[" .. CastleAttackGiftLeft .. "]个" .. CastleAttackGiftName .. "，请各位勇士尽快拾取。（由于是空中投放，部分证书可能会掉落在屋顶、水面，请各位见谅）  by Duckyの復活");
	return;
end

function CastleAttackNPC_GameOver()
	if (MonsterAttackStart==0) then return end
	for i = 1,table.getn(CastleAttackMonPtr) do
		NL.DelNpc(CastleAttackMonPtr[i][1]);
	end
	MSG("[保卫皇城]由于" .. CastleAttackMonName .."在法兰城大闹一场，威胁到国王的安全，派出锦衣卫出动将所有" .. CastleAttackMonName .."一网打尽。  by Duckyの復活");
	CastleAttackNPC_GameInit();
	return;
end

function CastleAttackNPC_MonsterInfo(intMonsterPtr, intModifySub, intModifyValue)
	
	local TM_MonsterPtr = nil;
	
	for i=1,table.getn(CastleAttackMonPtr) do
		if (CastleAttackMonPtr[i][1]==intMonsterPtr) then
			if (intModifyValue==nil or intModifyValue=='') then
				return CastleAttackMonPtr[i][intModifySub];
			else
				CastleAttackMonPtr[i][intModifySub] = intModifyValue;
			end
			break;
		end
	end
	
	return 1;
end

function CastleAttackMon_Init( _MePtr )
	local NewMapPos = {}
	NewMapPos = {
								{MonsterAttackMapA,280,87},
								{MonsterAttackMapA,280,88},
								{MonsterAttackMapA,280,89},
								{MonsterAttackMapA,279,87},
								{MonsterAttackMapA,279,88},
								{MonsterAttackMapA,279,89},
								{MonsterAttackMapA,278,87},
								{MonsterAttackMapA,278,88},
								{MonsterAttackMapA,278,89},
								{MonsterAttackMapA,22,87},
								{MonsterAttackMapA,22,88},
								{MonsterAttackMapA,22,89},								
								{MonsterAttackMapA,23,87},
								{MonsterAttackMapA,23,88},
								{MonsterAttackMapA,23,89},
								{MonsterAttackMapA,24,87},
								{MonsterAttackMapA,24,88},
								{MonsterAttackMapA,24,89},
								{MonsterAttackMapA,152,239},
								{MonsterAttackMapA,152,240},
								{MonsterAttackMapA,152,241},
								{MonsterAttackMapA,153,239},
								{MonsterAttackMapA,153,240},
								{MonsterAttackMapA,153,241},
								{MonsterAttackMapA,154,239},
								{MonsterAttackMapA,154,240},
								{MonsterAttackMapA,154,241}
								}
	local SelectMapPos = math.random(1,table.getn(NewMapPos));
	local NewMonsterImage = math.random(CastleAttackMonImage[1],CastleAttackMonImage[2])
	Char.SetData(_MePtr, %对象_形象%, NewMonsterImage);
	Char.SetData(_MePtr, %对象_原形%, NewMonsterImage); 
	Char.SetData(_MePtr, %对象_地图%, NewMapPos[SelectMapPos][1]);
	Char.SetData(_MePtr, %对象_X%, NewMapPos[SelectMapPos][2]);
	Char.SetData(_MePtr, %对象_Y%, NewMapPos[SelectMapPos][3]);
	Char.SetData(_MePtr, %对象_方向%, 4);
	Char.SetData(_MePtr, %对象_原名%, CastleAttackMonName);
	--NLG.UpChar(_MePtr);

	if (Char.SetTalkedEvent(nil, "CastleAttackMon_Talked", _MePtr) < 0) then
		print("CastleAttackMon_Talked 注册事件失败。");
		return false;
	end
	
	if (Char.SetWindowTalkedEvent(nil, "CastleAttackMon_WindowTalked", _MePtr) < 0) then
		print("CastleAttackMon_WindowTalked 注册事件失败。");
		return false;
	end
	
	if (Char.SetPostOverEvent(nil, "CastleAttackMon_PostOver", _MePtr) < 0) then
		print("CastleAttackMon_PostOver 注册事件失败。");
		return false;
	end

--响应循环事件
	if (Char.SetLoopEvent(nil,"CastleAttackMon_Loop",_MePtr,4000) < 0) then
		print("CastleAttackMon_Loop 注册事件失败。");
		return false;
	end
	
	MSG("一批刺客偷偷潜入法兰城...  by Duckyの復活");

	return true;
end



function CastleAttackMon_PostOver( _MePtr, _TalkPtr)
	NLG.TalkToCli( _TalkPtr, _MePtr, "挡我者死！！！", 1, 3);
	--NLG.TalkToCli( GetTeamIndex(_TalkPtr,1), "挡我者死！！！", 5, 3, _MePtr);
	--NLG.TalkToCli( GetTeamIndex(_TalkPtr,2), "挡我者死！！！", 5, 3, _MePtr);
	--NLG.TalkToCli( GetTeamIndex(_TalkPtr,3), "挡我者死！！！", 5, 3, _MePtr);
	--NLG.TalkToCli( GetTeamIndex(_TalkPtr,4), "挡我者死！！！", 5, 3, _MePtr);
	--CreateBattle(_TalkPtr, _MePtr);
	CastleAttackMon_CreateBattle(_TalkPtr, _MePtr);
	return;
end


function CastleAttackMon_Talked( _MePtr, _TalkPtr)

	if(NLG.CheckInFront(_TalkPtr, _MePtr, 1) == false) then
		return ;
	end 
	
	NLG.TalkToCli( _TalkPtr, _MePtr, "挡我者死！！！", 1, 3);
	--NLG.TalkToCli( GetTeamIndex(_TalkPtr,1), "挡我者死！！！", 5, 3, _MePtr);
	--NLG.TalkToCli( GetTeamIndex(_TalkPtr,2), "挡我者死！！！", 5, 3, _MePtr);
	--NLG.TalkToCli( GetTeamIndex(_TalkPtr,3), "挡我者死！！！", 5, 3, _MePtr);
	--NLG.TalkToCli( GetTeamIndex(_TalkPtr,4), "挡我者死！！！", 5, 3, _MePtr);
	CastleAttackMon_CreateBattle(_TalkPtr, _MePtr);
	return ;
end

function CastleAttackMon_WindowTalked( _MePtr, _TalkPtr, _Seqno, _Select, _Data)
	return ;
end

function CastleAttackMon_Loop(_MePtr)
	if (os.date("%H")==tostring(MonsterAttackHour) and os.date("%M")>"45") then
		--NL.DelNpc(_MePtr);
		CastleAttackNPC_KillMonster(_MePtr);
		print(NL.GetErrorStr());
		return;
	end
	
	--local TM_KillTime = CastleAttackNPC_MonsterInfo( _MePtr, 3, nil);
	--if (CastleAttackNPC_MonsterInfo(_MePtr, 3)>20) then
	if (CastleAttackNPC_MonsterInfo(_MePtr,3,nil)>=100) then
		CastleAttackNPC_KillMonster(_MePtr);
		MonsterAttackGameLift = MonsterAttackGameLift - 1
		MSG("[保卫皇城]有一批刺客闯进了皇城，被锦衣卫十大高手打得落荒而逃...  by Duckyの復活" .. MonsterAttackGameLift);
		if (MonsterAttackGameLift<6) then MSG("[保卫皇城]已有大量刺客闯入皇城，请尽快消灭，否则将派出大量锦衣卫将其歼灭...  by Duckyの復活") end
		return;
	end
	
	local intMap = Char.GetData(_MePtr, %对象_地图%);
	local intX = Char.GetData(_MePtr, %对象_X%);
	local intY = Char.GetData(_MePtr, %对象_Y%);
	
	if (intMap==MonsterAttackMapA and intX>=278 and intX<=280 and intY>=87 and intY<=89) then
		CastleAttackNPC_MonsterInfo(_MePtr,2,11);
	elseif (intMap==MonsterAttackMapA and intX>=152 and intX<=154 and intY>=239 and intY<=241) then
		CastleAttackNPC_MonsterInfo(_MePtr,2,21);
	elseif (intMap==MonsterAttackMapA and intX>=22 and intX<=24 and intY>=87 and intY<=89) then
		CastleAttackNPC_MonsterInfo(_MePtr,2,31);
	elseif (intMap==MonsterAttackMapA and intX==168 and intY==88) then
		Char.Warp(_MePtr, 0, MonsterAttackMapB, 64, 53);
		CastleAttackNPC_MonsterInfo(_MePtr,2,4);
	elseif (intMap==MonsterAttackMapA and intX==153 and intY==102) then
		Char.Warp(_MePtr, 0, MonsterAttackMapB, 41, 97);
		CastleAttackNPC_MonsterInfo(_MePtr,2,4);
	elseif (intMap==MonsterAttackMapA and intX==140 and intY==88) then
		Char.Warp(_MePtr, 0, MonsterAttackMapB, 19, 53);
		CastleAttackNPC_MonsterInfo(_MePtr,2,4);
	elseif (intMap==MonsterAttackMapA and intX==153 and intY==165) then
		Char.Warp(_MePtr, 0, MonsterAttackMapA, 153, 160);
	elseif (intMap==MonsterAttackMapB and intX==41 and intY==53) then
		CastleAttackNPC_MonsterInfo(_MePtr,2,5);
	end
	
	local TM_MonsterWay = CastleAttackNPC_MonsterInfo(_MePtr,2);
	
	if (TM_MonsterWay==11) then
		WalkToPos(_MePtr,168,88,"Walk")
	elseif (TM_MonsterWay==21) then
		WalkToPos(_MePtr,153,102,"Walk")
	elseif (TM_MonsterWay==31) then
		WalkToPos(_MePtr,140,88,"Walk")
	elseif (TM_MonsterWay==4) then
		WalkToPos(_MePtr,41,53,"Walk")
	elseif (TM_MonsterWay==5) then
		local WalkDir = math.random(0,7);
		NLG.WalkMove(_MePtr,WalkDir);
		local TM_DelCount = CastleAttackNPC_MonsterInfo(_MePtr,3);
		TM_DelCount  = TM_DelCount + 1
		CastleAttackNPC_MonsterInfo(_MePtr,3,TM_DelCount);
	end
	
	local TM_buff = "";
	
	for i = 1,table.getn(CastleAttackMonPtr) do
		if (CastleAttackMonPtr[i][1]==_MePtr) then
			TM_buff = CastleAttackMonPtr[i][1] .. "," .. CastleAttackMonPtr[i][2] .. "," .. CastleAttackMonPtr[i][3] .. "," .. CastleAttackMonPtr[i][4] .. "," .. CastleAttackMonPtr[i][5];
		end
	end
	
	local strTalk = math.random(0,table.getn(CastleAttackMonPtr)*table.getn(CastleAttackMonPtr)*3+12);
	if (strTalk==1) then
		MSG("[保卫皇城]" .. _MePtr .. "，据探子回报，有一批刺客在" .. Char.GetData(_MePtr, 4) .. "," .. Char.GetData(_MePtr, 5) .. "," .. Char.GetData(_MePtr, 6) .. "附近潜伏，打算进攻法兰城。  by Duckyの復活");
		--MSG(TM_buff);
	end
		
	NLG.SetAction(_MePtr,3);
	NLG.UpChar(_MePtr);
	return;
end

function CastleAttackMon_CreateBattle(_TalkPtr, _MePtr)
	local TM_EnemyIdAr = {};
	local TM_BaseLevel = {};
	for i = 1, math.random(CastleAttackMonNum[1],CastleAttackMonNum[2]) do
		local TM_EnemyId = math.random(CastleAttackMonID[1],CastleAttackMonID[2]);
		table.insert(TM_EnemyIdAr,TM_EnemyId);
		table.insert(TM_BaseLevel,math.random(CastleAttackMonLv[1],CastleAttackMonLv[2]));
	end
	local battleindex = Battle.PVE(_TalkPtr, _MePtr, nil, TM_EnemyIdAr, TM_BaseLevel);
	Battle.SetWinEvent( nil, "CastleAttackMon_WinBattle", battleindex);
end

function CastleAttackMon_WinBattle( _BattleIndex , _CreatePtr )
	local TM_PlayerPtr0 = Battle.GetPlayIndex( _BattleIndex, 0, 0)
	NL.DelNpc(_CreatePtr);
	CastleAttackNPC_KillMonster(_CreatePtr);
	print(NL.GetErrorStr());
	MSG("[保卫皇城]一批刺客被 " .. Char.GetData(TM_PlayerPtr0,2000) .. " 消灭了！  by Duckyの復活");
	NLG.SetAction(TM_PlayerPtr0,18);
	NLG.UpChar(TM_PlayerPtr0);
	return ;
end

function CastleAttackGift_Init( _MePtr )
	Char.SetData(_MePtr, %对象_形象%, CastleAttackGiftImage);
	Char.SetData(_MePtr, %对象_原形%, CastleAttackGiftImage); 
	Char.SetData(_MePtr, %对象_地图%, MonsterAttackMapA);
	Char.SetData(_MePtr, %对象_X%, math.random(50,200));
	Char.SetData(_MePtr, %对象_Y%, math.random(50,200));
	Char.SetData(_MePtr, %对象_方向%, 4);
	Char.SetData(_MePtr, %对象_原名%, CastleAttackGiftName);

	if (Char.SetTalkedEvent(nil, "CastleAttackGift_Talked", _MePtr) < 0) then
		print("CastleAttackGift_Talked 注册事件失败。");
		return false;
	end
	
	if (Char.SetLoopEvent(nil,"CastleAttackGift_Loop",_MePtr,60000) < 0) then
		print("CastleAttackGift_Loop 注册事件失败。");
		return false;
	end
	
	CastleAttackGiftLeft = CastleAttackGiftLeft + 1
	return true;
end

function CastleAttackGift_Talked( _MePtr, _TalkPtr)

	if(NLG.CheckInFront(_TalkPtr, _MePtr, 1) == false) then
		return ;
	end
	
	local TM_GiftNum = math.random(1,table.getn(CastleAttackGiftList));
	NLG.GiveItem(_TalkPtr , CastleAttackGiftList[TM_GiftNum]);
	NL.DelNpc(_MePtr);
	return ;
end

function CastleAttackGift_Loop( _MePtr )
	if (os.date("%H")~=tostring(MonsterAttackHour)) then
		NL.DelNpc(_MePtr);
		CastleAttackNPC_KillGift()
		print(NL.GetErrorStr());
	else
		local TM_RND = math.random(1,16);
		if (TM_RND==2) then
			MSG("[保卫皇城]" .. _MePtr .. "，有一个宝箱在" .. Char.GetData(_MePtr, 4) .. "," .. Char.GetData(_MePtr, 5) .. "," .. Char.GetData(_MePtr, 6) .. "附近。  by Duckyの復活");
		end
	end
end

function WalkToPos(intMePtr, intPosX, intPosY, rtSub)
	if (intPosX<0 or intPosX==nil or intPosY<0 or intPosY==nil or rtSub=='' or rtSub==nil or intMePtr=='' or intMePtr==nil) then
		return "Error Pos";
	end

	local mePosMap = Char.GetData(intMePtr, %对象_地图%);
	local mePosX = Char.GetData(intMePtr, %对象_X%);
	local mePosY = Char.GetData(intMePtr, %对象_Y%);
	local TM_Dir = -1;
	
	if (string.lower(rtSub)=='distance' or rtSub=='距离') then
		return math.abs(math.floor(math.sqrt((mePosX-intPosX)*(mePosX-intPosX)+(mePosY-intPosY)*(mePosY-intPosY))));
	end
	
	if (mePosX==intPosX and mePosY>intPosY) then
		TM_Dir = 0;
	elseif (mePosX<intPosX and mePosY>intPosY and (math.abs(mePosX-intPosX)-math.abs(mePosY-intPosY))>2) then
		TM_Dir = 2;
	elseif (mePosX<intPosX and mePosY>intPosY and (math.abs(mePosX-intPosX)-math.abs(mePosY-intPosY))<-2) then
		TM_Dir = 0;
	elseif (mePosX<intPosX and mePosY>intPosY) then
		TM_Dir = 1;
	elseif (mePosX<intPosX and mePosY==intPosY) then
		TM_Dir = 2;
	elseif (mePosX<intPosX and mePosY<intPosY and (math.abs(mePosX-intPosX)-math.abs(mePosY-intPosY))>2) then
		TM_Dir = 2;
	elseif (mePosX<intPosX and mePosY<intPosY and (math.abs(mePosX-intPosX)-math.abs(mePosY-intPosY))<-2) then
		TM_Dir = 4;
	elseif (mePosX<intPosX and mePosY<intPosY) then
		TM_Dir = 3;
	elseif (mePosX==intPosX and mePosY<intPosY) then
		TM_Dir = 4;
	elseif (mePosX>intPosX and mePosY<intPosY and (math.abs(mePosX-intPosX)-math.abs(mePosY-intPosY))>2) then
		TM_Dir = 4;
	elseif (mePosX>intPosX and mePosY<intPosY and (math.abs(mePosX-intPosX)-math.abs(mePosY-intPosY))<-2) then
		TM_Dir = 6;
	elseif (mePosX>intPosX and mePosY<intPosY) then
		TM_Dir = 5;
	elseif (mePosX>intPosX and mePosY==intPosY) then
		TM_Dir = 6;
	elseif (mePosX>intPosX and mePosY>intPosY and (math.abs(mePosX-intPosX)-math.abs(mePosY-intPosY))>2) then
		TM_Dir = 6;
	elseif (mePosX>intPosX and mePosY>intPosY and (math.abs(mePosX-intPosX)-math.abs(mePosY-intPosY))<-2) then
		TM_Dir = 0
	elseif (mePosX>intPosX and mePosY>intPosY) then
		TM_Dir = 7;
	elseif (mePosX==intPosX and mePosY==intPosY) then
		TM_Dir = -1;
	end
	
	if (string.lower(rtSub)=='dir' or rtSub=='方向') then
		return TM_Dir;
	elseif (string.lower(rtSub)=='walk' or rtSub=='走动') then
		NLG.WalkMove(intMePtr,TM_Dir);
	elseif (string.lower(rtSub)=='warp' or rtSub=='瞬移') then
		NLG.Warp(intMePtr, 0, mePosMap, intPosX, intPosY);
	end
	
end

CastleAttackNPC_GameInit()
CastleAttackNPC_Create()