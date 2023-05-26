function CastleAttackNPC_GameInit()
	--���ʼʱ�䣨Hour��
	MonsterAttackHour = 21
	--NPC����
	CastleAttackNPCName = "��ǰ�������� ΤС��"
	--NPCͼ��
	CastleAttackNPCImage = 14077
	--�Ǳ�������
	MonsterAttackGameLift = 20
	--�������Ͷ���������ֵΪ-1ʱ������������������Ž���
	CastleAttackGift = -1
	--��������������Ž���������Ĭ��ÿ��5����������������5��
	CastleAttackGiftRank = 15
	--��Ʒ����
	CastleAttackGiftName = "��Ʒ"
	--��Ʒͼ��
	CastleAttackGiftImage = 99029
	--��Ʒ�б��������������һ��
	CastleAttackGiftList = {18032,18033,18034,18035,18036,18037,18038,18039,19040,18041,18042,18043,18044,18045,18046,18047,18048,18049,18050,18051,18052,18053,18054,18055,18056,18057,18058,18059,18060,18061,18062,18063,18064,18065,18066,18067,18068,18069,18070,18071,18072,18073,18074,18075,18076,18077,18078,18079,18080,18081,18082,18083,18084,18085,18086,18087,18088,107725,107726,107727,107728,107729,107730,107731,107732,39545,39546,39547,652208,652209,652210,652211,652212,652213,652214,652215,652216,652217,652218,652219,652220,652221,652222,652223};
	--ÿ�ַų��������������ֵΪ-1ʱ���������������ˢ��
	MonsterAttackPerRound = -1
	--�����������ˢ�ֱ�����Ĭ��ÿ5����ˢ1ֻ�֣�������������5��
	MonsterAttackPerRank = 5
	--��������
	CastleAttackMonName = "�̿�"
	--����ͼ��
	CastleAttackMonImage = {101920,101923}
	--����ID
	CastleAttackMonID = {921,924}
	--����ȼ�
	CastleAttackMonLv = {40,60}
	--ս���й�������
	CastleAttackMonNum = {3,8}
	--������ڵ���������
	CastleAttackMonMax = 20

	--����Ϊ���Ʊ�������ģ�
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
	Char.SetData(CastleAttackNPC, %����_����%, CastleAttackNPCImage);
	Char.SetData(CastleAttackNPC, %����_ԭ��%, CastleAttackNPCImage); 
	Char.SetData(CastleAttackNPC, %����_��ͼ%, MonsterAttackMapB);
	Char.SetData(CastleAttackNPC, %����_X%, 43);
	Char.SetData(CastleAttackNPC, %����_Y%, 53);
	Char.SetData(CastleAttackNPC, %����_����%, 4);
	Char.SetData(CastleAttackNPC, %����_ԭ��%, CastleAttackNPCName);
	NLG.UpChar(CastleAttackNPC)

	if (Char.SetTalkedEvent(nil, "CastleAttackNPC_Talked", CastleAttackNPC) < 0) then
		print("CastleAttackNPC_Talked ע���¼�ʧ�ܡ�");
		return false;
	end

	if (Char.SetWindowTalkedEvent(nil, "CastleAttackNPC_WindowTalked", CastleAttackNPC) < 0) then
		print("CastleAttackNPC_WindowTalked ע���¼�ʧ�ܡ�");
		return false;
	end

	if (Char.SetLoopEvent(nil,"CastleAttackNPC_Loop",CastleAttackNPC,30000) < 0) then
		print("CastleAttackNPC_Loop ע���¼�ʧ�ܡ�");
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
		NLG.TalkToCli( _TalkPtr, _MePtr, "���Ͼ���" .. CastleAttackMonName .."���ˣ���վ�����������Ͻ�ȥ��׼����  by Ducky�Ώͻ�", 1, 3);
	elseif (MonsterAttackStart==0 and os.date("%H")<tostring(MonsterAttackHour) and os.date("%H")>tostring(MonsterAttackHour-5)) then
		NLG.TalkToCli( _TalkPtr, _MePtr, "������̽�㱨������" .. MonsterAttackHour .. "�����" .. CastleAttackMonName .."͵Ϯ�����ǣ�����ʿ���԰����ǰѹ���������  by Ducky�Ώͻ�", 1, 3);
	elseif (MonsterAttackStart==1) then
		NLG.TalkToCli( _TalkPtr, _MePtr, table.getn(CastleAttackMonPtr) .. "��" .. CastleAttackMonName .."����������������~~~~~~~���ݣ�  by Ducky�Ώͻ�", 1, 3);
	else
		NLG.TalkToCli( _TalkPtr, _MePtr, "�������ţ������ޱߣ�����˼���������ñȶ������꣬��������������ٷ磬�������Σ��������й������ؽ󣬼�ǿ�������䣡  by Ducky�Ώͻ�", 1, 3);
	end
	local TM_buff = ""
	for i = 1,table.getn(CastleAttackMonPtr) do
		--MSG(i .. "��" .. CastleAttackMonPtr[i][1] .. "," .. CastleAttackMonPtr[i][2] .. "," .. CastleAttackMonPtr[i][3] .. "," .. CastleAttackMonPtr[i][4] .. "," .. CastleAttackMonPtr[i][5] .. "Map:" .. Char.GetData(CastleAttackMonPtr[i][1], 4) .. "," .. Char.GetData(CastleAttackMonPtr[i][1], 5) .. "," .. Char.GetData(CastleAttackMonPtr[i][1], 6));
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
			MSG("[�����ʳ�]��̽�ӻر�����" .. CastleAttackMonName .."���ڷ������ܱ�Ǳ���������Ӻ󼴽����﷨���ǣ����λ��ʿ����׼����  by Ducky�Ώͻ�");
		end
	elseif (os.date("%H")==tostring(MonsterAttackHour) and os.date("%M")=="00") then
		--GetTopLv("TopLv5")
		MonsterAttackStart = 1
		MSG("[�����ʳ�]����" .. CastleAttackMonName .."�����λ��ʿ����Ѵ̿����𣬱����ʳǵİ�ȫ��  by Ducky�Ώͻ�");
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
		MSG("[�����ʳ�]����" .. CastleAttackMonName .."�ѱ�������ȴ��������Ž�Ʒ����  by Ducky�Ώͻ�");
	elseif (os.date("%H")==tostring(MonsterAttackHour) and os.date("%M")>"00" and MonsterAttackStart==1 and MonsterAttackWin==0) then
		local TM_RND = math.random(1,4);
		if (TM_RND==2) then
			CastleAttackNPC_CheckMonster();
		end
	elseif (os.date("%H")==tostring(MonsterAttackHour) and os.date("%M")>"00" and MonsterAttackStart==1 and MonsterAttackWin==1) then
		MonsterAttackStart=0
		MSG("[�����ʳ�]����" .. CastleAttackMonName .."�ѱ����𣬹���Ϊ��л��λ��ʿ������ȫ���������Ͷ��[" ..CastleAttackGift.. "]��" .. CastleAttackGiftName .. "���������뵱ǰ���������йأ�  by Ducky�Ώͻ�");
		MSG("[�����ʳ�]���λ��ʿ��" .. tostring(MonsterAttackHour+1) .. "��ǰ���ڷ�������Ѱ��" .. CastleAttackGiftName .. "���������ǿ���Ͷ�ţ�����֤����ܻ�������ݶ���ˮ�棬���λ���£�  by Ducky�Ώͻ�");
		CastleAttackNPC_SendGift()
	elseif (os.date("%H")==tostring(MonsterAttackHour) and os.date("%M")>"00" and os.date("%M")<"45" and MonsterAttackStart==0 and MonsterAttackWin==1) then
		local TM_RND = math.random(1,4);
		if (TM_RND==2) then
			MSG("[�����ʳ�]ȫ����������[" .. CastleAttackGiftLeft .. "]��" .. CastleAttackGiftName .. "�����λ��ʿ����ʰȡ���������ǿ���Ͷ�ţ����ֽ�Ʒ���ܻ�������ݶ���ˮ�棬���λ���£�  by Ducky�Ώͻ�");
		end
	elseif (os.date("%H")==tostring(MonsterAttackHour+1) and os.date("%M")=="00" and MonsterAttackStart==0 and MonsterAttackWin==1) then
		MSG("[�����ʳ�]���������ӳ������ѵ�������" .. CastleAttackGiftName .. "����������ɾ��ˡ�����  by Ducky�Ώͻ�");
	elseif (os.date("%H")==tostring(MonsterAttackHour+1) and os.date("%M")<="10") then
		CastleAttackNPC_GameInit()
		print("[�����ʳ�]�������");
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
	MSG("[�����ʳ�]������[" ..table.getn(CastleAttackMonPtr).. "]��" .. CastleAttackMonName .."�ڷ����ǣ����λ���߾���Ѵ̿Ͳ�����  by Ducky�Ώͻ�");
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
		MSG("����Ͷ��[" .. TM_GiftNum .. "]����Ʒ��  by Ducky�Ώͻ�");
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
	MSG("[�����ʳ�]ȫ����������[" .. CastleAttackGiftLeft .. "]��" .. CastleAttackGiftName .. "�����λ��ʿ����ʰȡ���������ǿ���Ͷ�ţ�����֤����ܻ�������ݶ���ˮ�棬���λ���£�  by Ducky�Ώͻ�");
	return;
end

function CastleAttackNPC_GameOver()
	if (MonsterAttackStart==0) then return end
	for i = 1,table.getn(CastleAttackMonPtr) do
		NL.DelNpc(CastleAttackMonPtr[i][1]);
	end
	MSG("[�����ʳ�]����" .. CastleAttackMonName .."�ڷ����Ǵ���һ������в�������İ�ȫ���ɳ�����������������" .. CastleAttackMonName .."һ���򾡡�  by Ducky�Ώͻ�");
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
	Char.SetData(_MePtr, %����_����%, NewMonsterImage);
	Char.SetData(_MePtr, %����_ԭ��%, NewMonsterImage); 
	Char.SetData(_MePtr, %����_��ͼ%, NewMapPos[SelectMapPos][1]);
	Char.SetData(_MePtr, %����_X%, NewMapPos[SelectMapPos][2]);
	Char.SetData(_MePtr, %����_Y%, NewMapPos[SelectMapPos][3]);
	Char.SetData(_MePtr, %����_����%, 4);
	Char.SetData(_MePtr, %����_ԭ��%, CastleAttackMonName);
	--NLG.UpChar(_MePtr);

	if (Char.SetTalkedEvent(nil, "CastleAttackMon_Talked", _MePtr) < 0) then
		print("CastleAttackMon_Talked ע���¼�ʧ�ܡ�");
		return false;
	end
	
	if (Char.SetWindowTalkedEvent(nil, "CastleAttackMon_WindowTalked", _MePtr) < 0) then
		print("CastleAttackMon_WindowTalked ע���¼�ʧ�ܡ�");
		return false;
	end
	
	if (Char.SetPostOverEvent(nil, "CastleAttackMon_PostOver", _MePtr) < 0) then
		print("CastleAttackMon_PostOver ע���¼�ʧ�ܡ�");
		return false;
	end

--��Ӧѭ���¼�
	if (Char.SetLoopEvent(nil,"CastleAttackMon_Loop",_MePtr,4000) < 0) then
		print("CastleAttackMon_Loop ע���¼�ʧ�ܡ�");
		return false;
	end
	
	MSG("һ���̿�͵͵Ǳ�뷨����...  by Ducky�Ώͻ�");

	return true;
end



function CastleAttackMon_PostOver( _MePtr, _TalkPtr)
	NLG.TalkToCli( _TalkPtr, _MePtr, "��������������", 1, 3);
	--NLG.TalkToCli( GetTeamIndex(_TalkPtr,1), "��������������", 5, 3, _MePtr);
	--NLG.TalkToCli( GetTeamIndex(_TalkPtr,2), "��������������", 5, 3, _MePtr);
	--NLG.TalkToCli( GetTeamIndex(_TalkPtr,3), "��������������", 5, 3, _MePtr);
	--NLG.TalkToCli( GetTeamIndex(_TalkPtr,4), "��������������", 5, 3, _MePtr);
	--CreateBattle(_TalkPtr, _MePtr);
	CastleAttackMon_CreateBattle(_TalkPtr, _MePtr);
	return;
end


function CastleAttackMon_Talked( _MePtr, _TalkPtr)

	if(NLG.CheckInFront(_TalkPtr, _MePtr, 1) == false) then
		return ;
	end 
	
	NLG.TalkToCli( _TalkPtr, _MePtr, "��������������", 1, 3);
	--NLG.TalkToCli( GetTeamIndex(_TalkPtr,1), "��������������", 5, 3, _MePtr);
	--NLG.TalkToCli( GetTeamIndex(_TalkPtr,2), "��������������", 5, 3, _MePtr);
	--NLG.TalkToCli( GetTeamIndex(_TalkPtr,3), "��������������", 5, 3, _MePtr);
	--NLG.TalkToCli( GetTeamIndex(_TalkPtr,4), "��������������", 5, 3, _MePtr);
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
		MSG("[�����ʳ�]��һ���̿ʹ����˻ʳǣ���������ʮ����ִ����Ķ���...  by Ducky�Ώͻ�" .. MonsterAttackGameLift);
		if (MonsterAttackGameLift<6) then MSG("[�����ʳ�]���д����̿ʹ���ʳǣ��뾡�����𣬷����ɳ������������������...  by Ducky�Ώͻ�") end
		return;
	end
	
	local intMap = Char.GetData(_MePtr, %����_��ͼ%);
	local intX = Char.GetData(_MePtr, %����_X%);
	local intY = Char.GetData(_MePtr, %����_Y%);
	
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
		MSG("[�����ʳ�]" .. _MePtr .. "����̽�ӻر�����һ���̿���" .. Char.GetData(_MePtr, 4) .. "," .. Char.GetData(_MePtr, 5) .. "," .. Char.GetData(_MePtr, 6) .. "����Ǳ����������������ǡ�  by Ducky�Ώͻ�");
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
	MSG("[�����ʳ�]һ���̿ͱ� " .. Char.GetData(TM_PlayerPtr0,2000) .. " �����ˣ�  by Ducky�Ώͻ�");
	NLG.SetAction(TM_PlayerPtr0,18);
	NLG.UpChar(TM_PlayerPtr0);
	return ;
end

function CastleAttackGift_Init( _MePtr )
	Char.SetData(_MePtr, %����_����%, CastleAttackGiftImage);
	Char.SetData(_MePtr, %����_ԭ��%, CastleAttackGiftImage); 
	Char.SetData(_MePtr, %����_��ͼ%, MonsterAttackMapA);
	Char.SetData(_MePtr, %����_X%, math.random(50,200));
	Char.SetData(_MePtr, %����_Y%, math.random(50,200));
	Char.SetData(_MePtr, %����_����%, 4);
	Char.SetData(_MePtr, %����_ԭ��%, CastleAttackGiftName);

	if (Char.SetTalkedEvent(nil, "CastleAttackGift_Talked", _MePtr) < 0) then
		print("CastleAttackGift_Talked ע���¼�ʧ�ܡ�");
		return false;
	end
	
	if (Char.SetLoopEvent(nil,"CastleAttackGift_Loop",_MePtr,60000) < 0) then
		print("CastleAttackGift_Loop ע���¼�ʧ�ܡ�");
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
			MSG("[�����ʳ�]" .. _MePtr .. "����һ��������" .. Char.GetData(_MePtr, 4) .. "," .. Char.GetData(_MePtr, 5) .. "," .. Char.GetData(_MePtr, 6) .. "������  by Ducky�Ώͻ�");
		end
	end
end

function WalkToPos(intMePtr, intPosX, intPosY, rtSub)
	if (intPosX<0 or intPosX==nil or intPosY<0 or intPosY==nil or rtSub=='' or rtSub==nil or intMePtr=='' or intMePtr==nil) then
		return "Error Pos";
	end

	local mePosMap = Char.GetData(intMePtr, %����_��ͼ%);
	local mePosX = Char.GetData(intMePtr, %����_X%);
	local mePosY = Char.GetData(intMePtr, %����_Y%);
	local TM_Dir = -1;
	
	if (string.lower(rtSub)=='distance' or rtSub=='����') then
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
	
	if (string.lower(rtSub)=='dir' or rtSub=='����') then
		return TM_Dir;
	elseif (string.lower(rtSub)=='walk' or rtSub=='�߶�') then
		NLG.WalkMove(intMePtr,TM_Dir);
	elseif (string.lower(rtSub)=='warp' or rtSub=='˲��') then
		NLG.Warp(intMePtr, 0, mePosMap, intPosX, intPosY);
	end
	
end

CastleAttackNPC_GameInit()
CastleAttackNPC_Create()