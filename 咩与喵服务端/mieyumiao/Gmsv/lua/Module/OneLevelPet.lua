Delegate.RegDelBattleStartEvent("OneLevelPet_BattleStart");

--ս����ʼȫ���¼�
function OneLevelPet_BattleStart(_battle)
	if (Battle.GetGainMode(_battle)==%ս��_��ͨ% and Battle.GetType(_battle)==%ս��_��ͨ%) then
		battleTimeDB[_battle+1] = os.time();
		for i=10,19 do
			local enemy = Battle.GetPlayer(_battle, i);
			if(enemy>0)then
				battleSeqDB[_battle+1] = battleSeqDB[_battle+1] .. Char.GetData(enemy, %����_����%) .. "|"
				if(isLevelOnePet(enemy)==true)then
					for l=0,4 do
						local player = Battle.GetPlayer(_battle,l);
						if(player~=0)then
							print("[����һ���������]����һ������� "..Char.GetData(enemy,%����_����%).." �����!")
							NLG.SystemMessage(player,"[����һ���������]����һ������� "..Char.GetData(enemy,%����_����%).." �����!");
						end
					end
				end
			else
				battleSeqDB[_battle+1] = battleSeqDB[_battle+1].."|";
			end
		end
	end

	return;
end